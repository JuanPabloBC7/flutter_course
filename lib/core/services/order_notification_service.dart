import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/core/constants/Theme.dart';
import 'package:flutter_course/core/providers/role_provider.dart';

/// Servicio de notificaciones in-app para órdenes de compra.
///
/// Usa Firestore Streams para escuchar nuevas órdenes en tiempo real:
/// - Admin: escucha TODAS las órdenes nuevas
/// - User: escucha solo SUS propias órdenes nuevas
class OrderNotificationService {
  StreamSubscription<QuerySnapshot>? _subscription;
  bool _isFirstSnapshot = true;

  /// Inicia el stream de escucha de órdenes.
  /// Debe llamarse después de la autenticación.
  void startListening({
    required UserRole role,
    required GlobalKey<ScaffoldMessengerState> messengerKey,
  }) {
    // Cancelar stream anterior si existe
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

  /// Muestra la notificación in-app como un MaterialBanner.
  void _showNotification(
    GlobalKey<ScaffoldMessengerState> messengerKey,
    String message,
  ) {
    messengerKey.currentState?.showMaterialBanner(
      MaterialBanner(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ArgonColors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.shopping_bag_rounded,
            color: ArgonColors.success,
            size: 20,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ArgonColors.text,
          ),
        ),
        backgroundColor: ArgonColors.white,
        elevation: 4,
        actions: [
          TextButton(
            onPressed: () {
              messengerKey.currentState?.hideCurrentMaterialBanner();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: ArgonColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    // Auto-dismiss después de 5 segundos
    Future.delayed(const Duration(seconds: 5), () {
      messengerKey.currentState?.hideCurrentMaterialBanner();
    });
  }

  /// Detiene el stream de escucha.
  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}
