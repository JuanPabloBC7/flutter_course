import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_course/core/services/local_notification_service.dart';

/// Handler para mensajes recibidos en background/terminated.
/// Debe ser una función top-level (no dentro de una clase).
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('📩 Push received in background: ${message.notification?.title}');
}

/// Servicio de Push Notifications con Firebase Cloud Messaging.
///
/// Funcionalidades:
/// - Solicita permisos al usuario
/// - Obtiene el FCM token (necesario para enviar push desde Firebase Console)
/// - Escucha mensajes en foreground y los muestra como local notification
/// - Registra handler para background
class PushNotificationService {
  static final PushNotificationService _instance =
      PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _initialized = false;

  // UID del usuario autenticado actualmente. Se usa para persistir el token
  // cuando FCM lo refresca mientras hay sesión activa.
  String? _currentUserId;

  /// Inicializa el servicio de push notifications.
  /// Debe llamarse después de Firebase.initializeApp().
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    // Registrar handler para mensajes en background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Solicitar permisos (iOS muestra un alert, Android lo concede automáticamente)
    await _requestPermissions();

    // Obtener y mostrar el FCM token
    await _getToken();

    // Escuchar mensajes en foreground
    _listenForegroundMessages();

    // Escuchar cuando el usuario toca la notificación
    _listenNotificationTap();
  }

  /// Solicita permisos de notificación.
  Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    debugPrint('🔔 Push permission status: ${settings.authorizationStatus}');
  }

  /// Obtiene el FCM token del dispositivo.
  /// Este token es el que se usa en Firebase Console para enviar push
  /// a un dispositivo específico.
  Future<void> _getToken() async {
    try {
      // La verificación de APNs aplica solo en iOS. En Android getAPNSToken()
      // siempre retorna null, por lo que no se debe usar como guarda ahí.
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        // En iOS, esperar a que el APNs token esté disponible
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null) {
          debugPrint('⚠️ APNs token not available (iOS simulator or no Apple Developer account)');
          debugPrint('   Push notifications will not work on iOS until APNs is configured.');
          return;
        }
      }

      final token = await _messaging.getToken();
      debugPrint('═══════════════════════════════════════════');
      debugPrint('📱 FCM Token: $token');
      debugPrint('═══════════════════════════════════════════');
      debugPrint('👆 Usa este token en Firebase Console → Messaging');
      debugPrint('   para enviar un push a este dispositivo.');

      // Escuchar cambios de token (por refresh)
      _messaging.onTokenRefresh.listen((newToken) {
        debugPrint('🔄 FCM Token refreshed: $newToken');
        // Si hay una sesión activa, persistir el nuevo token en Firestore
        final uid = _currentUserId;
        if (uid != null) {
          _persistToken(uid, newToken);
        }
      });
    } catch (e) {
      debugPrint('⚠️ Could not get FCM token: $e');
      debugPrint('   This is expected on iOS simulator without APNs configuration.');
    }
  }

  /// Escucha mensajes que llegan mientras la app está en foreground.
  /// Los muestra como local notification para que sean visibles.
  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('📩 Push received in foreground: ${message.notification?.title}');

      final notification = message.notification;
      if (notification != null) {
        // Mostrar como local notification para que aparezca en la barra del sistema
        LocalNotificationService().show(
          title: notification.title ?? 'BAM Wallet',
          body: notification.body ?? '',
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        );
      }
    });
  }

  /// Escucha cuando el usuario toca una notificación (app en background/terminated).
  void _listenNotificationTap() {
    // Cuando la app estaba en background y el usuario toca la notificación
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('👆 Notification tapped: ${message.notification?.title}');
      // Aquí podrías navegar a una pantalla específica
    });

    // Verificar si la app se abrió desde una notificación (estaba terminated)
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        debugPrint('🚀 App opened from notification: ${message.notification?.title}');
      }
    });
  }

  /// Guarda el FCM token del dispositivo en Firestore para el usuario dado.
  ///
  /// Debe llamarse tras un login exitoso. El documento en la colección `users`
  /// se identifica por el campo `userId` (no por el ID del documento), por eso
  /// se busca/actualiza el documento donde `userId == uid`.
  ///
  /// Es best-effort: si algo falla, se registra pero no interrumpe el flujo.
  Future<void> saveTokenForUser(String uid) async {
    // Recordar el uid para persistir futuros refresh de token
    _currentUserId = uid;

    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) {
        debugPrint('⚠️ FCM token not available yet; skipping Firestore save.');
        return;
      }
      await _persistToken(uid, token);
    } catch (e) {
      debugPrint('⚠️ Could not save FCM token for user $uid: $e');
    }
  }

  /// Limpia el uid en memoria (por ejemplo, al cerrar sesión).
  void clearCurrentUser() {
    _currentUserId = null;
  }

  /// Persiste el token en el documento de `users` donde `userId == uid`.
  Future<void> _persistToken(String uid, String token) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('userId', isEqualTo: uid)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        debugPrint('⚠️ No user document found with userId == $uid; token not saved.');
        return;
      }

      // Actualizar el fcmToken en el documento encontrado
      await snapshot.docs.first.reference.update({'fcmToken': token});
      debugPrint('✅ FCM token saved to Firestore for user $uid');
    } catch (e) {
      debugPrint('⚠️ Could not persist FCM token for user $uid: $e');
    }
  }
}
