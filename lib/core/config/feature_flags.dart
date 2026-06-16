/// Centralized feature flags for the application.
///
/// Toggle these values to enable/disable features across the app.
class FeatureFlags {
  FeatureFlags._();

  /// Authentication provider to use.
  /// - `true` = Firebase Auth (email/password)
  /// - `false` = DummyJSON API or local mock
  static const bool useFirebaseAuth = true;
  /// Set to `true` to use the real dummyJSON API for authentication.
  /// Set to `false` to use local mock data (no internet required).
  /// Only applies when useFirebaseAuth is false.
  static const bool useDummyJsonApi = false;

  /// Set to `true` to show on boarding only once.
  /// Set to `false` to show on boarding always.
  static const bool useOnboardingLogic = false;
}
