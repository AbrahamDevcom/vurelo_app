import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:vurelo/app/ui/global_controller/global_controller.dart';
import 'package:vurelo/app/ui/screens/auth/otp_screen.dart';

import '../../../../domain/enums/auth_method.dart';
import '../../../../domain/models/country_model.dart';
import '../../../global_widgets/country_selector.dart';
import '../../../global_widgets/terms_acceptance.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';

class AuthController extends GetxController {
  final GlobalController globalController = GlobalController();
  final otpController = TextEditingController();
  final TextEditingController passwordOtpController = TextEditingController();
  final StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  RxBool hasError = false.obs;
  final RxInt secondsLeft = 30.obs;
  var authMethod = AuthMethod.phone.obs;
  Timer? _timer;
  var phone = ''.obs;
  var email = ''.obs;
  var otp = ''.obs;
  final RxBool termsAccepted = false.obs;
  final RxBool privacyAccepted = false.obs;
  bool get canContinue => termsAccepted.value && privacyAccepted.value;
  String correctPassword = "123456";

  final Rx<Country> selectedCountry = Country(
    name: 'Colombia',
    code: '+57',
    flag: 'assets/co.png',
  ).obs;

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
    Get.to(() => OtpScreen());
    _startTimer();
  }

  void verifyOtp(String code) {
    otp.value = code;
    Get.toNamed("${Routes.launch}${Routes.passwordotp}");
  }

  void verifyPasswordOtp(String code) {
    if (code != correctPassword) {
      errorController.add(ErrorAnimationType.shake);
      hasError.value = true;
    } else {
      hasError.value = false;
      print("Código correcto");
    }
    otp.value = code;
    Get.toNamed("${Routes.launch}${Routes.passwordotp}");
  }

  void resendCode() {
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
