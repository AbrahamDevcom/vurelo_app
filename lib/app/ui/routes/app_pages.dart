import 'package:get/get.dart';
import 'package:vurelo/app/ui/screens/auth/launch_screen.dart';
import 'package:vurelo/app/ui/screens/auth/otp_screen.dart';

import 'barrel_routes.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.launch,
      page: () => LaunchScreen(),
      binding: AuthBinding(),
      children: [
        GetPage(
          name: Routes.login,
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: Routes.otp,
          page: () => OtpScreen(),
        ),
        GetPage(
          name: Routes.password,
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: Routes.register,
          page: () => RegistrationScreen(),
          binding: AuthBinding(),
        ),
      ],
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    )
  ];
}
