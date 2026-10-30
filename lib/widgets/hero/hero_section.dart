import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/pdf_controller.dart';
import '../../controllers/home_controller.dart';
import 'tech_visual.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: size.height),
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: isMobile ? Get.width * 0.15 : Get.width * 0.02,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: ResponsiveLayout(
            desktop: _buildDesktop(context),
            tablet: _buildTablet(context),
            mobile: _buildMobile(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildInfo(context)),
        SizedBox(width: Get.width * 0.02),
        Expanded(flex: 2, child: _buildVisual(context)),
      ],
    );
  }

  Widget _buildTablet(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildInfo(context)),
        SizedBox(width: Get.width * 0.02),
        Expanded(
          flex: 2,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: _buildVisual(context),
          ),
        ),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.width * 0.15),
        _buildInfo(context),
        SizedBox(height: Get.width * 0.08),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: const TechVisual(),
          ),
        ),
        SizedBox(height: Get.width * 0.12),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final useNarrowStyling = !isDesktop && !isTablet;
    const appColor = AppColors.gold;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: useNarrowStyling
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        GetBuilder<HeroHoverController>(
          init: HeroHoverController(),
          builder: (controller) {
            return MouseRegion(
              onEnter: (_) => controller.setHovered(true),
              onExit: (_) => controller.setHovered(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.all(
                  useNarrowStyling ? Get.width * 0.04 : Get.width * 0.025,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withValues(
                    alpha: controller.isHovered ? 0.6 : 0.4,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: controller.isHovered
                        ? appColor
                        : appColor.withValues(alpha: 0.2),
                    width: controller.isHovered ? 1.5 : 0.5,
                  ),
                  boxShadow: [
                    if (controller.isHovered)
                      BoxShadow(
                        color: appColor.withValues(alpha: 0.15),
                        blurRadius: 40,
                        spreadRadius: -5,
                      ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: useNarrowStyling
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        AppStrings.helloIm,
                        style: TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 4,
                          fontSize: useNarrowStyling
                              ? AppTextSizes.bodySmall
                              : AppTextSizes.bodyMedium,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.015),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 200),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: useNarrowStyling
                            ? Alignment.center
                            : Alignment.centerLeft,
                        child: Text(
                          PortfolioData.name,
                          textAlign: useNarrowStyling
                              ? TextAlign.center
                              : TextAlign.start,
                          style: TextStyle(
                            fontSize: AppTextSizes.heroTitle,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(
                              context,
                            ).textTheme.displayLarge?.color,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.008),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 400),
                      child: Text(
                        PortfolioData.role,
                        style: TextStyle(
                          fontSize: AppTextSizes.heroRole,
                          color: AppColors.goldAccent,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.02),
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 600),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          PortfolioData.shortIntro,
                          textAlign: useNarrowStyling
                              ? TextAlign.center
                              : TextAlign.start,
                          style: TextStyle(
                            fontSize: AppTextSizes.bodyLead,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: Get.width * 0.025),
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 800),
          child: _buildCTAs(context),
        ),
        SizedBox(height: Get.width * 0.025),
        FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 1000),
          child: _buildSocials(context),
        ),
      ],
    );
  }

  Widget _buildCTAs(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final useNarrowStyling = !isDesktop && !isTablet;
    final pdfController = Get.find<PdfController>();
    final homeController = Get.find<HomeController>();

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: useNarrowStyling ? WrapAlignment.center : WrapAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => homeController.onNavTap(3),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gold,
            foregroundColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            AppStrings.viewMyWork,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTextSizes.bodyMedium,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => pdfController.showPdf(),
          icon: const Icon(AppIcons.pdf, size: 18),
          label: Text(
            AppStrings.viewResume,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTextSizes.bodyMedium,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.goldAccent,
            foregroundColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Obx(
          () => OutlinedButton.icon(
            onPressed: pdfController.isDownloading.value
                ? null
                : () => pdfController.downloadPdf(),
            icon: pdfController.isDownloading.value
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.gold,
                    ),
                  )
                : const Icon(AppIcons.download, size: 18),
            label: Text(
              pdfController.isDownloading.value
                  ? AppStrings.downloading
                  : AppStrings.downloadCv,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppTextSizes.bodyMedium,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
              side: const BorderSide(color: AppColors.gold),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocials(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    final isTablet = ResponsiveLayout.isTablet(context);
    final useNarrowStyling = !isDesktop && !isTablet;
    return Row(
      mainAxisAlignment: useNarrowStyling
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _SocialIcon(icon: AppIcons.github, url: PortfolioData.github),
        SizedBox(width: Get.width * 0.015),
        _SocialIcon(icon: AppIcons.linkedin, url: PortfolioData.linkedin),
        SizedBox(width: Get.width * 0.015),
        _SocialIcon(icon: AppIcons.email, url: "mailto:${PortfolioData.email}"),
      ],
    );
  }

  Widget _buildVisual(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      child: const Center(child: TechVisual()),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 24,
        ),
      ),
    );
  }
}

class HeroHoverController extends GetxController {
  bool isHovered = false;

  void setHovered(bool val) {
    isHovered = val;
    update();
  }
}
