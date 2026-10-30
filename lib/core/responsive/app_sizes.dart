import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Centralized Responsive Utilities and Spacing for the Web Portfolio app.
/// Uses Get.width and Get.height to calculate relative layout dimensions.
class AppSizes {
  /// Relative width based on screen width multiplier (e.g. AppSizes.width(0.3))
  static double width(double factor) => Get.width * factor;

  /// Relative height based on screen height multiplier (e.g. AppSizes.height(0.05))
  static double height(double factor) => Get.height * factor;

  /// Responsive vertical SizedBox based on Get.height or Get.width factor
  static SizedBox h(double factor) => SizedBox(height: Get.height * factor);

  /// Responsive horizontal SizedBox based on Get.width factor
  static SizedBox w(double factor) => SizedBox(width: Get.width * factor);

  /// Responsive vertical spacing using Get.width percentage (e.g., SizedBox(height: Get.width * 0.03))
  static SizedBox hByWidth(double factor) => SizedBox(height: Get.width * factor);

  // Common relative spacing constants based on Get.width
  static double get spaceXs => Get.width * 0.005; // Extra Small spacing
  static double get spaceSm => Get.width * 0.01;  // Small spacing
  static double get spaceMd => Get.width * 0.02;  // Medium spacing
  static double get spaceLg => Get.width * 0.03;  // Large spacing
  static double get spaceXl => Get.width * 0.05;  // Extra Large spacing
  static double get spaceXxl => Get.width * 0.08; // XXL spacing
}
