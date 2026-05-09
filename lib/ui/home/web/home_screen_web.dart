import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/theme/assets.gen.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';

class HomeScreenWeb extends ConsumerStatefulWidget {
  const HomeScreenWeb({super.key});

  @override
  ConsumerState<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends ConsumerState<HomeScreenWeb>
    with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final bgGradient = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    final accent = const Color(0xFFF5C542);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: bgGradient),
        ),
        child: Center(
          child: Stack(
            children: [
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

              LayoutBuilder(
                builder: (context, constraints) {
                  final nameSize = constraints.maxWidth >= 1200 ? 40.0 : constraints.maxWidth >= 900 ? 34.0 : 28.0;
                  final roleSize = constraints.maxWidth >= 1200 ? 20.0 : constraints.maxWidth >= 900 ? 17.0 : 15.0;
                  final actionTextSize = constraints.maxWidth >= 1200 ? 14.0 : 12.5;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 32.h,
                    children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 96.w,
                    width: 96.w,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accent,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                    child: watch.homeImageUrl.isNotEmpty
                        ? Image.network(
                      watch.homeImageUrl,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      gaplessPlayback: true,
                      loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                          ) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      frameBuilder: (
                          context,
                          child,
                          frame,
                          wasSynchronouslyLoaded,
                          ) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        }

                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(milliseconds: 300),
                          child: child,
                        );
                      },
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
                        debugPrint(
                          "Home Image Error => $error",
                        );

                        return Assets.images.photo.image(
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Assets.images.photo.image(fit: BoxFit.cover),
                  ),

                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: nameSize,
                        color: textColor,
                        wordSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: '${watch.firstName} '),

                        TextSpan(
                          text: watch.lastName,
                          style: TextStyle(color: accent),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    watch.myExpertiseList[watch.expertiesIndex],
                    style: TextStyle(
                      fontSize: roleSize,
                      color: accent,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 95.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: watch.workAndConnect.length,
                      itemBuilder: (context, index) {
                        return MouseRegion(
                          onEnter: (v) {
                            watch.chnageMouseReginForAction(index);
                          },
                          onExit: (v) {
                            watch.chnageMouseReginForAction(-1);
                          },
                          child: GestureDetector(
                            onTap: () {
                              watch.changeWorkAction(index);
                            },
                            child: Container(
                              width: 110.w,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color:
                                    ((watch.currentMouseReginForAction ==
                                            index) ||
                                        (watch.slectWorkAction == index))
                                    ? accent.withValues(alpha: 0.7)
                                    : null,
                                borderRadius: BorderRadius.circular(80.r),
                                border: Border.all(
                                  color:
                                      ((watch.currentMouseReginForAction ==
                                              index) ||
                                          (watch.slectWorkAction == index))
                                      ? accent
                                      : textColor.withValues(alpha: 0.7),
                                  width: 1,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: CommonText(
                                title: watch.workAndConnect[index],
                                textStyle: TextStyle(
                                  fontSize: actionTextSize,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      ((watch.currentMouseReginForAction ==
                                              index) ||
                                          (watch.slectWorkAction == index))
                                      ? Colors.black
                                      : textColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                    ],
                  );
                },
              ).alignAtCenter(),
            ],
          ),
        ),
      ),
    );
  }
}
