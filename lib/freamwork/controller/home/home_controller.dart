import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:personal_portfolio/freamwork/dependency_injection/inject.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/portfolio_content.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/project_info_model.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/tech_info.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/testimonial_model.dart';
import 'package:personal_portfolio/ui/about/about_me.dart';
import 'package:personal_portfolio/ui/contact/contact.dart';
import 'package:personal_portfolio/ui/home/home_screen.dart';
import 'package:personal_portfolio/ui/my_journey/my_journey.dart';
import 'package:personal_portfolio/ui/myproject/my_project.dart';
import 'package:personal_portfolio/ui/technical_skills/technical_skills.dart';
import 'package:personal_portfolio/ui/testimonial/testimonial.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/home/model/technical_models.dart';

final homeController = ChangeNotifierProvider((ref) {
  return getIt<HomeController>();
});

@injectable
class HomeController extends ChangeNotifier {
  HomeController(this._firestore) {
    initController();
  }

  final FirebaseFirestore _firestore;

  /// screens
  List<Widget> screens = [
    HomeScreen(),
    AboutMeScreen(),
    MyProject(),
    MyJourney(),
    TechnicalSkills(),
    Testimonial(),
    Contact(),
    // Footer()
  ];

  /// HomeScreen

  /// init
  void initController() {
    addTimerForChnageExperties();
    _listenPortfolioContent();
    _listenProjectsCollection();
  }

  /// dispose Controller
  void disposeController() {
    timer?.cancel();
    _contentSubscription?.cancel();
    _projectsSubscription?.cancel();
  }

  /// app theme
  bool isDarkOn = true;
  void changeTheme(bool isDarkOn) {
    this.isDarkOn = isDarkOn;
    notifyListeners();
  }

  /// mouse regin
  int currentMouseReginIndex = -1;
  void chnageMouseReginIndex(int newIndex) {
    currentMouseReginIndex = newIndex;
    notifyListeners();
  }

  /// current selected Index
  int watchIndex = 0;
  void chnageIndex(int newIndex) {
    if (watchIndex == newIndex) return;
    print("Change the index : $newIndex");
    if (newIndex == 1) {
      slectWorkAction = 0;
    } else if (newIndex == 5) {
      slectWorkAction = 1;
    } else {
      slectWorkAction = -1;
    }
    print("Watch index : $newIndex");
    watchIndex = newIndex;
    jumpPage(watchIndex);
  }

  /// page controller
  final PageController pageController = PageController();

  void jumpPage(int page) {
    print("object");
    if (pageController.hasClients) {
      print("Animation happend at : $page");
      pageController.animateToPage(
        page + 1,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
    notifyListeners();
  }

  /// Page Categories
  List<String> category = List.from(PortfolioContent.categories);

  /// my Experties
  int expertiesIndex = 0;
  Timer? timer;
  void addTimerForChnageExperties() {
    timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (expertiesIndex == myExpertiseList.length - 1) {
        expertiesIndex = 0;
      } else {
        expertiesIndex++;
      }
      notifyListeners();
    });
  }

  List<String> myExpertiseList = List.from(PortfolioContent.expertiseList);

  /// perform actino
  List<String> workAndConnect = List.from(PortfolioContent.workActions);

  /// mouse regin
  int currentMouseReginForAction = -1;
  void chnageMouseReginForAction(int newIndex) {
    currentMouseReginForAction = newIndex;
    notifyListeners();
  }

  int slectWorkAction = -1;

  /// Android vertical [PageView]: target page index (0=Home … 6=Contact). Consumed by [MobileMainPage].
  int? mobileVerticalPageRequest;

  void clearMobileVerticalPageRequest() {
    mobileVerticalPageRequest = null;
  }

  /// Call when mobile pager lands on Home so “View Work / Connect” highlight clears.
  void syncMobilePagerAtHome() {
    slectWorkAction = -1;
    notifyListeners();
  }

  void changeWorkAction(int newIndex) {
    if (!kIsWeb) {
      // Mobile: 2 = MyProjectMobile, 6 = ContactMobile
      mobileVerticalPageRequest = newIndex == 0 ? 2 : 6;
      slectWorkAction = newIndex;
      notifyListeners();
      return;
    }
    if (newIndex == 0) {
      chnageIndex(1); // Web: category 1 = Projects
    } else {
      chnageIndex(5); // Web: category 5 = Contact
    }
    slectWorkAction = newIndex;
    print("New Index : $slectWorkAction");
    notifyListeners();
  }

  /// About Me Screen
  List<TechInfo> aboutMeList = List.from(PortfolioContent.aboutCounters);
  String firstName = PortfolioContent.firstName;
  String lastName = PortfolioContent.lastName;
  String aboutTitlePrefix = PortfolioContent.aboutTitlePrefix;
  String aboutTitleAccent = PortfolioContent.aboutTitleAccent;
  String aboutIntro = PortfolioContent.aboutIntro;
  String aboutExpPrefix = PortfolioContent.aboutExpPrefix;
  String aboutCompanyOne = PortfolioContent.aboutCompanyOne;
  String aboutJoin = PortfolioContent.aboutJoin;
  String aboutCompanyTwo = PortfolioContent.aboutCompanyTwo;
  String aboutExpSuffix = PortfolioContent.aboutExpSuffix;
  String aboutClosing = PortfolioContent.aboutClosing;
  String homeImageUrl = '';

  /// My Peoject Screen
  List<String> myProject = List.from(PortfolioContent.projectTabs);

  /// mouse Regin
  int myProjectTitleMouseReginIndex = -1;
  void changeMyProjectTitleMouseReginIndex(int newIndex) {
    myProjectTitleMouseReginIndex = newIndex;
    notifyListeners();
  }

  /// select Project
  int currentSelectProjectIndex = 0;
  void chnageCurrentSelectProjectIndex(int newIndex) {
    currentSelectProjectIndex = newIndex;
    addFilter();
  }

  /// projects
  List<ProjectInfoModel> filterProjects = [];

  void addFilter() {
    filterProjects.clear();

    if (currentSelectProjectIndex == 1) {
      filterProjects = projects.where((ele) => ele.isMobile == true).toList();
    } else if (currentSelectProjectIndex == 2) {
      filterProjects = projects.where((ele) => ele.isMobile != true).toList();
    } else {
      filterProjects = List.from(projects);
    }

    notifyListeners();
  }

  /// created container
  int selectProjectMouseReginIndex = -1;

  void changeSelectProjectMouseReginIndex(int newIndex) {
    selectProjectMouseReginIndex = newIndex;
    notifyListeners();
  }

  List<ProjectInfoModel> projects = List.from(PortfolioContent.projects);

  /// technical skiils
  List<SkillCategory> skillCategories = List.from(PortfolioContent.skillCategories);




  /// testimonial
  int currentTestimonialIndex = 0;


  void changeTestimonialIndex(int newIndex){
    currentTestimonialIndex = newIndex;
    notifyListeners();
  }

  List<TestimonialModel> testimonials = List.from(PortfolioContent.testimonials);
  List<JourneyEntry> journeyEntries = List.from(PortfolioContent.journeyEntries);

  ///contact with me
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  /// all this data come form firebase
  String myLocation = PortfolioContent.myLocation;
  String phoneNumber = PortfolioContent.phoneNumber;
  String email = PortfolioContent.email;
  String linkDinUrl = PortfolioContent.linkedInUrl;
  String githubUrl = PortfolioContent.githubUrl;

  bool isSending = false;
  bool isPortfolioLoading = false;
  String? portfolioLoadError;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _contentSubscription;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _projectsSubscription;

  void _listenPortfolioContent() {
    _contentSubscription?.cancel();
    isPortfolioLoading = true;
    portfolioLoadError = null;
    notifyListeners();

    _contentSubscription = _firestore
        .collection('portfolio')
        .doc('content')
        .snapshots()
        .listen(
      (doc) {
        final data = doc.data();
        if (data == null) {
          isPortfolioLoading = false;
          notifyListeners();
          return;
        }

        firstName = _stringValue(data['firstName'], firstName);
        lastName = _stringValue(data['lastName'], lastName);
        category = _stringList(data['category'], category);
        myExpertiseList = _stringList(data['myExpertiseList'], myExpertiseList);
        workAndConnect = _stringList(data['workAndConnect'], workAndConnect);
        myProject = _stringList(data['myProjectTabs'], myProject);

        final about = _mapValue(data['about']);
        if (about != null) {
          aboutTitlePrefix = _stringValue(about['titlePrefix'], aboutTitlePrefix);
          aboutTitleAccent = _stringValue(about['titleAccent'], aboutTitleAccent);
          aboutIntro = _stringValue(about['intro'], aboutIntro);
          aboutExpPrefix = _stringValue(about['experiencePrefix'], aboutExpPrefix);
          aboutCompanyOne = _stringValue(about['companyOne'], aboutCompanyOne);
          aboutJoin = _stringValue(about['joinText'], aboutJoin);
          aboutCompanyTwo = _stringValue(about['companyTwo'], aboutCompanyTwo);
          aboutExpSuffix = _stringValue(about['experienceSuffix'], aboutExpSuffix);
          aboutClosing = _stringValue(about['closing'], aboutClosing);
          aboutMeList = _techInfoList(about['counters'], aboutMeList);
        }
        final homeData = _mapValue(data['home']);
        if (homeData != null) {
          homeImageUrl = _stringValue(homeData['imageUrl'], homeImageUrl);
        } else {
          homeImageUrl = _stringValue(data['homeImageUrl'], homeImageUrl);
        }

        // Keep backward compatibility if projects are still inside content doc.
        projects = _projectsList(data['projects'], projects);
        skillCategories = _skillCategoryList(data['skills'], skillCategories);
        testimonials = _testimonialList(data['testimonials'], testimonials);
        journeyEntries = _journeyList(data['journey'], journeyEntries);

        final contact = _mapValue(data['contact']);
        if (contact != null) {
          myLocation = _stringValue(contact['location'], myLocation);
          phoneNumber = _stringValue(contact['phoneNumber'], phoneNumber);
          email = _stringValue(contact['email'], email);
          linkDinUrl = _stringValue(contact['linkedInUrl'], linkDinUrl);
          githubUrl = _stringValue(contact['githubUrl'], githubUrl);
        }

        addFilter();
        isPortfolioLoading = false;
        notifyListeners();
      },
      onError: (e) {
        portfolioLoadError = e.toString();
        isPortfolioLoading = false;
        notifyListeners();
      },
    );
  }

  void _listenProjectsCollection() {
    _projectsSubscription?.cancel();
    _projectsSubscription = _firestore
        .collection('projects')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isEmpty) {
          return;
        }
        final fromCollection = snapshot.docs.map((doc) {
          final map = doc.data();
          final media = <MediaAsset>[];
          final rawMedia = map['mediaAssets'];
          if (rawMedia is List) {
            for (final item in rawMedia) {
              final mediaMap = _mapValue(item);
              if (mediaMap == null) continue;
              final mediaUrl = _stringValue(mediaMap['url'], '');
              if (mediaUrl.isEmpty) continue;
              media.add(
                MediaAsset(
                  url: mediaUrl,
                  type: _stringValue(mediaMap['type'], 'image'),
                ),
              );
            }
          }
          return ProjectInfoModel(
            id: doc.id,
            projectName: _stringValue(map['projectName'], ''),
            projectDis: _stringValue(map['projectDis'], ''),
            technoloty: _stringList(map['technoloty'], const []),
            gitHubLink: _stringValue(map['gitHubLink'], ''),
            isMobile: map['isMobile'] is bool ? map['isMobile'] as bool : true,
            mediaAssets: media,
          );
        }).where((p) => p.projectName.isNotEmpty).toList();
        if (fromCollection.isNotEmpty) {
          projects = fromCollection;
          addFilter();
        }
      },
      onError: (_) {},
    );
  }

  String _stringValue(dynamic value, String fallback) {
    return value is String && value.trim().isNotEmpty ? value : fallback;
  }

  List<String> _stringList(dynamic value, List<String> fallback) {
    if (value is! List) return fallback;
    final result = value.whereType<String>().map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return result.isEmpty ? fallback : result;
  }

  Map<String, dynamic>? _mapValue(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return value.map((key, val) => MapEntry(key.toString(), val));
    return null;
  }

  List<TechInfo> _techInfoList(dynamic value, List<TechInfo> fallback) {
    if (value is! List) return fallback;
    final result = <TechInfo>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final label = _stringValue(map['techStack'] ?? map['label'], '');
      final countValue = map['count'];
      final count = countValue is int ? countValue : int.tryParse(countValue?.toString() ?? '');
      if (label.isNotEmpty && count != null) {
        result.add(TechInfo(count: count, techStack: label));
      }
    }
    return result.isEmpty ? fallback : result;
  }

  List<ProjectInfoModel> _projectsList(dynamic value, List<ProjectInfoModel> fallback) {
    if (value is! List) return fallback;
    final result = <ProjectInfoModel>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final name = _stringValue(map['projectName'], '');
      final description = _stringValue(map['projectDis'], '');
      final link = _stringValue(map['gitHubLink'], '');
      if (name.isEmpty || description.isEmpty || link.isEmpty) continue;
      result.add(
        ProjectInfoModel(
          id: _stringValue(map['id'], ''),
          projectName: name,
          projectDis: description,
          technoloty: _stringList(map['technoloty'], const []),
          gitHubLink: link,
          isMobile: map['isMobile'] is bool ? map['isMobile'] as bool : true,
          mediaAssets: _mediaAssetList(map['mediaAssets']),
        ),
      );
    }
    return result.isEmpty ? fallback : result;
  }

  List<MediaAsset> _mediaAssetList(dynamic value) {
    if (value is! List) return const [];
    final result = <MediaAsset>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final mediaUrl = _stringValue(map['url'], '');
      if (mediaUrl.isEmpty) continue;
      result.add(MediaAsset(url: mediaUrl, type: _stringValue(map['type'], 'image')));
    }
    return result;
  }

  List<SkillCategory> _skillCategoryList(dynamic value, List<SkillCategory> fallback) {
    if (value is! List) return fallback;
    final result = <SkillCategory>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final title = _stringValue(map['title'], '');
      if (title.isEmpty) continue;
      final skillsRaw = map['skills'];
      if (skillsRaw is! List) continue;
      final skills = <SkillItem>[];
      for (final skill in skillsRaw) {
        final skillMap = _mapValue(skill);
        if (skillMap == null) continue;
        final name = _stringValue(skillMap['name'], '');
        final levelValue = skillMap['level'];
        final level = levelValue is num ? levelValue.toDouble() : double.tryParse(levelValue?.toString() ?? '');
        if (name.isNotEmpty && level != null) {
          skills.add(SkillItem(name, level.clamp(0.0, 1.0)));
        }
      }
      if (skills.isNotEmpty) {
        result.add(SkillCategory(title: title, skills: skills));
      }
    }
    return result.isEmpty ? fallback : result;
  }

  List<TestimonialModel> _testimonialList(dynamic value, List<TestimonialModel> fallback) {
    if (value is! List) return fallback;
    final result = <TestimonialModel>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final text = _stringValue(map['text'], '');
      final role = _stringValue(map['role'], '');
      final company = _stringValue(map['company'], '');
      if (text.isNotEmpty && role.isNotEmpty && company.isNotEmpty) {
        result.add(TestimonialModel(text: text, role: role, company: company));
      }
    }
    return result.isEmpty ? fallback : result;
  }

  List<JourneyEntry> _journeyList(dynamic value, List<JourneyEntry> fallback) {
    if (value is! List) return fallback;
    final result = <JourneyEntry>[];
    for (final item in value) {
      final map = _mapValue(item);
      if (map == null) continue;
      final title = _stringValue(map['title'], '');
      final company = _stringValue(map['company'], '');
      final duration = _stringValue(map['duration'], '');
      final points = _stringList(map['points'], const []);
      if (title.isNotEmpty && company.isNotEmpty && duration.isNotEmpty && points.isNotEmpty) {
        result.add(JourneyEntry(title: title, company: company, duration: duration, points: points));
      }
    }
    return result.isEmpty ? fallback : result;
  }

  Future<void> sendMessage(BuildContext context) async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    isSending = true;
    notifyListeners();

    try {
      await _firestore.collection('messages').add({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'subject': subjectController.text.trim(),
        'message': messageController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'isRead': false,
      });
    } catch (e) {
      isSending = false;
      notifyListeners();
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send message: $e")),
      );
      return;
    }

    isSending = false;
    notifyListeners();

    nameController.clear();
    emailController.clear();
    subjectController.clear();
    messageController.clear();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Message sent successfully")),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  int clickContactContainerMouse = -1;
  int clickContactContainer = -1;

  void changeClickContactContainer(int index)async{
    clickContactContainer = index;
    notifyListeners();

    if(index==0){
      await openLink('tel:+91$phoneNumber');
    }else if(index==1){
      await openLink(
          'mailto:$email'
              '?subject=Contact from Portfolio'
      );
    }else if(index==2){
      await openLink(linkDinUrl);
    }else{
      await openLink(githubUrl);
    }

  }

  void changeClickContactMouseContainer(int index){
    clickContactContainerMouse = index;
    notifyListeners();
  }

  Future<void> openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $url';
    }
  }

}
