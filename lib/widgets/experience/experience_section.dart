import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.01,
      ),
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
              _buildHeader(context),
              SizedBox(height: Get.width * 0.03),
              _buildTimeline(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.experience,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Container(width: 50, height: 2, color: AppColors.gold),
      ],
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: PortfolioData.experiences.length,
      itemBuilder: (ctx, index) {
        final exp = PortfolioData.experiences[index];
        final isLast = index == PortfolioData.experiences.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : Get.width * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile) ...[
                _buildTimelineIndicator(ctx, isLast),
                SizedBox(width: Get.width * 0.012),
              ],
              Expanded(child: _buildExperienceCard(ctx, exp)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimelineIndicator(BuildContext context, bool isLast) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: AppColors.gold,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.5),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(BuildContext context, dynamic exp) {
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      padding: EdgeInsets.all(isMobile ? 25 : 40),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile) ...[
            Text(
              exp.role,
              style: TextStyle(
                fontSize: AppTextSizes.cardTitle,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: Get.width * 0.005),
            Text(
              exp.company,
              style: TextStyle(
                fontSize: AppTextSizes.bodyMedium,
                color: AppColors.goldAccent,
              ),
            ),
            SizedBox(height: Get.width * 0.008),
            Text(
              exp.duration,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: AppTextSizes.bodySmall,
              ),
            ),
            Text(
              exp.location,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: AppTextSizes.caption,
              ),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp.role,
                        style: TextStyle(
                          fontSize: AppTextSizes.cardTitle,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                      SizedBox(height: Get.width * 0.005),
                      Text(
                        exp.company,
                        style: TextStyle(
                          fontSize: AppTextSizes.bodyLead,
                          color: AppColors.goldAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Get.width * 0.012),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      exp.duration,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                        fontSize: AppTextSizes.bodySmall,
                      ),
                    ),
                    SizedBox(height: Get.width * 0.005),
                    Text(
                      exp.location,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: AppTextSizes.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
          SizedBox(height: Get.width * 0.02),
          ...exp.responsibilities
              .map(
                (res) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    res,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.color?.withValues(alpha: 0.85),
                      fontSize: AppTextSizes.bodyMedium,
                      height: 1.6,
                    ),
                  ),
                ),
              )
              .toList(),
          SizedBox(height: Get.width * 0.02),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: exp.technologies
                .map<Widget>(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.gold.withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      tech,
                      style: TextStyle(
                        fontSize: AppTextSizes.caption,
                        color: AppColors.gold,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
