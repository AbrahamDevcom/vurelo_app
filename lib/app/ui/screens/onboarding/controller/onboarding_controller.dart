import 'package:get/get.dart';

import '../../../../domain/models/onboarding_item.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  void setPage(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      currentPage.value++;
    }
  }

  final List<OnboardingItem> pages = [
    OnboardingItem(
      title: "¡Bienvenido a la nueva era de tu dinero!",
      description:
          "Gestiona tu dinero digital sin fronteras y sin enredos.\nToma el control de tu plata y muévete sin complicaciones con Vurelo.",
      image: "assets/onboard_1.png",
    ),
    OnboardingItem(
      title: "Tu Vurelo Card, tu mundo en tus manos.",
      description:
          "Tu nueva tarjeta abre las puertas a experiencias sin límites, transacciones globales y un control total sobre tu dinero.",
      image: "assets/onboard_2.png",
    ),
    OnboardingItem(
      title: "Tu plata segura, ¡sin estrés!",
      description:
          "Con Vurelo, tu dinero digital está en buenas manos. Relájate y disfruta de mover tu plata sin preocupaciones.",
      image: "assets/onboard_3.png",
    ),
  ];
}
