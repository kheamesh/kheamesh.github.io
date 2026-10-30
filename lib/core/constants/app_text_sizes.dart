import 'package:get/get.dart';

/// Centralized Text Sizes for the Web Portfolio app.
/// Provides responsive dynamic font sizes based on screen width using GetX,
/// as well as standard static font sizes.
class AppTextSizes {
  // --- Dynamic Responsive Font Sizes ---

  /// Dynamic hero title size (Name in Hero Section)
  static double get heroTitle {
    final width = Get.width;
    if (width < 600) return 44.0;
    if (width < 1200) return 60.0;
    return 80.0;
  }

  /// Dynamic hero role size
  static double get heroRole {
    final width = Get.width;
    if (width < 600) return 18.0;
    return 24.0;
  }

  /// Dynamic main section title (e.g. "About Me", "Featured Projects", "Contact Me")
  static double get sectionHeadline {
    final width = Get.width;
    if (width < 600) return 30.0;
    if (width < 1200) return 36.0;
    return 42.0;
  }

  /// Dynamic card / subtitle heading
  static double get cardTitle {
    final width = Get.width;
    if (width < 600) return 20.0;
    return 24.0;
  }

  /// Dynamic large display text / stat values
  static double get statValue {
    final width = Get.width;
    if (width < 600) return 36.0;
    return 48.0;
  }

  /// Dynamic large number headings (e.g., Process steps "01")
  static double get numberHeading {
    final width = Get.width;
    if (width < 600) return 36.0;
    return 48.0;
  }

  /// Subheadline / Lead paragraph text
  static double get bodyLead {
    final width = Get.width;
    if (width < 600) return 16.0;
    return 18.0;
  }

  /// Standard body text size
  static double get bodyMedium => 16.0;

  /// Secondary body text / descriptions
  static double get bodySmall => 14.0;

  /// Small caption / badge / label font size
  static double get caption => 12.0;

  /// Navbar item font size
  static double get navItem => 14.0;

  /// Brand logo font size
  static double get logo => 20.0;

  // --- Static Font Size Constants ---
  static const double xs = 10.0;
  static const double sm = 12.0;
  static const double md = 14.0;
  static const double lg = 16.0;
  static const double xl = 18.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
  static const double display = 48.0;
  static const double hero = 80.0;
}
