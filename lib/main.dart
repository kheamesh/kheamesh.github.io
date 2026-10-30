import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';
import 'screens/home/home_screen.dart';
import 'controllers/contact_controller.dart';
import 'controllers/pdf_controller.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    debugPrint('Firebase initialization warning: $e');
  }

  Get.put(ThemeController());
  Get.put(PdfController());
  Get.put(ContactController());

  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => GetMaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode,
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      home: const HomeScreen(),
    ));
  }
}
