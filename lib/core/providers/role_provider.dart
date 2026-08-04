import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Roles disponibles en la aplicación.
enum UserRole {
  admin,
  user,
}

/// Provider que obtiene el rol del usuario actual desde Firestore.
/// Lee el documento en la colección `users` donde `userId == uid`.
final userRoleProvider = FutureProvider<UserRole>((ref) async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return UserRole.user;

  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('userId', isEqualTo: uid)
      .limit(1)
      .get();

  if (snapshot.docs.isEmpty) return UserRole.user;

  final role = snapshot.docs.first.data()['role'] as String? ?? 'user';

  switch (role) {
    case 'admin':
      return UserRole.admin;
    default:
      return UserRole.user;
  }
});

/// Provider que indica si el usuario actual es admin.
final isAdminProvider = Provider<bool>((ref) {
  final roleAsync = ref.watch(userRoleProvider);
  return roleAsync.valueOrNull == UserRole.admin;
});
