import 'package:flutter/material.dart';

/// Centralized Color Palette for the Web Portfolio app.
class AppColors {
  // --- Primary Luxury Gold Palette ---
  static const Color gold = Color(0xFFE2B13C);
  static const Color goldAccent = Color(0xFFC5A059);

  // --- Dark Theme Palette ---
  static const Color darkBg = Color(0xFF030303);
  static const Color darkCard = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF050505);
  static const Color darkText = Color(0xFFF2F2F2);
  static const Color darkMutedText = Color(0xFF888888);
  static const Color darkBorder = Color(0xFF1A1A1A);
  static const Color darkAccent = Color(0xFF1A1A1A);
  static const Color darkHoverCard = Color(0xFF151515);
  static const Color darkCardAlt = Color(0xFF101010);
  static const Color darkHeaderBg = Color(0xFF1E1E2C);

  // --- Light Theme Palette ---
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF0F172A);
  static const Color lightMutedText = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightAccent = Color(0xFFE2E8F0);
  static const Color lightHoverCard = Color(0xFFF1F5F9);
  static const Color lightHeaderBg = Color(0xFFF0F0F5);

  // --- Background Glow Mesh Accents ---
  static const Color cosmicPurple = Color(0xFF1A1033);
  static const Color deepNavy = Color(0xFF001F3F);
  static const Color warmSunlight = Color(0xFFFFF7ED);
  static const Color amberSunlight = Color(0xFFFEF3C7);
  static const Color skyBlue = Color(0xFFE0F2FE);
  static const Color sunHalo = Color(0xFFFDE68A);

  // --- Common Utility Colors ---
  static const Color transparent = Colors.transparent;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static const Color redAccent = Colors.redAccent;
  static const Color amberAccent = Colors.amberAccent;
  static const Color greenAccent = Colors.greenAccent;
  static const Color green = Colors.green;

  // --- Gradients ---
  static const LinearGradient goldGradient = LinearGradient(
    colors: [gold, goldAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- Brand Color Helper ---
  static Color getBrandColor(String name) {
    name = name.toLowerCase();
    if (name.contains("flutter")) return Colors.blue;
    if (name.contains("dart")) return Colors.blueAccent;
    if (name.contains("android")) return Colors.green;
    if (name.contains("ios")) return AppColors.grey;
    if (name.contains("getx")) return Colors.deepPurpleAccent;
    if (name.contains("provider")) return Colors.blue;
    if (name.contains("riverpod")) return Colors.lightBlue;
    if (name.contains("firebase")) return Colors.orangeAccent;
    if (name.contains("api") || name.contains("dio")) return Colors.orange;
    if (name.contains("auth")) return AppColors.redAccent;
    if (name.contains("git")) return const Color(0xFFF05032);
    if (name.contains("figma")) return Colors.purple;
    if (name.contains("postman")) return Colors.orange;
    return AppColors.gold;
  }
}
