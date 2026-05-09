import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class TestimonialMobile extends ConsumerWidget {
  const TestimonialMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitle = isDark ? Colors.white70 : const Color(0xFF425466);
    final list = watch.testimonials;
    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
      children: [


        for (var i = 0; i < list.length; i++) ...[
          if (i > 0) const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${list[i].text}"',
                    style: TextStyle(color: subtitle, fontStyle: FontStyle.italic, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    list[i].role,
                    style: const TextStyle(color: Color(0xFFF5C542), fontWeight: FontWeight.w700),
                  ),
                  Text(list[i].company, style: TextStyle(color: subtitle)),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
