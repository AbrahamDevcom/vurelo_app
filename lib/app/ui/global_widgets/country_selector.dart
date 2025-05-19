import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vurelo/app/ui/global_controller/global_controller.dart';

import '../../data/local/countries.dart';
import '../../domain/models/country_model.dart';

class CountrySelectorBottomSheet extends GetView<GlobalController> {
  const CountrySelectorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle indicator
          Container(
            width: 60,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 20),
          // Title
          const Text(
            'Selecciona tu país',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // List of countries
          ...countries.map((country) => _buildCountryItem(context, country)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCountryItem(BuildContext context, Country country) {
    return Obx(() {
      final isSelected = controller.selectedCountry.value.name == country.name;

      return InkWell(
        onTap: () {
          //controller.updateSelectedCountry(country);
          //Navigator.pop(context, country);
          Get.back(result: country);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              // Country flag
              CircleAvatar(
                backgroundImage: AssetImage(country.flag),
                // For demonstration, we'll use the first letter as a placeholder
              ),
              const SizedBox(width: 16),
              // Country name and code
              Expanded(
                child: Text(
                  '${country.name} (${country.code})',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Selection indicator
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 24,
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
