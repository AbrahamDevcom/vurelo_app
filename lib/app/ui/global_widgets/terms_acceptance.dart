import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vurelo/app/ui/global_controller/global_controller.dart';

class TermsAcceptanceBottomSheet extends StatelessWidget {
  TermsAcceptanceBottomSheet({super.key});

  // Initialize the controller
  final GlobalController controller = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle indicator at the top
          Center(
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title and description
          const Text(
            'Revisa y acepta para continuar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Queremos que tengas el control total de tu información. Léelo con calma, es corto y sin letra pequeña escondida.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Terms and conditions checkbox
          _buildCheckboxRow(
            'Acepto los ',
            'Términos y Condiciones',
            () => controller.toggleTerms(),
            () => _showTerms(context),
            controller.termsAccepted,
          ),
          const SizedBox(height: 16),

          // Privacy policy checkbox
          _buildCheckboxRow(
            'Acepto la ',
            'Política de Privacidad',
            () => controller.togglePrivacy(),
            () => _showPrivacyPolicy(context),
            controller.privacyAccepted,
          ),
          const SizedBox(height: 24),

          // Continue button
          Obx(() => _buildContinueButton(
                context,
                controller.canContinue,
              )),
        ],
      ),
    );
  }

  Widget _buildCheckboxRow(
    String prefix,
    String linkText,
    VoidCallback onCheckboxTap,
    VoidCallback onLinkTap,
    RxBool isChecked,
  ) {
    return Row(
      children: [
        // Custom checkbox
        Obx(() => GestureDetector(
              onTap: onCheckboxTap,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isChecked.value ? Colors.indigo : Colors.grey,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(4),
                  color: isChecked.value ? Colors.indigo : Colors.transparent,
                ),
                child: isChecked.value
                    ? const Icon(Icons.check, size: 18, color: Colors.white)
                    : null,
              ),
            )),
        const SizedBox(width: 12),

        // Text with clickable link
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              children: [
                TextSpan(text: prefix),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: onLinkTap,
                    child: Text(
                      linkText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context, bool isEnabled) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
                // Close bottom sheet and continue with the flow
                Navigator.pop(context, true);
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.indigo.withOpacity(0.5),
          disabledForegroundColor: Colors.white70,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Continuar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  void _showTerms(BuildContext context) {
    // Show terms and conditions
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const SingleChildScrollView(
          child: Text(
            'Aquí irían los términos y condiciones completos del servicio...',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    // Show privacy policy
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Política de Privacidad'),
        content: const SingleChildScrollView(
          child: Text(
            'Aquí iría la política de privacidad completa del servicio...',
            style: TextStyle(height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
