import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vurelo/app/ui/global_controller/global_controller.dart';
import 'package:vurelo/app/ui/screens/auth/otp_screen.dart';

import '../../../../domain/enums/auth_method.dart';
import '../../../../domain/models/country_model.dart';
import '../../../global_widgets/country_selector.dart';
import '../../../global_widgets/terms_acceptance.dart';
import '../../../theme/app_colors.dart';

class AuthController extends GetxController {
  final GlobalController globalController = GlobalController();
  final otpController = TextEditingController();
  final RxInt secondsLeft = 30.obs;
  var authMethod = AuthMethod.phone.obs;
  Timer? _timer;
  var phone = ''.obs;
  var email = ''.obs;
  var otp = ''.obs;

  final RxBool termsAccepted = false.obs;
  final RxBool privacyAccepted = false.obs;

  // Check if both conditions are accepted
  bool get canContinue => termsAccepted.value && privacyAccepted.value;

  // Toggle methods

  final Rx<Country> selectedCountry = Country(
    name: 'Colombia',
    code: '+57',
    flag: 'assets/co.png',
  ).obs;

  // Method to update selected country
  void updateSelectedCountry(Country country) {
    selectedCountry.value = country;
  }

  void openCountrySelector(BuildContext context) async {
    final countrySelected = await showModalBottomSheet<Country>(
      context: context,
      barrierColor: AppColors.accent1,
      isScrollControlled: true,
      builder: (context) => CountrySelectorBottomSheet(),
    );
    if (countrySelected != null) {
      updateSelectedCountry(countrySelected);
    }
  }

  void showAcceptanceSheet(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      barrierColor: AppColors.accent1,
      builder: (context) => TermsAcceptanceBottomSheet(),
    );

    if (result == true) {
      // Both checkboxes were accepted and the continue button was pressed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Términos aceptados correctamente')),
      );
    }
  }

  void toggleTerms() {
    termsAccepted.value = !termsAccepted.value;
  }

  void togglePrivacy() {
    privacyAccepted.value = !privacyAccepted.value;
  }

  void toggleMethod() {
    authMethod.value = authMethod.value == AuthMethod.phone
        ? AuthMethod.email
        : AuthMethod.phone;
  }

  void submitLogin() {
    // Simula envío de código
    Get.to(() => OtpScreen());
    _startTimer();
  }

  void verifyOtp(String code) {
    otp.value = code;
    // Validar OTP real aquí
    print("Código ingresado: $code");
  }

  void resendCode() {
    // Reenvías el código (API / servicio OTP)...
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    secondsLeft.value = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
