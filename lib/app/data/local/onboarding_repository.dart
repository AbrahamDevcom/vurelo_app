abstract class OnboardingRepository {
  /// Devuelve `true` si el usuario ya vio el onboarding.
  Future<bool> hasSeenOnboarding();

  /// Marca que ya vio el onboarding.
  Future<void> setSeenOnboarding();
}
