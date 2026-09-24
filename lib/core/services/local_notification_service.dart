import 'package:flutter_course/core/routing/app_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Servicio de notificaciones locales del sistema.
///
/// Muestra notificaciones nativas del dispositivo (barra de notificaciones)
/// cuando se realizan acciones importantes como compras.
/// Al tocar la notificación de una compra, navega al detalle de la orden.
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

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
    _initialized = true;

    // Solicitar permisos en iOS
    await _requestPermissions();
  }

  /// Callback cuando el usuario toca la notificación.
  /// Si el payload contiene un orderId, navega al detalle de la orden.
  void _onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      // Navegar al detalle de la orden usando GoRouter
      AppRouter.router.push('${AppRouter.orderDetail}/$payload');
    }
  }

  /// Solicita permisos de notificación en iOS.
  Future<void> _requestPermissions() async {
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  /// Muestra una notificación local inmediata.
  /// [payload] se pasa al callback cuando el usuario toca la notificación.
  Future<void> show({
    required String title,
    required String body,
    int id = 0,
    String? payload,
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
      payload: payload,
    );
  }

  /// Notificación específica para cuando se realiza una compra.
  /// El [orderId] se usa como payload para navegar al detalle al tocarla.
  Future<void> showOrderPlaced({
    required int itemCount,
    required String total,
    required String orderId,
  }) async {
    await show(
      title: 'BAM Wallet',
      body: 'Your order was placed! $itemCount items - \$$total',
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      payload: orderId,
    );
  }
}
