import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../domain/enums/auth_method.dart';
import '../../global_widgets/stepper_indicator.dart';
import '../../theme/app_colors.dart';
import 'controller/auth_controller.dart';

class OtpScreen extends GetView<AuthController> {
  const OtpScreen({super.key});

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
                currentStep: 1,
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
                "Verifica tu identidad",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 8),
              Text(
                controller.authMethod.value == AuthMethod.phone
                    ? "Enviamos un código al teléfono"
                    : "Enviamos un código a tu correo",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                controller.authMethod.value == AuthMethod.phone
                    ? "+57 ${controller.phone.value}"
                    : controller.email.value,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),

              // === PIN INPUT ===
              PinCodeTextField(
                appContext: context,
                length: 6,
                autoFocus: true,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  inactiveColor: Color(0xffC3C9FC),
                  inactiveFillColor: Color(0x7EE9ECFD),
                  activeColor: AppColors.primary,
                  activeFillColor: AppColors.secondary,
                  selectedColor: AppColors.primary,
                  selectedFillColor: AppColors.secondary,
                ),
                cursorColor: AppColors.primary,
                enableActiveFill: true,
                onChanged: (_) {},
                onCompleted: controller.verifyOtp,
              ),

              SizedBox(height: 24),

              // === REENVIAR O TEMPORIZADOR ===
              Center(
                child: controller.secondsLeft.value > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Reenviar código en ',
                              style: TextStyle(color: Colors.black)),
                          Text(
                            '00:${controller.secondsLeft.value.toString().padLeft(2, '0')}',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    : OutlinedButton(
                        onPressed: controller.resendCode,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primary, width: 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "Reenviar código",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
