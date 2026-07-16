import 'dart:convert';

import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Dashboard Data ───────────────────────────────────────────────────────────

class DashboardData {
  final Map<String, dynamic> user;
  final Map<String, dynamic> account;
  final List<Map<String, dynamic>> transactions;

  const DashboardData({
    required this.user,
    required this.account,
    required this.transactions,
  });

  /// Convierte los datos del dashboard a JSON para persistencia local.
  Map<String, dynamic> toJson() => {
    'user': user,
    'account': account,
    'transactions': transactions,
  };

  /// Crea una instancia de DashboardData a partir del JSON almacenado.
  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      user: json['user'] as Map<String, dynamic>,
      account: json['account'] as Map<String, dynamic>,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );
  }
}

// ── Dashboard Cache ──────────────────────────────────────────────────────────

/// Servicio de cache local para los datos del dashboard.
/// Persiste datos en SharedPreferences para evitar recargas innecesarias
/// y brindar soporte offline.
class DashboardCache {
  static const _cacheKey = 'dashboard_cache';
  static const _cacheTimestampKey = 'dashboard_cache_timestamp';

  /// Duración máxima del cache antes de considerarse obsoleto (5 minutos).
  static const _cacheDuration = Duration(minutes: 5);

  /// Guarda los datos del dashboard en cache local.
  static Future<void> save(DashboardData data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data.toJson());
    await prefs.setString(_cacheKey, jsonString);
    await prefs.setInt(
      _cacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  /// Recupera los datos del cache local.
  /// Retorna null si no hay cache o si expiró.
  static Future<DashboardData?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cacheKey);
    final timestamp = prefs.getInt(_cacheTimestampKey);

    if (jsonString == null || timestamp == null) return null;

    // Verificar si el cache expiró
    final cachedAt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (DateTime.now().difference(cachedAt) > _cacheDuration) return null;

    return DashboardData.fromJson(
      jsonDecode(jsonString) as Map<String, dynamic>,
    );
  }

  /// Limpia el cache local del dashboard.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
    await prefs.remove(_cacheTimestampKey);
  }
}

// ── Dashboard Provider ───────────────────────────────────────────────────────

final dashboardProvider = FutureProvider<DashboardData>((ref) async {
  // 1. Intentar cargar desde cache local
  final cached = await DashboardCache.load();
  if (cached != null) return cached;

  // 2. Si no hay cache válido, consultar servicios
  final userService = ref.read(userServiceProvider);
  final accountService = ref.read(accountServiceProvider);
  final transactionService = ref.read(transactionServiceProvider);

  final results = await Future.wait([
    userService.fetchUser(),
    accountService.fetchAccountSummary(),
    transactionService.fetchTransactions(limit: 4),
  ]);

  final data = DashboardData(
    user: results[0] as Map<String, dynamic>,
    account: results[1] as Map<String, dynamic>,
    transactions: results[2] as List<Map<String, dynamic>>,
  );

  // 3. Guardar en cache local
  await DashboardCache.save(data);

  return data;
});
