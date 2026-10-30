import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/responsive/responsive_layout.dart';
import '../../models/project.dart';
import '../../controllers/projects_controller.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = AppConstants.getPadding(context);
    final controller = Get.put(ProjectsController());
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
              _buildFilters(context, controller),
              SizedBox(height: Get.width * 0.03),
              Obx(
                () => _buildFeaturedProjects(
                  controller.filteredProjects
                      .where((p) => p.isFeatured)
                      .toList(),
                ),
              ),
              SizedBox(height: Get.width * 0.03),
              Obx(
                () => _buildProjectGrid(
                  context,
                  controller.filteredProjects
                      .where((p) => !p.isFeatured)
                      .toList(),
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
          AppStrings.portfolio,
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.w600,
            letterSpacing: 4,
            fontSize: AppTextSizes.bodySmall,
          ),
        ),
        SizedBox(height: Get.width * 0.008),
        Text(
          AppStrings.featuredProjects,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: AppTextSizes.sectionHeadline,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, ProjectsController controller) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: controller.categories.map((cat) {
        return Obx(() {
          bool isSelected = controller.selectedCategory.value == cat;
          return ChoiceChip(
            label: Text(
              cat,
              style: TextStyle(
                fontSize: AppTextSizes.bodySmall,
                color: isSelected
                    ? AppColors.black
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            selected: isSelected,
            onSelected: (val) => controller.setCategory(cat),
            backgroundColor: AppColors.transparent,
            selectedColor: AppColors.gold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                color: isSelected
                    ? AppColors.gold
                    : (Theme.of(context).dividerTheme.color ??
                          AppColors.darkBorder),
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildFeaturedProjects(List<Project> projects) {
    return Column(
      children: projects
          .map(
            (project) => Padding(
              padding: EdgeInsets.only(bottom: Get.width * 0.035),
              child: FadeInUp(child: _FeaturedProjectCard(project: project)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildProjectGrid(BuildContext context, List<Project> projects) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveLayout.isDesktop(context)
            ? 3
            : (ResponsiveLayout.isTablet(context) ? 2 : 1),
        crossAxisSpacing: 20,
        mainAxisSpacing: 30,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          child: _ProjectGridCard(project: projects[index]),
        );
      },
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  final Project project;

  const _FeaturedProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerTheme.color ?? AppColors.grey,
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: ResponsiveLayout(
        desktop: Row(
          children: [
            Expanded(flex: 3, child: _buildImage(context)),
            Expanded(flex: 2, child: _buildInfo(context)),
          ],
        ),
        mobile: Column(children: [_buildImage(context), _buildInfo(context)]),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Container(
      height: isMobile ? 220 : 360,
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: project.imageUrl != null
            ? Container(
                constraints: BoxConstraints(
                  maxHeight: isMobile ? 110 : 160,
                  maxWidth: isMobile ? 180 : 280,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  project.imageUrl!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    AppIcons.laptop,
                    size: isMobile ? 48 : 70,
                    color: AppColors.gold.withValues(alpha: 0.1),
                  ),
                ),
              )
            : Icon(
                AppIcons.laptop,
                size: isMobile ? 48 : 70,
                color: AppColors.gold.withValues(alpha: 0.1),
              ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final isMobile = ResponsiveLayout.isMobile(context);
    return Padding(
      padding: EdgeInsets.all(isMobile ? 25 : 50),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.featuredProjectSub,
            style: TextStyle(
              color: AppColors.gold,
              letterSpacing: 2,
              fontSize: AppTextSizes.caption,
            ),
          ),
          SizedBox(height: Get.width * 0.012),
          Text(
            project.name,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: AppTextSizes.sectionHeadline,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.displayLarge?.color,
            ),
          ),
          SizedBox(height: Get.width * 0.012),
          Text(
            project.description,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: AppTextSizes.bodyMedium,
              height: 1.6,
            ),
          ),
          SizedBox(height: Get.width * 0.018),
          Wrap(
            spacing: 10,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: project.technologies
                .map(
                  (tech) => Text(
                    "#$tech",
                    style: TextStyle(
                      color: AppColors.goldAccent,
                      fontSize: AppTextSizes.bodySmall,
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: Get.width * 0.02),
          Row(
            mainAxisAlignment: isMobile
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (project.githubUrl != null)
                IconButton(
                  icon: const FaIcon(AppIcons.github),
                  tooltip: AppStrings.viewOnGithub,
                  onPressed: () {
                    launchUrl(Uri.parse(project.githubUrl!));
                  },
                ),
              if (project.liveUrl != null)
                IconButton(
                  icon: const Icon(AppIcons.launch),
                  tooltip: AppStrings.liveDemo,
                  onPressed: () {
                    launchUrl(Uri.parse(project.liveUrl!));
                  },
                ),
              if (!isMobile) const Spacer(),
              TextButton.icon(
                onPressed: () {
                  final url = project.githubUrl ?? project.liveUrl;
                  if (url != null) {
                    launchUrl(Uri.parse(url));
                  }
                },
                icon: const FaIcon(
                  AppIcons.github,
                  size: 16,
                  color: AppColors.gold,
                ),
                label: Text(
                  AppStrings.viewCaseStudy,
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
                    fontSize: AppTextSizes.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectGridCard extends StatelessWidget {
  final Project project;

  const _ProjectGridCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final hoverController = Get.put(
      ProjectHoverController(),
      tag: project.name,
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => hoverController.setHover(true),
      onExit: (_) => hoverController.setHover(false),
      child: GestureDetector(
        onTap: () {
          final url = project.githubUrl ?? project.liveUrl;
          if (url != null) {
            launchUrl(Uri.parse(url));
          }
        },
        child: Obx(
          () => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: hoverController.isHovered.value
                    ? AppColors.gold
                    : (Theme.of(context).dividerTheme.color ?? AppColors.grey),
                width: 0.5,
              ),
              boxShadow: hoverController.isHovered.value
                  ? [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ]
                  : [],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: project.imageUrl != null
                        ? Container(
                            constraints: const BoxConstraints(
                              maxHeight: 150,
                              maxWidth: 240,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              project.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    AppIcons.image,
                                    size: 50,
                                    color: AppColors.gold.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                            ),
                          )
                        : Icon(
                            AppIcons.image,
                            size: 50,
                            color: AppColors.gold.withValues(alpha: 0.1),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: TextStyle(
                          fontSize: AppTextSizes.cardTitle,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                      SizedBox(height: Get.width * 0.008),
                      Text(
                        project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: AppTextSizes.bodySmall,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: Get.width * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            project.category ?? AppStrings.defaultCategoryApp,
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: AppTextSizes.caption,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                AppStrings.showProject,
                                style: TextStyle(
                                  color: AppColors.gold,
                                  fontSize: AppTextSizes.caption,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                AppIcons.arrowForward,
                                size: 16,
                                color: AppColors.gold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProjectHoverController extends GetxController {
  var isHovered = false.obs;

  void setHover(bool val) => isHovered.value = val;
}
