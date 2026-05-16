import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class MyJouneyMobile extends ConsumerStatefulWidget {
  const MyJouneyMobile({super.key});

  @override
  ConsumerState<MyJouneyMobile> createState() => _MyJouneyMobileState();
}

class _MyJouneyMobileState extends ConsumerState<MyJouneyMobile> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final subtitle = isDark ? Colors.white70 : const Color(0xFF425466);
    final titleColor = isDark ? Colors.white : const Color(0xFF102A43);
    final entries = watch.journeyEntries;
    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      children: [

        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 26,
              color:  watch.isDarkOn ? Colors.white : const Color(0xFF102A43),
              wordSpacing: 2,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(text: 'My ', style: TextStyle(color:  watch.isDarkOn ? Colors.white : const Color(0xFF102A43))),
              const TextSpan(text: 'Journey', style: TextStyle(color: Color(0xFFF5C542))),
            ],
          ),
        ).alignAtTopCenter(),
        SizedBox(height: 40.h),

        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          /// Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF0F2235)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: isDark ? 0.35 : 0.08,
                  ),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  entries[i].duration,
                  style: const TextStyle(
                    color: Color(0xFFF5C542),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  entries[i].title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  entries[i].company,
                  style: TextStyle(
                    color: subtitle,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 14),

                ...entries[i].points.map(
                      (p) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '▸',
                            style: TextStyle(
                              color: Color(0xFFF5C542),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            p,
                            style: TextStyle(
                              color: subtitle,
                              height: 1.5,
                              fontSize: 13,
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
        ],
      ],
    );
  }
}
