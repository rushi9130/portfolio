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
        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 32,
                color: textColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
              children: [
                TextSpan(text: watch.aboutTitlePrefix),

                const TextSpan(
                  text: " Me",
                  style: TextStyle(
                    color: Color(0xFFF5C542),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.88),
                  height: 1.8,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
                children: [
                  TextSpan(text: watch.aboutIntro),

                  TextSpan(text: watch.aboutExpPrefix),

                  TextSpan(
                    text: watch.aboutCompanyOne,
                    style: const TextStyle(
                      color: Color(0xFFF5C542),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextSpan(text: watch.aboutJoin),

                  TextSpan(
                    text: watch.aboutCompanyTwo,
                    style: const TextStyle(
                      color: Color(0xFFF5C542),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  TextSpan(text: watch.aboutExpSuffix),

                  TextSpan(text: watch.aboutClosing),
                ],
              ),
            ),
          ),
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
