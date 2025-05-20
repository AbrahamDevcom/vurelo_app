import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../global_widgets/stepper_indicator.dart';
import '../../theme/app_colors.dart';
import 'controller/auth_controller.dart';

class PasswordOtpScreen extends GetView<AuthController> {
  const PasswordOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: () => Get.back())),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperIndicator(
                currentStep: 2,
              ),
              SizedBox(height: 8),
              Text(
                "Iniciar sesión",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Ingresa tu clave de 6 dígitos",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 32),

              // === PIN INPUT ===
              PinCodeTextField(
                appContext: context,
                length: 6,
                autoFocus: true,
                obscureText: true,
                obscuringWidget: Text(
                  "*",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: controller.hasError.value
                        ? AppColors.error
                        : AppColors.primary,
                    //height: 1.1,
                  ),
                ),
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: AppColors.otpBorder,
                  inactiveFillColor: AppColors.otpBg,
                  activeColor: controller.hasError.value
                      ? AppColors.errorBorder
                      : AppColors.primary,
                  activeFillColor: controller.hasError.value
                      ? AppColors.errorBg
                      : AppColors.secondary,
                  selectedColor: controller.hasError.value
                      ? AppColors.error
                      : AppColors.primary,
                  selectedFillColor: controller.hasError.value
                      ? AppColors.errorBg
                      : AppColors.secondary,
                ),
                cursorColor: controller.hasError.value
                    ? AppColors.error
                    : AppColors.primary,
                enableActiveFill: true,
                onChanged: (_) {
                  if (controller.hasError.value) {
                    controller.hasError.value = false;
                  }
                },
                onCompleted: controller.verifyPasswordOtp,
              ),

              if (controller.hasError.value) const SizedBox(height: 8),
              if (controller.hasError.value)
                Center(
                  child: Text(
                    "Contraseña incorrecta intente de nuevo",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Olvidé mi clave",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.black, thickness: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('o ingresar con:',
                        style: TextStyle(color: Colors.black)),
                  ),
                  Expanded(
                    child: Divider(color: Colors.black, thickness: 1),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondary,
                      border: Border.all(width: 1, color: AppColors.primary)),
                  child: Image.asset("assets/huella.png"),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  "Huella",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
