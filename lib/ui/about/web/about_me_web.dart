import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/padding_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

class AboutMeWeb extends ConsumerStatefulWidget {
  const AboutMeWeb({super.key});

  @override
  ConsumerState<AboutMeWeb> createState() => _AboutMeWebState();
}

class _AboutMeWebState extends ConsumerState<AboutMeWeb>
    with BaseStatefulWidget {
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
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: bgGradient),
      ),
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
              final titleSize = constraints.maxWidth >= 1200 ? 40.0 : constraints.maxWidth >= 900 ? 34.0 : 28.0;
              final paragraphSize = constraints.maxWidth >= 1200 ? 16.0 : constraints.maxWidth >= 900 ? 14.0 : 13.0;
              final badgeCountSize = constraints.maxWidth >= 1200 ? 24.0 : 20.0;
              final badgeLabelSize = constraints.maxWidth >= 1200 ? 13.0 : 12.0;
              return Column(
                spacing: 10,
                children: [
              /// about Me Text
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: titleSize,
                    color: textColor,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(text: watch.aboutTitlePrefix),

                    TextSpan(
                      text: watch.aboutTitleAccent,
                      style: TextStyle(color: accent),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              /// About Information
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: paragraphSize,
                        color: textColor,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: watch.aboutIntro,
                        ),
                        TextSpan(
                          text: watch.aboutExpPrefix,
                        ),
                        TextSpan(
                          text: watch.aboutCompanyOne,
                          style: TextStyle(
                            color: Color(0xFFD59D1D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(text: watch.aboutJoin),
                        TextSpan(
                          text: watch.aboutCompanyTwo,
                          style: TextStyle(
                            color: Color(0xFFD59D1D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: watch.aboutExpSuffix,
                        ),
                        TextSpan(
                          text: watch.aboutClosing,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              /// Container for show Info
              SizedBox(
                height: 250,
                width: context.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: watch.aboutMeList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 110.w,
                                width: 110.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: accent,
                                    width: 7.sp,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  watch.aboutMeList[index].count.toString(),
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: badgeCountSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 24),

                              Text(
                                watch.aboutMeList[index].techStack,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: badgeLabelSize,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Spacer(),
                ],
              );
            },
          ).paddingAll(20),
        ],
      ),
    );
  }
}
