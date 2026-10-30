// ignore_for_file: deprecated_member_use, constant_identifier_names, non_constant_identifier_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_icons.dart';
import '../../core/constants/app_text_sizes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../controllers/background_controller.dart';

class TechVisual extends StatelessWidget {
  const TechVisual({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BackgroundController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Automatically determine size based on parent constraints
        final double size = min(constraints.maxWidth, 600);

        return RepaintBoundary(
          child: SizedBox(
            width: size,
            height: size,
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: 600,
                height: 600,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. Technical Atmosphere
                    _buildPulseGlow(isDark),
                    _buildTechnicalRings(controller.animationController),

                    // 2. The Devices (Isometric Automatic Content Engine)
                    _buildDeviceShowcase(
                      controller.animationController,
                      isDark,
                    ),

                    // 3. Dynamic Technical Labels
                    _buildFloatingElements(
                      controller.animationController,
                      isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPulseGlow(bool isDark) {
    const app_color = AppColors.gold;
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            app_color.withValues(alpha: isDark ? 0.1 : 0.05),
            AppColors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceShowcase(Animation<double> animation, bool isDark) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // WEB BROWSER MOCKUP (Automatic Page Scrolling)
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.25)
                ..rotateX(0.1)
                ..translate(-50.0, -30.0),
              child: _buildAutomaticWeb(animation, isDark),
            ),

            // MOBILE PHONE MOCKUP (Automatic App Sliding)
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(0.2)
                ..rotateX(-0.1)
                ..translate(120.0, 50.0),
              child: _buildAutomaticMobile(animation, isDark),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAutomaticWeb(Animation<double> animation, bool isDark) {
    final double scrollCycle = (animation.value * 5) % 1.0;
    final double curvedScroll = Curves.easeInOutQuart.transform(scrollCycle);
    final int pageSet = (animation.value * 5).floor() % 3;
    const app_color = AppColors.gold;

    return Container(
      width: 350,
      height: 240,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: app_color.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: app_color.withValues(alpha: 0.2),
            blurRadius: 40,
            spreadRadius: -10,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildBrowserUI(isDark, pageSet),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: -(curvedScroll * 350),
                  left: 0,
                  right: 0,
                  child: Column(
                    children: List.generate(
                      4,
                      (i) => _buildWebSection(i, isDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomaticMobile(Animation<double> animation, bool isDark) {
    final double slideCycle = (animation.value * 8) % 1.0;
    final double curvedSlide = Curves.easeOutCubic.transform(slideCycle);
    const app_color = AppColors.gold;

    return Container(
      width: 150,
      height: 310,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBg : AppColors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: app_color.withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: app_color.withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: -5,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: -(curvedSlide * 90),
            child: Column(
              children: List.generate(12, (i) => _buildAppCard(i, isDark)),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 75,
              height: 22,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkCard : AppColors.lightBorder,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
              ),
              child: Center(
                child: Container(
                  width: 30,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrowserUI(bool isDark, int index) {
    final appStrings = [
      AppStrings.visualUrl1,
      AppStrings.visualUrl2,
      AppStrings.visualUrl3,
    ];
    final app_String = appStrings[index];
    const app_color = AppColors.gold;
    const app_icon = AppIcons.refresh;

    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: isDark
          ? app_color.withValues(alpha: 0.08)
          : app_color.withValues(alpha: 0.04),
      child: Row(
        children: [
          _dot(AppColors.redAccent.withValues(alpha: 0.8)),
          _dot(AppColors.amberAccent.withValues(alpha: 0.8)),
          _dot(AppColors.greenAccent.withValues(alpha: 0.8)),
          SizedBox(width: Get.width * 0.008),
          Expanded(
            child: Container(
              height: 16,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isDark ? AppColors.black : AppColors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: app_color.withValues(alpha: 0.1)),
              ),
              child: Text(
                app_String,
                style: TextStyle(
                  fontSize: AppTextSizes.xs,
                  color: app_color.withValues(alpha: 0.6),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          SizedBox(width: Get.width * 0.005),
          Icon(app_icon, size: 10, color: app_color.withValues(alpha: 0.3)),
        ],
      ),
    );
  }

  Widget _buildWebSection(int i, bool isDark) {
    const app_color = AppColors.gold;
    return Container(
      height: 220,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: app_color.withValues(alpha: 0.05)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            height: 14,
            decoration: BoxDecoration(
              color: app_color.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: Get.width * 0.015),
          Row(
            children: [
              Expanded(child: _block(isDark, 100)),
              SizedBox(width: Get.width * 0.008),
              Expanded(child: _block(isDark, 100)),
            ],
          ),
          SizedBox(height: Get.width * 0.008),
          _block(isDark, double.infinity),
          SizedBox(height: Get.width * 0.005),
          _block(isDark, 180),
          SizedBox(height: Get.width * 0.015),
          Center(
            child: Container(
              width: 110,
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(color: app_color.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Container(
                  width: 60,
                  height: 8,
                  color: app_color.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppCard(int i, bool isDark) {
    final appIcons = [
      AppIcons.wallet,
      AppIcons.rocket,
      AppIcons.cart,
      AppIcons.graph,
      AppIcons.layers,
    ];
    final appStrings = [
      AppStrings.visualFinance,
      AppStrings.visualLaunch,
      AppStrings.visualStore,
      AppStrings.visualGrowth,
      AppStrings.visualUiKit,
    ];

    final app_icon = appIcons[i % appIcons.length];
    final app_String = appStrings[i % appStrings.length];
    const app_color = AppColors.gold;

    return Container(
      height: 85,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: app_color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: app_color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  app_color.withValues(alpha: 0.2),
                  app_color.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(app_icon, size: 15, color: app_color),
          ),
          SizedBox(width: Get.width * 0.008),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  app_String,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: app_color,
                    fontSize: AppTextSizes.xs,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: Get.width * 0.004),
                Container(
                  width: 25,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isDark
                        ? app_color.withValues(alpha: 0.3)
                        : app_color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
    width: 7,
    height: 7,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.7),
      shape: BoxShape.circle,
    ),
  );

  Widget _block(bool isDark, double w) {
    const app_color = AppColors.gold;
    return Container(
      width: w,
      height: 10,
      decoration: BoxDecoration(
        color: isDark
            ? app_color.withValues(alpha: 0.05)
            : app_color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildTechnicalRings(Animation<double> animation) {
    const app_color = AppColors.gold;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: animation.value * 2 * pi,
              child: CustomPaint(
                size: const Size(580, 580),
                painter: TechnicalRingPainter(
                  app_color: app_color.withValues(alpha: 0.08),
                  dashes: 80,
                ),
              ),
            ),
            Transform.rotate(
              angle: -animation.value * 3 * pi,
              child: CustomPaint(
                size: const Size(480, 480),
                painter: TechnicalRingPainter(
                  app_color: app_color.withValues(alpha: 0.12),
                  dashes: 40,
                  isDashed: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFloatingElements(Animation<double> animation, bool isDark) {
    const app_color = AppColors.gold;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(600, 600),
          painter: TechLabelPainter(
            progress: animation.value,
            app_color: app_color.withValues(alpha: 0.4),
          ),
        );
      },
    );
  }
}

class TechnicalRingPainter extends CustomPainter {
  final Color app_color;
  final int dashes;
  final bool isDashed;

  TechnicalRingPainter({
    required this.app_color,
    required this.dashes,
    this.isDashed = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = app_color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final radius = size.width / 2;
    if (!isDashed) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        0.2,
        pi / 1.5,
        false,
        paint,
      );
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        pi + 0.5,
        pi / 2,
        false,
        paint,
      );
      return;
    }
    final dashAngle = (2 * pi) / dashes;
    for (int i = 0; i < dashes; i++) {
      if (i % 2 == 0) {
        canvas.drawArc(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius),
          i * dashAngle,
          dashAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TechLabelPainter extends CustomPainter {
  final double progress;
  final Color app_color;

  TechLabelPainter({required this.progress, required this.app_color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = app_color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2.1;
    final appStrings = [
      AppStrings.visualIosAndroid,
      AppStrings.visualFullstack,
      AppStrings.visualGetx,
      AppStrings.visualUiArchitect,
    ];

    for (int i = 0; i < appStrings.length; i++) {
      final app_String = appStrings[i];
      final angle = (i * 2 * pi / appStrings.length) + (progress * 0.45 * pi);
      final offset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle) + 25 * sin(progress * 4 * pi + i),
      );
      canvas.drawRect(
        Rect.fromCenter(center: offset, width: 95, height: 28),
        paint,
      );
      textPainter.text = TextSpan(
        text: app_String,
        style: TextStyle(
          color: app_color,
          fontSize: AppTextSizes.xs,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        offset - Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
