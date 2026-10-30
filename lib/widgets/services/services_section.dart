import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../models/service.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.015,
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
              SizedBox(height: Get.width * 0.035),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: PortfolioData.services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveLayout.isDesktop(context)
                      ? 4
                      : (ResponsiveLayout.isTablet(context) ? 2 : 1),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 25,
                  childAspectRatio: isMobile ? 1.2 : 0.85,
                ),
                itemBuilder: (context, index) =>
                    _buildServiceCard(context, PortfolioData.services[index]),
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
          AppStrings.services,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Text(
          AppStrings.servicesHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.sectionHeadline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, Service service) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Container(
      padding: const EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(service.icon, color: AppColors.gold, size: 30),
          ),
          SizedBox(height: Get.width * 0.015),
          Text(
            service.title,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: AppTextSizes.cardTitle,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: Get.width * 0.01),
          Text(
            service.description,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
              fontSize: AppTextSizes.bodyMedium,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
