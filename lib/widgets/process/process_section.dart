import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

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
              _buildHeader(context),
              SizedBox(height: Get.width * 0.04),
              ResponsiveLayout(
                desktop: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: PortfolioData.processSteps.asMap().entries.map((
                    entry,
                  ) {
                    return Expanded(
                      child: _buildProcessStep(
                        context: context,
                        index: entry.key + 1,
                        title: entry.value['title']!,
                        desc: entry.value['desc']!,
                      ),
                    );
                  }).toList(),
                ),
                tablet: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: PortfolioData.processSteps.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    childAspectRatio: 2.2,
                  ),
                  itemBuilder: (context, index) {
                    final step = PortfolioData.processSteps[index];
                    return _buildProcessStep(
                      context: context,
                      index: index + 1,
                      title: step['title']!,
                      desc: step['desc']!,
                    );
                  },
                ),
                mobile: Column(
                  children: PortfolioData.processSteps.asMap().entries.map((
                    entry,
                  ) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: Get.width * 0.03),
                      child: _buildProcessStep(
                        context: context,
                        index: entry.key + 1,
                        title: entry.value['title']!,
                        desc: entry.value['desc']!,
                      ),
                    );
                  }).toList(),
                ),
              ),
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
          AppStrings.howIWork,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Text(
          AppStrings.processHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.sectionHeadline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProcessStep({
    required BuildContext context,
    required int index,
    required String title,
    required String desc,
  }) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            index < 10 ? "0$index" : "$index",
            style: TextStyle(
              fontSize: AppTextSizes.numberHeading,
              fontWeight: FontWeight.w900,
              color: AppColors.gold,
            ),
          ),
          SizedBox(height: Get.width * 0.008),
          Text(
            title,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: AppTextSizes.cardTitle,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: Get.width * 0.01),
          Text(
            desc,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: AppTextSizes.bodySmall,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
