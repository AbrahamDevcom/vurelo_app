import 'package:get/get.dart';
import 'package:vurelo/app/data/local/onboarding_repository.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final OnboardingRepository _repo;

  SplashController(this._repo);

  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 2));

    final seen = await _repo.hasSeenOnboarding();
    if (seen) {
      Get.offAllNamed(Routes.launch);
    } else {
      await _repo.setSeenOnboarding();
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
