import 'package:get/get.dart';

import '../../domain/models/country_model.dart';

class GlobalController extends GetxController {
  // Observable country object
  final Rx<Country> selectedCountry = Country(
    name: 'Colombia',
    code: '+57',
    flag: 'assets/co.png',
  ).obs;

  // Method to update selected country
  void updateSelectedCountry(Country country) {
    selectedCountry.value = country;
  }

  final RxBool termsAccepted = false.obs;
  final RxBool privacyAccepted = false.obs;

  // Check if both conditions are accepted
  bool get canContinue => termsAccepted.value && privacyAccepted.value;

  // Toggle methods
  void toggleTerms() {
    termsAccepted.value = !termsAccepted.value;
  }

  void togglePrivacy() {
    privacyAccepted.value = !privacyAccepted.value;
  }
}
