import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Servicio de notificaciones locales del sistema.
///
/// Muestra notificaciones nativas del dispositivo (barra de notificaciones)
/// cuando se realizan acciones importantes como compras.
class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Inicializa el plugin de notificaciones locales.
  /// Debe llamarse una vez al iniciar la app.
  Future<void> initialize() async {
    if (_initialized) return;

    // Configuración para Android
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // Configuración para iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(settings: initSettings);
    _initialized = true;

    // Solicitar permisos en iOS
    await _requestPermissions();
  }

  /// Solicita permisos de notificación en iOS.
  Future<void> _requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Muestra una notificación local inmediata.
  Future<void> show({
    required String title,
    required String body,
    int id = 0,
  }) async {
    if (!_initialized) await initialize();

    const androidDetails = AndroidNotificationDetails(
      'ecommerce_orders',
      'E-Commerce Orders',
      channelDescription: 'Notificaciones de compras realizadas',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }

  /// Notificación específica para cuando se realiza una compra.
  Future<void> showOrderPlaced({
    required int itemCount,
    required String total,
  }) async {
    await show(
      title: 'BAM Wallet',
      body: 'Your order was placed! $itemCount items - \$$total',
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }
}
