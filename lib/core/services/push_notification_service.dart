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
  bool _initialized = false;

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
    final token = await _messaging.getToken();
    debugPrint('═══════════════════════════════════════════');
    debugPrint('📱 FCM Token: $token');
    debugPrint('═══════════════════════════════════════════');
    debugPrint('👆 Usa este token en Firebase Console → Messaging');
    debugPrint('   para enviar un push a este dispositivo.');

    // Escuchar cambios de token (por refresh)
    _messaging.onTokenRefresh.listen((newToken) {
      debugPrint('🔄 FCM Token refreshed: $newToken');
    });
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
}
