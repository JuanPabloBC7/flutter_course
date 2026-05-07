import 'package:flutter_course/core/providers/service_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Shared provider for user profile data.
/// Used by Menu, Configuration, and Profile views.
final userProfileProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final service = ref.read(userServiceProvider);
  return service.fetchUser();
});
