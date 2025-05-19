import 'package:flutter/material.dart';
import 'package:vurelo/app/ui/theme/app_colors.dart';

class StepperIndicator extends StatelessWidget {
  const StepperIndicator({
    super.key,
    required this.currentStep,
  });
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children: List.generate(
        3,
        (indx) => Container(
          width: currentStep == indx ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius:
                currentStep == indx ? BorderRadius.circular(16) : null,
            shape: currentStep == indx ? BoxShape.rectangle : BoxShape.circle,
            color: currentStep == indx ? AppColors.primary : AppColors.accent1,
          ),
        ),
      ),
    );
  }
}
