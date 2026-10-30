import 'package:get/get.dart';
import '../data/portfolio_data.dart';
import '../models/project.dart';

class ProjectsController extends GetxController {
  var selectedCategory = "All".obs;
  final List<String> categories = ["All", "Mobile", "Web", "UI/UX"];

  void setCategory(String category) {
    selectedCategory.value = category;
  }

  List<Project> get filteredProjects {
    if (selectedCategory.value == "All") {
      return PortfolioData.projects;
    }
    return PortfolioData.projects.where((p) => p.category == selectedCategory.value).toList();
  }
}
