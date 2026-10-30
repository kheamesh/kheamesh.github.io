import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/navbar/navbar.dart';
import '../../widgets/hero/hero_section.dart';
import '../../widgets/about/about_section.dart';
import '../../widgets/experience/experience_section.dart';
import '../../widgets/projects/projects_section.dart';
import '../../widgets/skills/skills_section.dart';
import '../../widgets/services/services_section.dart';
import '../../widgets/process/process_section.dart';
import '../../widgets/achievements/achievements_section.dart';
import '../../widgets/contact/contact_section.dart';
import '../../widgets/footer/footer_section.dart';
import '../../widgets/background/premium_background.dart';
import '../../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: PremiumBackground(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: section(controller),
            ),
            Navbar(onNavTap: controller.onNavTap),
          ],
        ),
      ),
    );
  }
}

Widget section(HomeController controller) {
  return Column(
    children: [
      RepaintBoundary(child: HeroSection(key: controller.heroKey)),
      RepaintBoundary(child: AboutSection(key: controller.aboutKey)),
      const RepaintBoundary(child: AchievementsSection()),
      RepaintBoundary(child: ExperienceSection(key: controller.experienceKey)),
      RepaintBoundary(child: ProjectsSection(key: controller.projectsKey)),
      RepaintBoundary(child: SkillsSection(key: controller.skillsKey)),
      const RepaintBoundary(child: ProcessSection()),
      RepaintBoundary(child: ServicesSection(key: controller.servicesKey)),
      RepaintBoundary(child: ContactSection(key: controller.contactKey)),
      const RepaintBoundary(child: FooterSection()),
    ],
  );
}
