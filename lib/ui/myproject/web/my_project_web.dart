import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/padding_extension.dart';
import 'package:personal_portfolio/ui/myproject/helper/show_project_view_dialog.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';

class MyProjectWeb extends ConsumerStatefulWidget {
  const MyProjectWeb({super.key});

  @override
  ConsumerState<MyProjectWeb> createState() => _MyProjectWebState();
}

class _MyProjectWebState extends ConsumerState<MyProjectWeb>
    with BaseConsumerStatefulWidget {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timer) {
      final read = ref.read(homeController);
      read.addFilter();
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final bgGradient = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    final accent = const Color(0xFFF5C542);
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(gradient: LinearGradient(colors: bgGradient)),
      child: Stack(
        children: [
          /// background dots
          SizedBox(
            width: context.width,
            height: context.height,
            child: Opacity(
              opacity: isDark ? 0.8 : 0.45,
              child: ParticleBackground(
                particleColor: isDark ? Colors.orange : const Color(0xFF8FA7BF),
              ),
            ),
          ),

          /// ui on screen
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final cardWidth = maxWidth >= 1600
                  ? 360.0
                  : maxWidth >= 1200
                      ? 320.0
                      : maxWidth >= 900
                          ? 280.0
                          : maxWidth * 0.84;
              final cardHeight = (constraints.maxHeight * 0.62).clamp(420.0, 720.0);
              final titleSize = maxWidth >= 1200 ? 40.0 : maxWidth >= 900 ? 34.0 : 28.0;
              final sectionGap = maxWidth >= 1200 ? 36.0 : 20.0;
              final chipText = maxWidth >= 1200 ? 13.0 : 12.0;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.02),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: sectionGap),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: titleSize,
                            color: textColor,
                            wordSpacing: 2,
                            fontWeight: FontWeight.w600,
                          ),
                          children: const [
                            TextSpan(text: 'My '),
                            TextSpan(text: 'Projects', style: TextStyle(color: Color(0xFFF5C542))),
                          ],
                        ),
                      ),
                      SizedBox(height: sectionGap),
                      SizedBox(
                        height: 56,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(watch.myProject.length, (index) {
                              final isSelected = watch.myProjectTitleMouseReginIndex == index ||
                                  watch.currentSelectProjectIndex == index;
                              return MouseRegion(
                                onEnter: (v) => watch.changeMyProjectTitleMouseReginIndex(index),
                                onExit: (v) => watch.changeMyProjectTitleMouseReginIndex(-1),
                                child: GestureDetector(
                                  onTap: () => watch.chnageCurrentSelectProjectIndex(index),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 18.w),
                                    decoration: BoxDecoration(
                                      color: isSelected ? accent : null,
                                      borderRadius: BorderRadius.circular(80.r),
                                      border: Border.all(color: textColor.withValues(alpha: 0.4)),
                                    ),
                                    alignment: Alignment.center,
                                    child: CommonText(
                                      title: watch.myProject[index],
                                      textStyle: TextStyle(
                                        color: isSelected ? Colors.black : textColor,
                                        fontSize: maxWidth >= 1200 ? 16 : 14,
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
                      SizedBox(height: sectionGap),
                      Expanded(
                        child: watch.filterProjects.isEmpty
                            ? Center(
                                child: CommonText(
                                  maxLines: 2,
                                  title:
                                      "No ${watch.currentSelectProjectIndex == 1 ? "Mobile" : "Web"} Projects Available",
                                  textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: maxWidth >= 1200 ? 18 : 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              watch.filterProjects.length,
                                  (index) {
                                final item = watch.filterProjects[index];
                                final isHover = watch.selectProjectMouseReginIndex == index;

                                return Padding(
                                  padding: EdgeInsets.only(right: 15.w),
                                  child: GestureDetector(
                                    onTap: () => showProjectDialog(context, item),
                                    child: MouseRegion(
                                      onEnter: (v) => watch.changeSelectProjectMouseReginIndex(index),
                                      onExit: (v) => watch.changeSelectProjectMouseReginIndex(-1),
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 350),
                                        curve: Curves.easeInOut,
                                        transform: Matrix4.identity()
                                          ..translate(0.0, isHover ? -14.0 : 0.0)
                                          ..scale(isHover ? 1.02 : 1.0),
                                        width: cardWidth,
                                        height: cardHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(32.r),

                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: isDark
                                                ? [
                                              const Color(0xFF132238),
                                              const Color(0xFF0D1B2A),
                                            ]
                                                : [
                                              Colors.white,
                                              const Color(0xFFF7FAFD),
                                            ],
                                          ),

                                          border: Border.all(
                                            color: isHover
                                                ? accent.withValues(alpha: 0.45)
                                                : Colors.white.withValues(alpha: isDark ? 0.06 : 0.7),
                                            width: 1,
                                          ),

                                          boxShadow: [

                                            /// main soft shadow
                                            BoxShadow(
                                              color: isDark
                                                  ? Colors.black.withValues(alpha: 0.22)
                                                  : const Color(0xFFB8C6DB).withValues(alpha: 0.18),
                                              blurRadius: isHover ? 22 : 14,
                                              spreadRadius: -2,
                                              offset: Offset(0, isHover ? 14 : 8),
                                            ),

                                            /// top glow
                                            if (isHover)
                                              BoxShadow(
                                                color: accent.withValues(alpha: 0.10),
                                                blurRadius: 24,
                                                spreadRadius: -4,
                                                offset: const Offset(0, 4),
                                              ),
                                          ],
                                        ),
                                        child: Column(
                                          children: [

                                            /// TOP SECTION
                                            AnimatedContainer(
                                              duration: const Duration(milliseconds: 350),
                                              height: cardHeight * 0.34,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(32.r),
                                                  topRight: Radius.circular(32.r),
                                                ),
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: isHover
                                                      ? [
                                                    accent.withValues(alpha: 0.28),
                                                    accent.withValues(alpha: 0.08),
                                                  ]
                                                      : isDark
                                                      ? [
                                                    const Color(0xFF132F4C),
                                                    const Color(0xFF0E2239),
                                                  ]
                                                      : [
                                                    const Color(0xFFEAF2FC),
                                                    const Color(0xFFDCE9F8),
                                                  ],
                                                ),
                                              ),
                                              child: Stack(
                                                children: [

                                                  Positioned(
                                                    top: -40,
                                                    right: -30,
                                                    child: AnimatedContainer(
                                                      duration: const Duration(milliseconds: 400),
                                                      height: isHover ? 140 : 110,
                                                      width: isHover ? 140 : 110,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: accent.withValues(alpha: 0.08),
                                                      ),
                                                    ),
                                                  ),

                                                  Center(
                                                    child: AnimatedSwitcher(
                                                      duration: const Duration(milliseconds: 300),
                                                      child: isHover
                                                          ? Container(
                                                        key: const ValueKey("view"),
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 28.w,
                                                          vertical: 14.h,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50.r),
                                                          color: accent.withValues(alpha: 0.12),
                                                          border: Border.all(
                                                            color: accent,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.arrow_outward_rounded,
                                                              color: accent,
                                                              size: 20,
                                                            ),
                                                            SizedBox(width: 8.w),
                                                            CommonText(
                                                              title: "View Project",
                                                              textStyle: TextStyle(
                                                                color: accent,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: maxWidth >= 1200 ? 17 : 15,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                          : Padding(
                                                        key: const ValueKey("title"),
                                                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                                                        child: CommonText(
                                                          textAlign: TextAlign.center,
                                                          maxLines: 4,
                                                          title: item.projectName,
                                                          textStyle: TextStyle(
                                                            color: accent,
                                                            fontSize: maxWidth >= 1200 ? 19 : 16,
                                                            fontWeight: FontWeight.bold,
                                                            letterSpacing: 0.4,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// BOTTOM CONTENT
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(20.r),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [

                                                    /// title
                                                    CommonText(
                                                      maxLines: 2,
                                                      title: item.projectName,
                                                      textStyle: TextStyle(
                                                        color: textColor,
                                                        fontSize: maxWidth >= 1200 ? 18 : 15,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),

                                                    SizedBox(height: 12.h),

                                                    /// description
                                                    CommonText(
                                                      title: item.projectDis,
                                                      maxLines: 4,
                                                      textStyle: TextStyle(
                                                        height: 1.5,
                                                        color: isDark
                                                            ? Colors.white70
                                                            : const Color(0xFF526071),
                                                        fontSize: maxWidth >= 1200 ? 13.5 : 12.5,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),

                                                    SizedBox(height: 18.h),

                                                    /// technologies
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Wrap(
                                                          spacing: 10,
                                                          runSpacing: 10,
                                                          children: item.technoloty.map((ele) {
                                                            return AnimatedContainer(
                                                              duration: const Duration(milliseconds: 250),
                                                              padding: EdgeInsets.symmetric(
                                                                horizontal: 14.w,
                                                                vertical: 8.h,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(30.r),
                                                                gradient: LinearGradient(
                                                                  colors: [
                                                                    accent.withValues(alpha: 0.18),
                                                                    accent.withValues(alpha: 0.08),
                                                                  ],
                                                                ),
                                                                border: Border.all(
                                                                  color: accent.withValues(alpha: 0.28),
                                                                ),
                                                              ),
                                                              child: CommonText(
                                                                title: ele,
                                                                textStyle: TextStyle(
                                                                  fontSize: chipText,
                                                                  color: accent,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: sectionGap),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
