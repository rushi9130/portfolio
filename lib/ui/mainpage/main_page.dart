import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/dependency_injection/inject.dart';
import 'package:personal_portfolio/freamwork/service/analytics/analytics_service.dart';
import 'package:personal_portfolio/ui/mainpage/mobile/mobile_main_page.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileMainPage(),
      tablet: (context) => const MobileMainPage(),
      desktop: (context) => _buildWebLayout(context),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final appBarBg = isDark ? const Color(0xFF0A182C) : const Color(0xFFEAF1FB);
    final primaryText = isDark ? Colors.white : const Color(0xFF102A43);
    const accent = Color(0xFFF5C542);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // If the layout builder ever gets a small width (e.g. browser resize), 
        // ScreenTypeLayout should have already handled it, but this is a safety.
        if (width < 900) {
          return const MobileMainPage();
        }

        final titleSize = width >= 1600 ? 22.0 : width >= 1200 ? 19.0 : 16.0;
        final navSize = width >= 1600 ? 15.0 : width >= 1200 ? 14.0 : 12.5;
        final navMaxWidth = (width * 0.52).clamp(260.0, 900.0);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: appBarBg,
            scrolledUnderElevation: 0,
            title: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => watch.chnageIndex(-1),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: titleSize,
                      color: primaryText,
                      wordSpacing: 1.2,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(text: '${watch.firstName} '),
                      TextSpan(
                          text: watch.lastName,
                          style: const TextStyle(color: Color(0xFFF5C542))),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: navMaxWidth),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(watch.category.length, (index) {
                      final category = watch.category[index];
                      final isSelected = watch.currentMouseReginIndex == index || watch.watchIndex == index;
                      return MouseRegion(
                        onEnter: (v) => watch.chnageMouseReginIndex(index),
                        onExit: (v) => watch.chnageMouseReginIndex(-1),
                        child: GestureDetector(
                          onTap: () => watch.chnageIndex(index),
                          child: Container(
                            height: AppBar().preferredSize.height * 0.6,
                            decoration: isSelected
                                ? BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: accent, width: 2.0),
                                    ),
                                  )
                                : null,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 20.w),
                            child: CommonText(
                              title: category,
                              textStyle: TextStyle(
                                color: isSelected ? accent : primaryText,
                                fontSize: navSize,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              watch.isDarkOn
                  ? GestureDetector(
                      onTap: () => watch.changeTheme(false),
                      child: Icon(Icons.dark_mode, color: primaryText),
                    )
                  : GestureDetector(
                      onTap: () => watch.changeTheme(true),
                      child: Icon(Icons.dark_mode_outlined, color: primaryText),
                    ),
              SizedBox(width: 12.w),
            ],
          ),
          body: PageView.builder(
            controller: watch.pageController,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (ind) {
              watch.chnageIndex(ind - 1, isManualScroll: true);
              
              // Track screen view
              if (ind > 0 && ind <= watch.category.length) {
                final screenName = watch.category[ind - 1];
                getIt<AnalyticsService>().trackScreenView(screenName);
              } else if (ind == 0) {
                getIt<AnalyticsService>().trackScreenView('Home');
              }
            },
            pageSnapping: true,
            itemCount: watch.screens.length,
            itemBuilder: (context, index) => watch.screens[index],
          ),
        );
      },
    );
  }
}
