import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/ui/utils/mobile_ui_tokens.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class TechnicalSkillsMobile extends ConsumerWidget {
  const TechnicalSkillsMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final body = MobileUiTokens.bodyText(isDark);
    final sub = MobileUiTokens.subtitle(isDark);
    final categories = watch.skillCategories;
    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      children: [

        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 26,
              color: watch.isDarkOn ? Colors.white : const Color(0xFF102A43),
              wordSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
            children: const [
              TextSpan(text: 'My '),
              TextSpan(text: 'Skills', style: TextStyle(color: Color(0xFFF5C542))),
            ],
          ),
        ).alignAtCenter(),
        SizedBox(height: 40.h),

        for (var i = 0; i < categories.length; i++) ...[
          if (i > 0) SizedBox(height: 18.h),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                  const Color(0xFF132F4C),
                  const Color(0xFF0F2235),
                ]
                    : [
                  Colors.white,
                  const Color(0xFFF4F8FC),
                ],
              ),

              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : const Color(0xFFD9E2EC),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isDark ? 0.30 : 0.08,
                  ),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),

                BoxShadow(
                  color: const Color(0xFFF5C542).withValues(alpha: 0.08),
                  blurRadius: 25,
                  spreadRadius: 1,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Header
                Row(
                  children: [

                    Container(
                      height: 46,
                      width: 46,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF5C542).withValues(alpha: 0.12),

                        border: Border.all(
                          color: const Color(0xFFF5C542).withValues(alpha: 0.35),
                        ),
                      ),

                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: Color(0xFFF5C542),
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Text(
                        categories[i].title,
                        style: const TextStyle(
                          color: Color(0xFFF5C542),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 22.h),

                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        const Color(0xFFF5C542).withValues(alpha: 0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 22.h),

                /// Skills
                ...categories[i].skills.map(
                      (s) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: Text(
                                s.name,
                                style: TextStyle(
                                  color: body,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Text(
                              '${(s.level * 100).toInt()}%',
                              style: TextStyle(
                                color: sub,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        /// Premium Progress Bar
                        Container(
                          height: 5,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: isDark
                                ? const Color(0xFF1C344D)
                                : const Color(0xFFD6DFEA),
                          ),

                          child: Stack(
                            children: [

                              FractionallySizedBox(
                                widthFactor: s.level,

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),

                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFF5C542),
                                        Color(0xFFD6A419),
                                      ],
                                    ),

                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFF5C542),
                                        blurRadius: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
