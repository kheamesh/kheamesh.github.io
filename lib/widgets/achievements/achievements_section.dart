import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.03,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: ResponsiveLayout(
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: PortfolioData.achievements.map((ach) {
                return _buildAchievement(context, ach['title']!, ach['value']!);
              }).toList(),
            ),
            mobile: Wrap(
              spacing: 20,
              runSpacing: 40,
              alignment: WrapAlignment.center,
              children: PortfolioData.achievements.map((ach) {
                return SizedBox(
                  width: 150,
                  child: _buildAchievement(
                    context,
                    ach['title']!,
                    ach['value']!,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievement(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: AppTextSizes.statValue,
            fontWeight: FontWeight.w900,
            color: AppColors.gold,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: AppTextSizes.caption,
            letterSpacing: 2,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
