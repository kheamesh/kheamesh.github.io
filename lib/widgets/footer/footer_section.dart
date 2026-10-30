import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../data/portfolio_data.dart';
import '../../controllers/pdf_controller.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: AppColors.transparent,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PortfolioData.name.toUpperCase(),
                        style: TextStyle(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w900,
                          fontSize: AppTextSizes.cardTitle,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: Get.width * 0.008),
                      Text(
                        PortfolioData.role,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: AppTextSizes.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      TextButton.icon(
                        onPressed: () => Get.find<PdfController>().showPdf(),
                        icon: const Icon(
                          AppIcons.pdf,
                          size: 16,
                          color: AppColors.gold,
                        ),
                        label: Text(
                          AppStrings.viewResumePdf,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: AppTextSizes.bodySmall,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            Get.find<PdfController>().downloadPdf(),
                        icon: const Icon(
                          AppIcons.download,
                          size: 16,
                          color: AppColors.gold,
                        ),
                        label: Text(
                          AppStrings.downloadResume,
                          style: TextStyle(
                            color: AppColors.gold,
                            fontSize: AppTextSizes.bodySmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: Get.width * 0.02),
              const Divider(),
              SizedBox(height: Get.width * 0.015),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 20,
                runSpacing: 10,
                children: [
                  Text(
                    "© ${DateTime.now().year} ${PortfolioData.name}. ${AppStrings.allRightsReserved}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: AppTextSizes.bodySmall,
                    ),
                  ),
                  Text(
                    AppStrings.designedAndBuilt,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: AppTextSizes.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
