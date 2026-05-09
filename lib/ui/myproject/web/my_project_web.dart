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
                                      "No ${watch.currentSelectProjectIndex == 1 ? "Mobile" : "Web"} Projects Avilable",
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
                                        duration: const Duration(milliseconds: 250),
                                        curve: Curves.bounceInOut,
                                        transform: Matrix4.translationValues(
                                          0,
                                          isHover ? -12 : 0,
                                          0,
                                        ),
                                        width: cardWidth,
                                        height: cardHeight,
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? const Color(0xFF0E2239)
                                              : const Color(0xFFE6EEF8),
                                          borderRadius: BorderRadius.circular(30.r),
                                          border: Border.all(
                                            color: textColor.withValues(alpha: 0.3),
                                            width: 0.1,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: cardHeight * 0.32,
                                              child: Center(
                                                child: isHover
                                                    ? Container(
                                                  height: (cardHeight * 0.16).clamp(70.0, 120.0),
                                                  width: (cardWidth * 0.72).clamp(150.0, 260.0),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: accent),
                                                    borderRadius: BorderRadius.circular(60.r),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: CommonText(
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    title: "View Project",
                                                    textStyle: TextStyle(
                                                      color: accent,
                                                      fontSize: maxWidth >= 1200 ? 18 : 15,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                                    : CommonText(
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  title: item.projectName,
                                                  textStyle: TextStyle(
                                                    color: accent,
                                                    fontSize: maxWidth >= 1200 ? 18 : 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ).paddingAll(10),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                width: cardWidth,
                                                decoration: BoxDecoration(
                                                  color: isDark
                                                      ? const Color(0xFF0A1628)
                                                      : Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    bottomLeft: Radius.circular(30.r),
                                                    bottomRight: Radius.circular(30.r),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 10.w,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    CommonText(
                                                      maxLines: 2,
                                                      title: item.projectName,
                                                      textStyle: TextStyle(
                                                        color: textColor,
                                                        fontSize: maxWidth >= 1200 ? 16 : 14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    CommonText(
                                                      title: item.projectDis,
                                                      maxLines: 3,
                                                      textStyle: TextStyle(
                                                        color: isDark
                                                            ? Colors.grey
                                                            : const Color(0xFF5F6C7B),
                                                        fontSize: maxWidth >= 1200 ? 14 : 12.5,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(height: 12.h),
                                                    Expanded(
                                                      child: SingleChildScrollView(
                                                        child: Wrap(
                                                          spacing: 10,
                                                          runSpacing: 10,
                                                          children: item.technoloty.map((ele) {
                                                            return Container(
                                                              padding: EdgeInsets.symmetric(
                                                                vertical: 8.h,
                                                                horizontal: 10.w,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(20.r),
                                                                color: accent.withValues(alpha: 0.22),
                                                              ),
                                                              child: CommonText(
                                                                title: ele,
                                                                textStyle: TextStyle(
                                                                  fontSize: chipText,
                                                                  color: accent,
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
