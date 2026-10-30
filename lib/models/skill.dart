import 'package:flutter/widgets.dart';

class Skill {
  final String name;
  final IconData? icon;
  final String? iconPath; // For SVG/Image icons

  Skill({
    required this.name,
    this.icon,
    this.iconPath,
  });
}

class SkillCategory {
  final String title;
  final List<Skill> skills;

  SkillCategory({
    required this.title,
    required this.skills,
  });
}
