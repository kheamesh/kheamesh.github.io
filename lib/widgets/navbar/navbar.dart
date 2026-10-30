import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/pdf_controller.dart';

class Navbar extends StatelessWidget {
  final Function(int) onNavTap;
  const Navbar({super.key, required this.onNavTap});

  final List<String> _navItems = const [
    AppStrings.navHome,
    AppStrings.navAbout,
    AppStrings.navExperience,
    AppStrings.navProjects,
    AppStrings.navSkills,
    AppStrings.navServices,
    AppStrings.navContact,
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: RepaintBoundary(
        child: Container(
          height: 80,
          padding: EdgeInsets.symmetric(horizontal: AppConstants.getPadding(context)),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.95),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerTheme.color ?? AppColors.grey.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                _buildLogo(),
                if (ResponsiveLayout.isDesktop(context))
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: _buildDesktopNav(context),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.012),
                        _buildThemeToggle(),
                      ],
                    ),
                  )
                else
                  Row(
                    children: [
                      _buildThemeToggle(),
                      _buildMobileNavTrigger(context),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildThemeToggle() {
    final themeController = Get.find<ThemeController>();
    return Obx(() => IconButton(
          icon: Icon(
            themeController.isDarkMode.value ? AppIcons.themeLight : AppIcons.themeDark,
            color: AppColors.gold,
          ),
          onPressed: () => themeController.toggleTheme(),
        ));
  }

  Widget _buildLogo() {
    return Text(
      PortfolioData.name.toUpperCase(),
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: AppTextSizes.logo,
        letterSpacing: 2,
        color: AppColors.gold,
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    return Row(
      children: [
        ...List.generate(_navItems.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextButton(
              onPressed: () => onNavTap(index),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              child: Text(
                _navItems[index],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: AppTextSizes.navItem,
                ),
              ),
            ),
          );
        }),
        SizedBox(width: Get.width * 0.005),
        OutlinedButton.icon(
          onPressed: () => pdfController.showPdf(),
          icon: const Icon(AppIcons.pdf, size: 16, color: AppColors.gold),
          label: Text(
            AppStrings.navResume,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppTextSizes.bodySmall - 1,
              color: AppColors.gold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.gold, width: 1),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileNavTrigger(BuildContext context) {
    return IconButton(
      icon: const Icon(AppIcons.menu, color: AppColors.gold),
      onPressed: () => _showMobileMenu(context),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final pdfController = Get.find<PdfController>();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(_navItems.length, (index) {
              return ListTile(
                title: Text(
                  _navItems[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: AppTextSizes.bodyMedium,
                  ),
                ),
                onTap: () {
                  Get.back();
                  onNavTap(index);
                },
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(AppIcons.pdf, color: AppColors.gold),
              title: Text(
                AppStrings.viewResumePdf,
                style: TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSizes.bodyMedium,
                ),
              ),
              onTap: () {
                Get.back();
                pdfController.showPdf();
              },
            ),
            ListTile(
              leading: const Icon(AppIcons.download, color: AppColors.gold),
              title: Text(
                AppStrings.downloadResume,
                style: TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSizes.bodyMedium,
                ),
              ),
              onTap: () {
                Get.back();
                pdfController.downloadPdf();
              },
            ),
          ],
        ),
      ),
    );
  }
}
