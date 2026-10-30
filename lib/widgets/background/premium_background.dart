import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/background_controller.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  const PremiumBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BackgroundController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onHover: (event) => controller.updateMousePos(event.localPosition),
      child: Stack(
        children: [
          // 1. Base color
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),

          // 2. High-Performance Static Ambient Mesh Gradients
          RepaintBoundary(
            child: Stack(
              children: [
                if (isDark) ...[
                  _buildAmbientGlow(
                    color: AppColors.cosmicPurple.withValues(alpha: 0.35),
                    size: 900,
                    alignment: const Alignment(-0.8, -0.6),
                  ),
                  _buildAmbientGlow(
                    color: AppColors.gold.withValues(alpha: 0.04),
                    size: 700,
                    alignment: const Alignment(0.8, 0.4),
                  ),
                  _buildAmbientGlow(
                    color: AppColors.deepNavy.withValues(alpha: 0.25),
                    size: 800,
                    alignment: const Alignment(0.7, -0.7),
                  ),
                ],
                if (!isDark) ...[
                  _buildAmbientGlow(
                    color: AppColors.warmSunlight.withValues(alpha: 0.7),
                    size: 1200,
                    alignment: const Alignment(0.9, -0.9),
                  ),
                  _buildAmbientGlow(
                    color: AppColors.amberSunlight.withValues(alpha: 0.4),
                    size: 800,
                    alignment: const Alignment(0.5, -0.3),
                  ),
                  _buildAmbientGlow(
                    color: AppColors.skyBlue.withValues(alpha: 0.5),
                    size: 1000,
                    alignment: const Alignment(-0.7, -0.5),
                  ),
                  _buildAmbientGlow(
                    color: AppColors.gold.withValues(alpha: 0.05),
                    size: 600,
                    alignment: const Alignment(-0.3, 0.7),
                  ),
                ],
              ],
            ),
          ),

          // 3. Technical Grid Pattern
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: TechnicalGridPainter(
                  gridColor: isDark
                      ? AppColors.white.withValues(alpha: 0.015)
                      : AppColors.black.withValues(alpha: 0.01),
                ),
              ),
            ),
          ),

          // 4. Starfield (Dark Mode only)
          if (isDark)
            Positioned.fill(
              child: IgnorePointer(
                child: RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: StarfieldPainter(
                          progress: controller.animationController.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

          // 5. Floating Geometric Shapes
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: controller.animationController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: GeometricPainter(
                        progress: controller.animationController.value,
                        color: isDark
                            ? AppColors.white.withValues(alpha: 0.02)
                            : AppColors.black.withValues(alpha: 0.01),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 6. Interactive Mouse Tracker (Isolated in RepaintBoundary)
          Obx(() => controller.mousePos.value == Offset.zero
              ? const SizedBox.shrink()
              : Positioned(
                  left: controller.mousePos.value.dx - 400,
                  top: controller.mousePos.value.dy - 400,
                  child: RepaintBoundary(
                    child: IgnorePointer(
                      child: Container(
                        width: 800,
                        height: 800,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              isDark
                                  ? AppColors.gold.withValues(alpha: 0.025)
                                  : AppColors.sunHalo.withValues(alpha: 0.1),
                              AppColors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),

          // 7. Subtle Vignette Overlay
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.transparent,
                      isDark
                          ? AppColors.black.withValues(alpha: 0.3)
                          : AppColors.black.withValues(alpha: 0.03),
                    ],
                    stops: const [0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // 8. Content
          RepaintBoundary(child: child),
        ],
      ),
    );
  }

  Widget _buildAmbientGlow({
    required Color color,
    required double size,
    required Alignment alignment,
  }) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color,
                color.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TechnicalGridPainter extends CustomPainter {
  final Color gridColor;
  TechnicalGridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    const double spacing = 60.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GeometricPainter extends CustomPainter {
  final double progress;
  final Color color;
  final List<_Shape> _shapes;

  GeometricPainter({required this.progress, required this.color})
      : _shapes = List.generate(15, (index) {
          final random = Random(index);
          return _Shape(
            pos: Offset(random.nextDouble(), random.nextDouble()),
            size: 20 + random.nextDouble() * 40,
            rotation: random.nextDouble() * 2 * pi,
            type: random.nextInt(3),
          );
        });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var s in _shapes) {
      final x = s.pos.dx * size.width;
      final y = (s.pos.dy * size.height + (progress * 50)) % size.height;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(s.rotation + progress * pi);

      if (s.type == 0) {
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: s.size, height: s.size), paint);
      } else if (s.type == 1) {
        canvas.drawCircle(Offset.zero, s.size / 2, paint);
      } else {
        final path = Path()
          ..moveTo(0, -s.size / 2)
          ..lineTo(s.size / 2, s.size / 2)
          ..lineTo(-s.size / 2, s.size / 2)
          ..close();
        canvas.drawPath(path, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class StarfieldPainter extends CustomPainter {
  final double progress;
  final List<_Star> _stars;

  StarfieldPainter({required this.progress})
      : _stars = List.generate(15, (index) {
          final random = Random(index);
          return _Star(
            pos: Offset(random.nextDouble(), random.nextDouble()),
            size: 0.5 + random.nextDouble() * 1.5,
            twinkleSpeed: 0.5 + random.nextDouble() * 2.0,
          );
        });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var s in _stars) {
      final x = s.pos.dx * size.width;
      final y = s.pos.dy * size.height;

      final opacity = 0.1 + 0.6 * (0.5 + 0.5 * sin(progress * 2 * pi * s.twinkleSpeed));

      paint.color = AppColors.white.withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), s.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Star {
  final Offset pos;
  final double size;
  final double twinkleSpeed;
  _Star({required this.pos, required this.size, required this.twinkleSpeed});
}

class _Shape {
  final Offset pos;
  final double size;
  final double rotation;
  final int type;
  _Shape({required this.pos, required this.size, required this.rotation, required this.type});
}
