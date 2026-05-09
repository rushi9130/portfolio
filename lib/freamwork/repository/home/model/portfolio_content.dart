import 'package:personal_portfolio/freamwork/repository/home/model/project_info_model.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/tech_info.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/technical_models.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/testimonial_model.dart';
import 'package:personal_portfolio/ui/utils/theme/app_string.dart';

class JourneyEntry {
  final String title;
  final String company;
  final String duration;
  final List<String> points;

  const JourneyEntry({
    required this.title,
    required this.company,
    required this.duration,
    required this.points,
  });
}

class PortfolioContent {
  PortfolioContent._();

  static const String firstName = 'Rushikesh';
  static const String lastName = 'Ghegade';

  static const List<String> categories = [
    AppString.about,
    AppString.projects,
    AppString.experience,
    AppString.skills,
    AppString.testimonials,
    AppString.contact,
  ];

  static const List<String> expertiseList = [AppString.mobileDev, AppString.javeDev];
  static const List<String> workActions = [AppString.viewWork, AppString.connect];
  static const List<String> projectTabs = [AppString.allProject, AppString.mobileApp, AppString.webApp];

  static final List<TechInfo> aboutCounters = [
    TechInfo(count: 1, techStack: AppString.year),
    TechInfo(count: 6, techStack: AppString.project),
    TechInfo(count: 20, techStack: AppString.technology),
  ];

  static const String aboutTitlePrefix = 'About ';
  static const String aboutTitleAccent = 'Me';
  static const String aboutIntro =
      'I am a passionate Mobile Application Developer who graduated with a Bachelor of Engineering in Information Technology in 2025. ';
  static const String aboutExpPrefix = 'My journey includes hands-on internship experience at ';
  static const String aboutCompanyOne = 'AppsAit';
  static const String aboutJoin = ' and ';
  static const String aboutCompanyTwo = 'Kody Technolab';
  static const String aboutExpSuffix =
      ', where I developed practical skills in building real-world mobile applications. ';
  static const String aboutClosing =
      'I focus on creating scalable, user-centric apps with clean architecture, maintainable code, and strong performance and reliability.';

  static final List<ProjectInfoModel> projects = [
    ProjectInfoModel(
      projectName: "HEART RATE AND TEMPERATURE DETECTION MODEL USING IOT AND FLUTTER",
      projectDis:
          "Designed and developed an IoT-based health monitoring system using Arduino sensors for real-time vital tracking, cloud integration with ThingSpeak for data storage and visualization, a Flutter app for live metrics and alerts, and Git-based version control for efficient team collaboration.",
      technoloty: ["Arduino", "ThingSpeak", "Api", "dart", "Flutter"],
      gitHubLink: "https://github.com/rushi9130/health-monitoring-System",
    ),
    ProjectInfoModel(
      projectName: "AI-POWERED VEHICLE SERVICES ",
      projectDis:
          "Developed a Flutter-based vehicle service application with Google Maps integration for real-time navigation and nearby service discovery, a Firebase backend for authentication and bookings, and an AI-powered chatbot for instant vehicle-related assistance",
      technoloty: ["Flutter", "Dart", "Firebase", "Apis", "state management", "GoogleMap"],
      gitHubLink: "https://github.com/rushi9130/car-service-app",
    ),
    ProjectInfoModel(
      projectName: "COURCE APP",
      projectDis:
          "Developed a Flutter-based course application using Firebase for secure authentication and course management, Razorpay for secure payments, and features including video lectures, PDFs, quizzes, and local storage via Shared Preferences for a seamless learning experience.",
      technoloty: ["Flutter", "Firebase", "Storage", "Api", "state management"],
      gitHubLink: "https://github.com/rushi9130/Course-App",
    ),
  ];

  static final List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Programming Languages',
      skills: [SkillItem('Java', 0.9), SkillItem('Dart', 0.85), SkillItem('Python', 0.7)],
    ),
    SkillCategory(
      title: 'Frameworks & Tech',
      skills: [SkillItem('Flutter', 0.95), SkillItem('Spring Boot', 0.75)],
    ),
    SkillCategory(
      title: 'Web Technologies',
      skills: [SkillItem('HTML', 0.9), SkillItem('JavaScript', 0.8), SkillItem('React', 0.75)],
    ),
    SkillCategory(
      title: 'Databases',
      skills: [SkillItem('MySQL', 0.8), SkillItem('Firebase', 0.85)],
    ),
    SkillCategory(
      title: 'Tools & Platforms',
      skills: [
        SkillItem('Git/GitHub', 0.9),
        SkillItem('VS Code', 0.85),
        SkillItem('AI Toolkit (Claude, Gemini)', 0.8),
      ],
    ),
    SkillCategory(
      title: 'Core Concepts',
      skills: [SkillItem('OOP', 0.9), SkillItem('DSA', 0.8), SkillItem('Prompt Engineering', 0.75)],
    ),
  ];

  static const List<TestimonialModel> testimonials = [
    TestimonialModel(
      text:
          'Rushikesh demonstrated exceptional problem-solving skills and consistently delivered high-quality code. His optimization work improved our application performance significantly."',
      role: 'Project Manager',
      company: 'Apps Ait',
    ),
    TestimonialModel(
      text:
          '"His attention to detail in UI implementation and willingness to learn new technologies made him a valuable team member. A true professional in mobile development."',
      role: 'Team Lead',
      company: 'Kody Technolab Ltd',
    ),
    TestimonialModel(
      text:
          '"An incredibly fast learner who brings creativity to every project. His ability to integrate complex APIs into intuitive user interfaces is impressive."',
      role: 'Project Manager',
      company: 'Kody Technolab Ltd',
    ),
  ];

  static const List<JourneyEntry> journeyEntries = [
    JourneyEntry(
      title: 'Mobile Application Developer Intern',
      company: 'Apps Ait Ltd',
      duration: "October 2024 – June 2025",
      points: [
        'Worked on a Gaming App (Confidential) project using Flutter, completing 80% of the development successfully',
        'Optimized database interactions with Firebase.',
        'Gained hands-on experience in mobile app development, testing, and version control',
        'Used Git/GitHub with strict coding standards.',
        'Demonstrated strong problem-solving and self-learning abilities throughout the internship.'
      ],
    ),
    JourneyEntry(
      title: 'Mobile App Development Intern -> jr Consultant in Mobile Department',
      company: 'Kody Technolab Ltd',
      duration: 'July 2025 - Present ',
      points: [
        'Built and maintained production-grade Flutter applications, following DDD MVVM architecture with Provider and Riverpod for scalable and high-performance state management',
        'Integrated REST APIs using Dio and Firebase (Authentication, Firestore) to enable secure user flows, real-time data synchronization, and reliable network handling.',
        'Improved app stability and performance using Hive for offline storage, efficient widget composition, and GitHub-based collaboration (branching, pull requests, code reviews)',
        'Implemented robust error handling, API retry logic, and global exception management, significantly reducing crash scenarios and improving overall app reliability.'
      ],
    ),
  ];

  static const String myLocation = "Based in Pimpri, Pune, Maharashtra, India";
  static const String phoneNumber = "8530321810";
  static const String email = "ghegaderushikesh065@gmail.com";
  static const String linkedInUrl = "https://www.linkedin.com/in/rushikesh-ghegade-894076295/";
  static const String githubUrl = "https://github.com/rushi9130";
}
