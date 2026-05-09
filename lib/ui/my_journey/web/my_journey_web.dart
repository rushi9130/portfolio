import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

import '../../../freamwork/utils/extension/context_extension.dart';

class MyJourneyWeb extends ConsumerStatefulWidget {
  const MyJourneyWeb({super.key});

  @override
  ConsumerState<MyJourneyWeb> createState() => _MyJourneyWebState();
}

class _MyJourneyWebState extends ConsumerState<MyJourneyWeb>
    with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final bgGradient = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(gradient: LinearGradient(colors: bgGradient)),

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
              final isCompact = constraints.maxWidth < 1000;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: titleSize,
                          color: textColor,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(text: 'My ', style: TextStyle(color: textColor)),
                          const TextSpan(text: 'Journey', style: TextStyle(color: Color(0xFFF5C542))),
                        ],
                      ),
                    ).alignAtTopCenter(),
                    SizedBox(height: 24.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(watch.journeyEntries.length, (index) {
                            final entry = watch.journeyEntries[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: index == watch.journeyEntries.length - 1 ? 0 : 22.h),
                              child: _timelineEntry(
                                isCompact: isCompact,
                                alignLeft: index.isEven,
                                isDark: isDark,
                                title: entry.title,
                                company: entry.company,
                                duration: entry.duration,
                                points: entry.points,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Widget _timelineEntry({
    required bool isCompact,
    required bool alignLeft,
    required bool isDark,
    required String title,
    required String company,
    required String duration,
    required List<String> points,
  }) {
    if (isCompact) {
      return _timelineCard(title, company, duration, points, isDark: isDark, maxWidth: 780);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: alignLeft
              ? _timelineCard(title, company, duration, points, isDark: isDark, maxWidth: 700)
              : const SizedBox.shrink(),
        ),
        const SizedBox(width: 16),
        Column(
          children: const [
            Icon(Icons.circle_outlined, color: Color(0xFFF5C542)),
            SizedBox(height: 12),
            SizedBox(width: 2, height: 220, child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFFF5C542)))),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: alignLeft
              ? const SizedBox.shrink()
              : _timelineCard(title, company, duration, points, isDark: isDark, maxWidth: 700),
        ),
      ],
    );
  }

  static Widget _timelineCard(
    String title,
    String company,
    String duration,
    List<String> points,
      {required bool isDark, required double maxWidth}
  ) {
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF425466);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F2235) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(duration, style: const TextStyle(color: Color(0xFFF5C542), fontSize: 12.5)),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: textColor, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: subtitleColor,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          ...points.map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('▸ ', style: TextStyle(color: Color(0xFFF5C542))),
                  Expanded(
                    child: Text(
                      e,
                      style: TextStyle(color: subtitleColor, fontSize: 12.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
