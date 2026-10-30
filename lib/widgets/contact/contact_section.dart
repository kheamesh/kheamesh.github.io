import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/contact_controller.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../data/portfolio_data.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: Get.width * 0.002,
      ),
      color: AppColors.transparent,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              ResponsiveLayout(
                desktop: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    const SizedBox(width: 24),
                    Expanded(child: _buildContactForm(context)),
                  ],
                ),
                tablet: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(context)),
                    SizedBox(width: Get.width * 0.025),
                    Expanded(child: _buildContactForm(context)),
                  ],
                ),
                mobile: Column(
                  children: [
                    _buildContactInfo(context),
                    SizedBox(height: Get.width * 0.04),
                    _buildContactForm(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          AppStrings.contactMe,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.contactHeadline,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppTextSizes.sectionHeadline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.contactSub,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: AppTextSizes.bodyLead,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _ContactItem(
          icon: AppIcons.email,
          label: AppStrings.labelEmail,
          value: PortfolioData.email,
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: AppIcons.location,
          label: AppStrings.labelLocation,
          value: PortfolioData.location,
        ),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    final controller = Get.isRegistered<ContactController>()
        ? Get.find<ContactController>()
        : Get.put(ContactController());

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          _buildTextField(
            context,
            AppStrings.labelName,
            controller: controller.nameController,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            AppStrings.labelEmail,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            context,
            AppStrings.labelMessage,
            controller: controller.messageController,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          Obx(() {
            final isLoading = controller.isLoading.value;
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : controller.submitContactForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.black,
                  disabledBackgroundColor: AppColors.gold.withValues(
                    alpha: 0.6,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.black,
                        ),
                      )
                    : Text(
                        AppStrings.sendMessage,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppTextSizes.bodyMedium,
                        ),
                      ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label, {
    int maxLines = 1,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.titleSmall?.color,
            fontWeight: FontWeight.w500,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: AppTextSizes.bodyMedium,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    Theme.of(context).dividerTheme.color ??
                    AppColors.darkBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color:
                    Theme.of(context).dividerTheme.color ??
                    AppColors.darkBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.gold),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.gold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        SizedBox(width: Get.width * 0.015),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: AppTextSizes.bodySmall,
              ),
            ),
            SizedBox(height: Get.width * 0.004),
            Text(
              value,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: AppTextSizes.bodyLead,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
