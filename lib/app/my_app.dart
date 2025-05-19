import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:vurelo/app/ui/theme/app_colors.dart';

import 'ui/global_controller/global_binding.dart';
import 'ui/routes/app_pages.dart';
import 'utils/app_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        title: AppConstants.appName,
        locale: const Locale('es', 'ES'),
        debugShowCheckedModeBanner: false,
        getPages: AppPages.routes,
        initialRoute: Routes.splash,
        initialBinding: GlobalBinding(),
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
