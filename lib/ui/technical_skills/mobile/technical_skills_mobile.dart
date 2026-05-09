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
          if (i > 0) const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories[i].title,
                    style: const TextStyle(
                      color: Color(0xFFF5C542),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...categories[i].skills.map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(s.name, style: TextStyle(color: body, fontSize: 14)),
                              Text('${(s.level * 100).toInt()}%', style: TextStyle(color: sub, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: s.level,
                              minHeight: 8,
                              backgroundColor:
                                  isDark ? MobileUiTokens.progressTrackDark : MobileUiTokens.progressTrackLight,
                              valueColor: const AlwaysStoppedAnimation<Color>(MobileUiTokens.progressValue),
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
        ],
      ],
    );
  }
}
