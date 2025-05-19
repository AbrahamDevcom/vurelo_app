import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../domain/enums/auth_method.dart';
import 'controller/auth_controller.dart';

class OtpScreen extends GetView<AuthController> {
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
              Text("Iniciar sesión", style: TextStyle(color: Colors.blue)),
              SizedBox(height: 8),
              Text("Verifica tu identidad",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                controller.authMethod.value == AuthMethod.phone
                    ? "Enviamos un código al teléfono\n+57 ${controller.phone.value}"
                    : "Enviamos un código a tu correo\n${controller.email.value}",
                style: TextStyle(color: Colors.grey[600]),
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
                ),
                enableActiveFill: true,
                onChanged: (_) {},
                onCompleted: controller.verifyOtp,
              ),

              SizedBox(height: 24),

              // === REENVIAR O TEMPORIZADOR ===
              Center(
                child: controller.secondsLeft.value > 0
                    ? Text(
                        "Reenviar código en 00:${controller.secondsLeft.value.toString().padLeft(2, '0')}",
                        style: TextStyle(color: Colors.grey[700]),
                      )
                    : TextButton(
                        onPressed: controller.resendCode,
                        child: Text("Reenviar código"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
