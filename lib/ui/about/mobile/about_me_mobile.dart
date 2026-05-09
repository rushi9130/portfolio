import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class AboutMeMobile extends ConsumerWidget {
  const AboutMeMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 30, color: textColor, fontWeight: FontWeight.w700),
            children: [
              TextSpan(text: watch.aboutTitlePrefix),
              TextSpan(text: watch.aboutTitleAccent, style: const TextStyle(color: Color(0xFFF5C542))),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          '${watch.aboutIntro}${watch.aboutExpPrefix}${watch.aboutCompanyOne}${watch.aboutJoin}${watch.aboutCompanyTwo}${watch.aboutExpSuffix}${watch.aboutClosing}',
          style: TextStyle(color: textColor.withValues(alpha: 0.85), height: 1.55, fontSize: 14),
        ),
        const SizedBox(height: 18),
        ...watch.aboutMeList.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFF5C542).withValues(alpha: 0.22),
                  child: Text('${e.count}', style: const TextStyle(color: Color(0xFFF5C542))),
                ),
                title: Text(e.techStack),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
