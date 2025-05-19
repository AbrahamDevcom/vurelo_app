import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vurelo/app/ui/theme/app_colors.dart';
import '../../../domain/enums/auth_method.dart';
import '../../global_widgets/stepper_indicator.dart';
import '../../routes/app_pages.dart';
import 'controller/auth_controller.dart';
import 'widgets/social_button.dart';

class RegistrationScreen extends GetView<AuthController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepperIndicator(
                currentStep: 0,
              ),
              SizedBox(height: 8),
              Text(
                "Crear cuenta",
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),
              Text(
                controller.authMethod.value == AuthMethod.phone
                    ? "Esto apenas comienza... y tu cuenta también"
                    : "Bienvenido a tu nueva forma de manejar tu dinero digital",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 32),
              if (controller.authMethod.value == AuthMethod.phone) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Row(
                    children: [
                      // Country code selector
                      GestureDetector(
                        onTap: () => controller.openCountrySelector(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 14.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: AssetImage(
                                    controller.selectedCountry.value.flag),
                              ),
                              const SizedBox(width: 8),
                              Text(controller.selectedCountry.value.code,
                                  style: TextStyle(fontSize: 16)),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '324 649 7826',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Text(
                  "Ingresa tu correo",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '324 649 7826',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.showAcceptanceSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Separator
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 1),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('o continuar con:',
                        style: TextStyle(color: Colors.black54)),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade400, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Social buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Email
                  SocialButton(
                    icon: controller.authMethod.value == AuthMethod.phone
                        ? Icons.email_outlined
                        : Icons.phone_android_rounded,
                    onTap: controller.toggleMethod,
                  ),
                  // Google
                  SocialButton(
                    icon: Icons.g_mobiledata,
                    imageAsset: "assets/google_logo.png",
                    onTap: () {},
                  ),
                  // Apple
                  SocialButton(
                    icon: Icons.apple,
                    onTap: () {},
                  ),
                ],
              ),
              const Spacer(),
              // Bottom text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Nos conocemos de antes? ',
                      style: TextStyle(color: Colors.black54)),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.register);
                    },
                    child: Text(
                      'Entra por aquí',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
