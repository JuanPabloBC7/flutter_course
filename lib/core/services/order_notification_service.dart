import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/core/providers/role_provider.dart';
import 'package:flutter_course/core/widgets/top_notification.dart';

/// Servicio de notificaciones in-app para órdenes de compra.
///
/// Usa Firestore Streams para escuchar nuevas órdenes en tiempo real:
/// - Admin: escucha TODAS las órdenes nuevas
/// - User: escucha solo SUS propias órdenes nuevas
class OrderNotificationService {
  StreamSubscription<QuerySnapshot>? _subscription;
  bool _isFirstSnapshot = true;

  /// Inicia el stream de escucha de órdenes.
  void startListening({
    required UserRole role,
    required GlobalKey<ScaffoldMessengerState> messengerKey,
  }) {
    stop();
    _isFirstSnapshot = true;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    Query query;

    if (role == UserRole.admin) {
      // Admin escucha TODAS las órdenes nuevas
      query = FirebaseFirestore.instance
          .collection('orders')
          .orderBy('date', descending: true)
          .limit(1);
    } else {
      // User escucha solo SUS órdenes
      query = FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: uid)
          .orderBy('date', descending: true)
          .limit(1);
    }

    _subscription = query.snapshots().listen((snapshot) {
      // Ignorar el primer snapshot (datos existentes)
      if (_isFirstSnapshot) {
        _isFirstSnapshot = false;
        return;
      }

      // Solo procesar cambios tipo "added"
      for (final change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          final data = change.doc.data() as Map<String, dynamic>?;
          if (data == null) continue;

          final orderUserId = data['userId'] as String? ?? '';
          final total = data['total'] as String? ?? '0.00';
          final itemCount = (data['items'] as List?)?.length ?? 0;

          // Determinar el mensaje según el rol
          String message;
          if (role == UserRole.admin && orderUserId != uid) {
            message = 'New order received! $itemCount items - \$$total';
          } else {
            message = 'Your order was placed! $itemCount items - \$$total';
          }

          _showNotification(messengerKey, message);
        }
      }
    });
  }

  /// Muestra la notificación usando el widget TopNotification.
  void _showNotification(
    GlobalKey<ScaffoldMessengerState> messengerKey,
    String message,
  ) {
    final context = messengerKey.currentContext;
    if (context == null) return;

    TopNotification.show(
      context,
      message: message,
      type: NotificationType.success,
    );
  }

  /// Detiene el stream de escucha.
  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}
