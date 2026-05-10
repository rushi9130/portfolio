import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/ui/utils/theme/assets.gen.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class HomeScreenMobile extends ConsumerWidget {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final accent = const Color(0xFFF5C542);
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
      children: [
        Center(
          child: Container(
            width: 300.h,
            height: 300.h,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 1),
            ),
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 5,
              child: watch.homeImageUrl.isNotEmpty
                  ? Image.network(
                watch.homeImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) {
                  return Assets.images.photo.image(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
              )
                  : Assets.images.photo.image(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          '${watch.firstName} ${watch.lastName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: textColor),
        ),
        const SizedBox(height: 10),
        Text(
          watch.myExpertiseList[watch.expertiesIndex],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: accent),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: List.generate(
            watch.workAndConnect.length,
            (index) => FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.black,
              ),
              onPressed: () => watch.changeWorkAction(index),
              child: Text(watch.workAndConnect[index]),
            ),
          ),
        ),
      ],
    );
  }
}
