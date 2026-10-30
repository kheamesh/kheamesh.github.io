class Project {
  final String name;
  final String description;
  final String problemSolved;
  final List<String> technologies;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;
  final String? imageUrl;
  final String? category;
  final bool isFeatured;

  Project({
    required this.name,
    required this.description,
    required this.problemSolved,
    required this.technologies,
    required this.features,
    this.githubUrl,
    this.liveUrl,
    this.imageUrl,
    this.category,
    this.isFeatured = false,
  });
}
