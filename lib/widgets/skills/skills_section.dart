// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/background_controller.dart';
import '../../models/skill.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);
    final controller = Get.find<BackgroundController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.02,
      ),
      color: AppColors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: _buildHeader(context),
              ),
              SizedBox(height: Get.width * 0.015),

              if (isMobile)
                _buildMobileLayout(context)
              else
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildDesktopLayout(
                      context,
                      controller.animationController,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    Animation<double> animation,
  ) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1500),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: PortfolioData.skillCategories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveLayout.isTablet(context) ? 1 : 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: ResponsiveLayout.isTablet(context) ? 3.5 : 4.2,
          ),
          itemBuilder: (context, index) {
            final category = PortfolioData.skillCategories[index];
            final isLeft = index % 2 == 0;
            return isLeft
                ? FadeInLeft(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 100),
                    child: _buildSkillCategory(context, category),
                  )
                : FadeInRight(
                    duration: const Duration(milliseconds: 800),
                    delay: Duration(milliseconds: index * 100),
                    child: _buildSkillCategory(context, category),
                  );
          },
        ),
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, SkillCategory category) {
    return _buildSkillCategoryCard(context, category);
  }

  Widget _buildMobileLayout(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PortfolioData.skillCategories.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: Get.width * 0.03),
        child: FadeInUp(
          duration: const Duration(milliseconds: 800),
          delay: Duration(milliseconds: index * 100),
          child: _buildSkillCategoryCard(
            context,
            PortfolioData.skillCategories[index],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    const app_color = AppColors.gold;
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.skillsAndTech,
          style: TextStyle(
            color: app_color,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Container(width: 50, height: 2, color: app_color),
      ],
    );
  }

  Widget _buildSkillCategoryCard(BuildContext context, SkillCategory category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const app_color = AppColors.gold;

    return GetBuilder<SkillHoverController>(
      init: SkillHoverController(),
      tag: category.title,
      builder: (controller) {
        return MouseRegion(
          onEnter: (_) => controller.setHovered(true),
          onExit: (_) => controller.setHovered(false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: ResponsiveLayout.isMobile(context) ? double.infinity : 500,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: controller.isHovered
                    ? app_color
                    : app_color.withValues(alpha: 0.15),
                width: controller.isHovered ? 1.5 : 0.5,
              ),
              boxShadow: [
                if (controller.isHovered)
                  BoxShadow(
                    color: app_color.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: -5,
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.isHovered
                            ? app_color.withValues(alpha: 0.2)
                            : app_color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(category.title),
                        color: app_color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.015),
                    Text(
                      category.title,
                      style: TextStyle(
                        fontSize: AppTextSizes.cardTitle,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.width * 0.015),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: category.skills
                      .map(
                        (skill) => _buildSkillChip(
                          context,
                          skill,
                          controller.isHovered,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getCategoryIcon(String title) {
    if (title.contains("Mobile")) return AppIcons.mobileApp;
    if (title.contains("State")) return AppIcons.getx;
    if (title.contains("Backend")) return AppIcons.api;
    if (title.contains("Tools")) return AppIcons.uiDesign;
    return AppIcons.code;
  }

  Widget _buildSkillChip(
    BuildContext context,
    Skill skill,
    bool parentHovered,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app_icon = skill.icon;
    const app_color = AppColors.gold;
    final brandColor = AppColors.getBrandColor(skill.name);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? (parentHovered ? AppColors.darkHoverCard : AppColors.darkCardAlt)
            : (parentHovered ? AppColors.lightHoverCard : AppColors.lightBg),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: parentHovered
              ? app_color.withValues(alpha: 0.3)
              : app_color.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (app_icon != null) Icon(app_icon, size: 18, color: brandColor),
          SizedBox(width: Get.width * 0.008),
          Text(
            skill.name,
            style: TextStyle(
              fontSize: AppTextSizes.bodySmall,
              fontWeight: FontWeight.w600,
              color: Theme.of(
                context,
              ).textTheme.bodyLarge?.color?.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillHoverController extends GetxController {
  bool isHovered = false;

  void setHovered(bool val) {
    isHovered = val;
    update();
  }
}
