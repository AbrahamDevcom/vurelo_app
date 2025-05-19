import 'package:get/get.dart';
import 'package:vurelo/app/data/local/onboarding_repository.dart';
import 'package:vurelo/app/data/local/onboarding_repository_impl.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingRepository>(OnboardingRepositoryImpl());
    Get.put(SplashController(Get.find()));
  }
}
