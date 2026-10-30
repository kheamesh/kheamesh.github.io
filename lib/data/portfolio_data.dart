import 'package:resume/core/constants/app_url.dart';

import '../core/constants/app_icons.dart';
import '../models/project.dart';
import '../models/experience.dart';
import '../models/skill.dart';
import '../models/service.dart';
import '../core/theme/app_logo.dart';
import '../core/constants/app_strings.dart';

class PortfolioData {
  static const String name = AppStrings.name;
  static const String role = AppStrings.role;
  static const String shortIntro = AppStrings.shortIntro;
  static const String aboutSummary = AppStrings.aboutSummary;

  static const String experienceYears = AppStrings.expYearsValue;
  static const String projectsCompleted = AppStrings.projectsCompletedValue;
  static const String technologiesCount = AppStrings.technologiesCountValue;
  static const String clientsServed = AppStrings.clientsServedValue;

  static final List<Experience> experiences = [
    Experience(
      company: AppStrings.expCompany1,
      role: AppStrings.expRole1,
      duration: AppStrings.expDuration1,
      location: AppStrings.expLocation1,
      responsibilities: [AppStrings.expSummary1],
      technologies: [
        "Flutter",
        "Dart",
        "GetX",
        "Provider",
        "BLoC",
        "REST API",
        "Firebase",
        "Git",
        "Android SDK",
      ],
      achievements: [AppStrings.expAchieve1_1, AppStrings.expAchieve1_2],
    ),
  ];

  static final List<Project> projects = [
    Project(
      name: AppStrings.projRukminiName,
      description: AppStrings.projRukminiDesc,
      problemSolved: AppStrings.projRukminiProblem,
      technologies: ["Flutter", "Dart", "GetX", "REST API", "Firebase"],
      features: [
        AppStrings.featureJewelryInventory,
        AppStrings.featureWeightCalc,
        AppStrings.featureStockReports,
        AppStrings.featureGetxState,
      ],
      isFeatured: true,
      category: AppStrings.categoryMobile,
      githubUrl: AppStrings.projRukminiGithub,
      imageUrl: AppLogo.logoRukmini,
    ),
    Project(
      name: AppStrings.projKohiraName,
      description: AppStrings.projKohiraDesc,
      problemSolved: AppStrings.projKohiraProblem,
      technologies: ["Flutter", "Dart", "GetX", "REST API", "SQLite"],
      features: [
        AppStrings.featureJewelryCatalog,
        AppStrings.featureCategoryFilters,
        AppStrings.featureSmartCheckout,
        AppStrings.featureGetxState,
      ],
      isFeatured: true,
      category: AppStrings.categoryMobile,
      githubUrl: AppUrl.projKohiraGithub,
      imageUrl: AppLogo.logoKohira,
    ),
    Project(
      name: AppStrings.projTradeAtName,
      description: AppStrings.projTradeAtDesc,
      problemSolved: AppStrings.projTradeAtProblem,
      technologies: ["Flutter", "Dart", "REST API", "Charts", "GetX"],
      features: [
        AppStrings.featureLiveMarketTracking,
        AppStrings.featurePortfolioAnalytics,
        AppStrings.featureInteractiveCharts,
        AppStrings.featureRealtimeAlerts,
      ],
      isFeatured: true,
      category: AppStrings.categoryMobile,
      githubUrl: AppUrl.projTradeAtGithub,
      imageUrl: AppLogo.logoTradeAt,
    ),
    Project(
      name: AppStrings.projHirExpertName,
      description: AppStrings.projHirExpertDesc,
      problemSolved: AppStrings.projHirExpertProblem,
      technologies: ["Flutter", "Dart", "Firebase", "Node.js", "GetX"],
      features: [
        AppStrings.featureJobSearch,
        AppStrings.featureRecruiterProfiles,
        AppStrings.featureInAppMessaging,
        AppStrings.featureInterviewManagement,
      ],
      isFeatured: true,
      category: AppStrings.categoryMobile,
      githubUrl: AppUrl.projHirExpertGithub,
      imageUrl: AppLogo.logoHirExpert,
    ),
    Project(
      name: AppStrings.projClassicName,
      description: AppStrings.projClassicDesc,
      problemSolved: AppStrings.projClassicProblem,
      technologies: ["Flutter", "Dart", "GetX", "UI/UX", "REST API"],
      features: [
        AppStrings.featureLuxuryShowcase,
        AppStrings.featureProductCustomization,
        AppStrings.featureSecurePayments,
        AppStrings.featureGetxState,
      ],
      isFeatured: false,
      category: AppStrings.categoryMobile,
      githubUrl: AppUrl.projClassicGithub,
      imageUrl: AppLogo.logoClassic,
    ),
    Project(
      name: AppStrings.projResumePortfolioName,
      description: AppStrings.projResumePortfolioDesc,
      problemSolved: AppStrings.projResumePortfolioProblem,
      technologies: ["Flutter Web", "Dart", "GetX", "Animate Do"],
      features: [
        AppStrings.featureResponsiveLayout,
        AppStrings.featureThemeSwitcher,
        AppStrings.featurePdfResumeViewer,
        AppStrings.featureGithubIntegration,
      ],
      isFeatured: false,
      category: AppStrings.categoryWeb,
      githubUrl: AppUrl.projResumePortfolioGithub,
    ),
  ];

  static final List<SkillCategory> skillCategories = [
    SkillCategory(
      title: AppStrings.skillCatMobile,
      skills: [
        Skill(name: "Flutter", icon: AppIcons.flutter),
        Skill(name: "Dart", icon: AppIcons.dart),
        Skill(name: "Android", icon: AppIcons.android),
        Skill(name: "iOS", icon: AppIcons.ios),
      ],
    ),
    SkillCategory(
      title: AppStrings.skillCatState,
      skills: [
        Skill(name: "GetX", icon: AppIcons.getx),
        Skill(name: "Provider", icon: AppIcons.provider),
        Skill(name: "Riverpod", icon: AppIcons.riverpod),
      ],
    ),
    SkillCategory(
      title: AppStrings.skillCatBackend,
      skills: [
        Skill(name: "REST API", icon: AppIcons.api),
        Skill(name: "Dio", icon: AppIcons.http),
        Skill(name: "Firebase", icon: AppIcons.firebase),
        Skill(name: "Auth", icon: AppIcons.auth),
      ],
    ),
    SkillCategory(
      title: AppStrings.skillCatTools,
      skills: [
        Skill(name: "Git", icon: AppIcons.gitAlt),
        Skill(name: "GitHub", icon: AppIcons.github),
        Skill(name: "Figma", icon: AppIcons.figma),
        Skill(name: "Postman", icon: AppIcons.postman),
      ],
    ),
  ];

  static final List<Service> services = [
    Service(
      title: AppStrings.serviceTitleMobile,
      description: AppStrings.serviceDescMobile,
      icon: AppIcons.mobileApp,
    ),
    Service(
      title: AppStrings.serviceTitleWeb,
      description: AppStrings.serviceDescWeb,
      icon: AppIcons.webApp,
    ),
    Service(
      title: AppStrings.serviceTitleUiUx,
      description: AppStrings.serviceDescUiUx,
      icon: AppIcons.uiDesign,
    ),
    Service(
      title: AppStrings.serviceTitleApi,
      description: AppStrings.serviceDescApi,
      icon: AppIcons.apiSync,
    ),
  ];

  static final List<Map<String, String>> processSteps = [
    {
      "title": AppStrings.processStep1Title,
      "desc": AppStrings.processStep1Desc,
    },
    {
      "title": AppStrings.processStep2Title,
      "desc": AppStrings.processStep2Desc,
    },
    {
      "title": AppStrings.processStep3Title,
      "desc": AppStrings.processStep3Desc,
    },
    {
      "title": AppStrings.processStep4Title,
      "desc": AppStrings.processStep4Desc,
    },
    {
      "title": AppStrings.processStep5Title,
      "desc": AppStrings.processStep5Desc,
    },
    {
      "title": AppStrings.processStep6Title,
      "desc": AppStrings.processStep6Desc,
    },
  ];

  static final List<Map<String, String>> achievements = [
    {"title": AppStrings.achieveTitle1, "value": AppStrings.achieveVal1},
    {"title": AppStrings.achieveTitle2, "value": AppStrings.achieveVal2},
    {"title": AppStrings.achieveTitle3, "value": AppStrings.achieveVal3},
    {"title": AppStrings.achieveTitle4, "value": AppStrings.achieveVal4},
  ];

  static const String email = AppStrings.email;
  static const String github = AppStrings.github;
  static const String linkedin = AppStrings.linkedin;
  static const String location = AppStrings.location;
}
