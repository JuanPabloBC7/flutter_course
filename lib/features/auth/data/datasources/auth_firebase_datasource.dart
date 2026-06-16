import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/core/network/app_exceptions.dart';

/// Firebase Authentication data source.
///
/// Handles login, logout, and session management using Firebase Auth
/// with email and password.
class AuthFirebaseDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Signs in a user with email and password.
  ///
  /// Returns a Map with user data and token on success.
  /// Throws [AppException] on failure.
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const UnauthorizedException(message: 'Login failed. No user returned.');
      }

      final token = await user.getIdToken();

      return {
        'id': user.uid,
        'username': user.displayName ?? user.email?.split('@').first ?? '',
        'email': user.email ?? '',
        'firstName': user.displayName?.split(' ').first ?? '',
        'lastName': user.displayName?.split(' ').skip(1).join(' ') ?? '',
        'accessToken': token ?? '',
        'refreshToken': user.refreshToken ?? '',
      };
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Signs out the current user.
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// Gets the currently signed-in user.
  /// Returns null if no user is signed in.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Checks if a user is currently signed in.
  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Gets a fresh ID token for the current user.
  Future<String?> refreshToken() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return user.getIdToken(true);
  }

  /// Creates a new user with email and password (for registration).
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AppException(message: 'Registration failed.');
      }

      if (displayName != null) {
        await user.updateDisplayName(displayName);
      }

      final token = await user.getIdToken();

      return {
        'id': user.uid,
        'username': displayName ?? email.split('@').first,
        'email': user.email ?? '',
        'firstName': displayName?.split(' ').first ?? '',
        'lastName': displayName?.split(' ').skip(1).join(' ') ?? '',
        'accessToken': token ?? '',
        'refreshToken': user.refreshToken ?? '',
      };
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Sends a password reset email.
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseError(e);
    }
  }

  /// Maps Firebase Auth errors to our centralized [AppException] hierarchy.
  AppException _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return const UnauthorizedException(message: 'No account found with this email.');
      case 'wrong-password':
        return const UnauthorizedException(message: 'Incorrect password.');
      case 'invalid-email':
        return const BadRequestException(message: 'The email address is invalid.');
      case 'user-disabled':
        return const ForbiddenException(message: 'This account has been disabled.');
      case 'too-many-requests':
        return const AppException(message: 'Too many attempts. Please try again later.');
      case 'email-already-in-use':
        return const BadRequestException(message: 'An account already exists with this email.');
      case 'weak-password':
        return const BadRequestException(message: 'Password is too weak. Use at least 6 characters.');
      case 'invalid-credential':
        return const UnauthorizedException(message: 'Invalid email or password.');
      default:
        return AppException(message: e.message ?? 'Authentication failed.');
    }
  }
}
