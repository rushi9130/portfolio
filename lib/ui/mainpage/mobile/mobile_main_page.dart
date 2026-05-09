import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/repository/home/model/portfolio_content.dart';
import 'package:personal_portfolio/ui/about/mobile/about_me_mobile.dart';
import 'package:personal_portfolio/ui/contact/mobile/contact_mobile.dart';
import 'package:personal_portfolio/ui/home/mobile/home_screen_mobile.dart';
import 'package:personal_portfolio/ui/my_journey/mobile/my_jouney_mobile.dart';
import 'package:personal_portfolio/ui/myproject/mobile/my_project_mobile.dart';
import 'package:personal_portfolio/ui/technical_skills/mobile/technical_skills_mobile.dart';
import 'package:personal_portfolio/ui/testimonial/mobile/testimonial_mobile.dart';
import 'package:personal_portfolio/ui/utils/mobile_ui_tokens.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

/// Android: **one vertical [ListView]** — every section is stacked and you scroll
/// through Home → About → … → Contact like one long page (no nested vertical [PageView]).
/// Drawer / “View Work” use [Scrollable.ensureVisible] to jump.
class MobileMainPage extends ConsumerStatefulWidget {
  const MobileMainPage({super.key});

  @override
  ConsumerState<MobileMainPage> createState() => _MobileMainPageState();
}

class _MobileMainPageState extends ConsumerState<MobileMainPage> {
  late final ScrollController _scrollController;
  late final List<GlobalKey> _sectionKeys;

  int _pageIndex = 0;

  static const _homeLabel = 'Home';

  static const _screens = [
    HomeScreenMobile(),
    AboutMeMobile(),
    MyProjectMobile(),
    MyJouneyMobile(),
    TechnicalSkillsMobile(),
    TestimonialMobile(),
    ContactMobile(),
  ];

  List<String> _navLabels(HomeController c) {
    const sectionCount = 6;
    final fallback = PortfolioContent.categories;
    final fromRemote = c.category;
    final rest = List<String>.generate(sectionCount, (i) {
      if (i < fromRemote.length && fromRemote[i].trim().isNotEmpty) {
        return fromRemote[i];
      }
      return i < fallback.length ? fallback[i] : 'Section ${i + 1}';
    });
    return [_homeLabel, ...rest];
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _sectionKeys = List<GlobalKey>.generate(_screens.length, (_) => GlobalKey());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Which section’s top is at or above the viewport top (same idea as web vertical flow).
  int _computeVisibleSectionIndex() {
    if (!_scrollController.hasClients) return _pageIndex;
    final pixels = _scrollController.offset;
    var best = 0;
    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      final ro = ctx?.findRenderObject();
      if (ro == null || !ro.attached) continue;
      final viewport = RenderAbstractViewport.maybeOf(ro);
      if (viewport == null) continue;
      final revealed = viewport.getOffsetToReveal(ro, 0.0);
      if (revealed.offset <= pixels + 72) {
        best = i;
      }
    }
    return best;
  }

  void _applySectionIndex(int idx) {
    if (idx == _pageIndex) return;
    setState(() => _pageIndex = idx);
    final read = ref.read(homeController);
    if (idx == 0) {
      read.syncMobilePagerAtHome();
    } else {
      read.chnageIndex(idx - 1);
    }
  }

  void _syncSectionFromScroll() {
    _applySectionIndex(_computeVisibleSectionIndex());
  }

  Future<void> _scrollToSection(int index) async {
    final i = index.clamp(0, _sectionKeys.length - 1);
    final ctx = _sectionKeys[i].currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
    if (mounted) _applySectionIndex(i);
  }

  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeController);

    ref.listen<HomeController>(homeController, (prev, next) {
      final req = next.mobileVerticalPageRequest;
      if (req != null) {
        final target = req.clamp(0, _sectionKeys.length - 1);
        next.clearMobileVerticalPageRequest();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _scrollToSection(target);
        });
      }
    });

    final isDark = watch.isDarkOn;
    final appBarBg = MobileUiTokens.appBarBg(isDark);
    final primaryText = MobileUiTokens.bodyText(isDark);
    final accent = MobileUiTokens.accent;
    final labels = _navLabels(watch);
    final bgGradient = MobileUiTokens.pageGradient(isDark);

    return Scaffold(
      backgroundColor: bgGradient.first,
      appBar: AppBar(
        backgroundColor: appBarBg,
        foregroundColor: primaryText,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: primaryText,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(text: '${watch.firstName} '),
                  TextSpan(text: watch.lastName, style: const TextStyle(color: MobileUiTokens.accent)),
                ],
              ),
            ),
            Text(
              labels[_pageIndex.clamp(0, labels.length - 1)],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: accent.withValues(alpha: 0.95),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => watch.changeTheme(!isDark),
            icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            color: primaryText,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: MobileUiTokens.drawerBg(isDark),
        child: SafeArea(
          child: ListView(
            primary: false,
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: bgGradient),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${watch.firstName} ${watch.lastName}',
                      style: TextStyle(
                        color: MobileUiTokens.bodyText(isDark),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[_pageIndex.clamp(0, labels.length - 1)],
                      style: TextStyle(
                        color: accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(labels.length, (i) {
                final selected = i == _pageIndex;
                return ListTile(
                  selected: selected,
                  selectedColor: accent,
                  iconColor: selected ? accent : primaryText.withValues(alpha: 0.85),
                  textColor: primaryText,
                  selectedTileColor: accent.withValues(alpha: 0.14),
                  leading: Icon(_drawerIcon(i)),
                  title: Text(labels[i], style: const TextStyle(fontWeight: FontWeight.w500)),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _scrollToSection(i);
                  },
                );
              }),
            ],
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: bgGradient),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: IgnorePointer(
                child: Opacity(
                  opacity: isDark ? 0.8 : 0.45,
                  child: ParticleBackground(
                    particleColor: isDark ? Colors.orange : const Color(0xFF8FA7BF),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Theme(
                data: Theme.of(context).copyWith(
                  cardTheme: CardThemeData(
                    color: MobileUiTokens.cardBg(isDark),
                    surfaceTintColor: Colors.transparent,
                    elevation: 2,
                    shadowColor: Colors.black.withValues(alpha: isDark ? 0.35 : 0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  listTileTheme: ListTileThemeData(
                    iconColor: primaryText.withValues(alpha: 0.9),
                    textColor: primaryText,
                  ),
                  chipTheme: ChipThemeData(
                    backgroundColor: isDark ? const Color(0xFF1C344D) : Colors.white,
                    selectedColor: accent.withValues(alpha: 0.35),
                    disabledColor: Colors.grey.withValues(alpha: 0.3),
                    labelStyle: TextStyle(color: primaryText, fontSize: 13),
                    secondaryLabelStyle: TextStyle(color: primaryText),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final vh = constraints.maxHeight;
                    return NotificationListener<ScrollNotification>(
                      onNotification: (n) {
                        if (n is ScrollEndNotification) {
                          _syncSectionFromScroll();
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.zero,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Column(
                          children: [
                            for (var i = 0; i < _screens.length; i++)
                              KeyedSubtree(
                                key: _sectionKeys[i],
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: vh),
                                  child: _sectionShell(i, vh, _screens[i]),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Short sections (home/about): center in at least one viewport. Long sections: top-align.
  Widget _sectionShell(int index, double vh, Widget screen) {
    final centerShort = index <= 1;
    if (centerShort) {
      return Center(
        child: screen,
      );
    }
    return Align(
      alignment: Alignment.topCenter,
      child: screen,
    );
  }

  IconData _drawerIcon(int i) {
    switch (i) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.person_outline;
      case 2:
        return Icons.work_outline;
      case 3:
        return Icons.timeline_outlined;
      case 4:
        return Icons.auto_awesome_motion_outlined;
      case 5:
        return Icons.format_quote_outlined;
      case 6:
        return Icons.mail_outline;
      default:
        return Icons.circle_outlined;
    }
  }
}
