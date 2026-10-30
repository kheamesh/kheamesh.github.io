import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/pdf_controller.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
              SizedBox(height: Get.width * 0.02),
              ResponsiveLayout(
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildContent(context)),
                    SizedBox(width: Get.width * 0.025),
                    Expanded(flex: 2, child: _buildStats(context)),
                  ],
                ),
                mobile: Column(
                  children: [
                    _buildContent(context),
                    SizedBox(height: Get.width * 0.05),
                    _buildStats(context),
                  ],
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
          AppStrings.aboutMe,
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

  Widget _buildContent(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutHeadline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.sectionHeadline,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Text(
          PortfolioData.aboutSummary,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.bodyLead,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.8,
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Text(
          AppStrings.aboutPhilosophy,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.bodyLead,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            height: 1.8,
          ),
        ),
        SizedBox(height: Get.width * 0.02),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () => Get.find<PdfController>().showPdf(),
              icon: const Icon(AppIcons.pdf, size: 18),
              label: Text(
                AppStrings.viewResumePdfCaps,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSizes.bodySmall,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: AppColors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () => Get.find<PdfController>().downloadPdf(),
              icon: const Icon(AppIcons.download, size: 18),
              label: Text(
                AppStrings.downloadCv,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSizes.bodySmall,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
                side: const BorderSide(color: AppColors.gold),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: [
        _StatCard(
          label: AppStrings.yearsExperience,
          value: PortfolioData.experienceYears,
        ),
        _StatCard(
          label: AppStrings.projectsCompleted,
          value: PortfolioData.projectsCompleted,
        ),
        _StatCard(
          label: AppStrings.technologies,
          value: PortfolioData.technologiesCount,
        ),
        _StatCard(
          label: AppStrings.clientsServed,
          value: PortfolioData.clientsServed,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
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
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppTextSizes.caption,
              letterSpacing: 1,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
