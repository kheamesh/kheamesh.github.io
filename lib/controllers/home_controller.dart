import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final heroKey = GlobalKey();
  final aboutKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final servicesKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  void onNavTap(int index) {
    switch (index) {
      case 0: scrollToSection(heroKey); break;
      case 1: scrollToSection(aboutKey); break;
      case 2: scrollToSection(experienceKey); break;
      case 3: scrollToSection(projectsKey); break;
      case 4: scrollToSection(skillsKey); break;
      case 5: scrollToSection(servicesKey); break;
      case 6: scrollToSection(contactKey); break;
    }
  }
}
