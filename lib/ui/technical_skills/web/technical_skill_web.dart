
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

import '../../../freamwork/repository/home/model/technical_models.dart';

class TechnicalSkillWeb extends ConsumerStatefulWidget {
  const TechnicalSkillWeb({super.key});

  @override
  ConsumerState<TechnicalSkillWeb> createState() => _TechnicalSkillWebState();
}

class _TechnicalSkillWebState extends ConsumerState<TechnicalSkillWeb> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final bgGradient = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(gradient: LinearGradient(colors: bgGradient)),
      child: Stack(
        children: [

          /// background dots
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
              final cardMaxWidth = constraints.maxWidth >= 1400 ? 420.0 : constraints.maxWidth >= 1000 ? 360.0 : 320.0;
              final mainExtent = (constraints.maxHeight * 0.36).clamp(250.0, 420.0);
              return Column(
                children: [
                  SizedBox(height: 50.h),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: titleSize,
                        color: textColor,
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
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: cardMaxWidth,
                        crossAxisSpacing: 22.w,
                        mainAxisSpacing: 60.h,
                        mainAxisExtent: mainExtent,
                      ),
                      itemCount: watch.skillCategories.length,
                      itemBuilder: (context, index) {
                        return SkillCategoryCard(category: watch.skillCategories[index]);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


class SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;

  const SkillCategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;

    final titleSize = width >= 1200 ? 20.0 : 17.0;

    final bgColor = isDark
        ? const Color(0xFF10253B)
        : Colors.white;

    final borderColor = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : const Color(0xFFD9E2EC);

    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.45)
        : Colors.black.withValues(alpha: 0.08);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,

      padding: EdgeInsets.all(22.r),

      decoration: BoxDecoration(
        color: bgColor,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: borderColor,
          width: 1,
        ),

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

        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),

          BoxShadow(
            color: const Color(0xFFF5C542).withValues(alpha: 0.08),
            blurRadius: 30,
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
                height: 48,
                width: 48,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF5C542).withValues(alpha: 0.12),
                  border: Border.all(
                    color: const Color(0xFFF5C542).withValues(alpha: 0.4),
                  ),
                ),

                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: Color(0xFFF5C542),
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    color: const Color(0xFFF5C542),
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),

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

          SizedBox(height: 24.h),

          /// Skills
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: category.skills.map(
                      (skill) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: SkillBar(
                        item: SkillItem(
                          skill.name,
                          skill.level,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final String title;
  final List<SkillItem> skills;

  const SkillCard({super.key, required this.title, required this.skills});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2235),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFFF5C542),
              fontSize: 38.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(color: Colors.white24, height: 24.h),
          SizedBox(
            height: 20.h,
          ),
          ...skills.map((s) => SkillBar(item: s)),
        ],
      ),
    );
  }
}

class SkillItem {
  final String name;
  final double value;
  const SkillItem(this.name, this.value);
}

class SkillBar extends StatelessWidget {
  final SkillItem item;
  const SkillBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : const Color(0xFF425466);
    final width = MediaQuery.sizeOf(context).width;
    final textSize = width >= 1200 ? 14.0 : 12.0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name,
                  style: TextStyle(color: textColor, fontSize: textSize),),
              Text('${(item.value * 100).toInt()}%',
                  style: TextStyle(color: textColor, fontSize: textSize)),
            ],
          ),
          SizedBox(height: 9.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 10.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark
                    ? const Color(0xFF1C344D)
                    : const Color(0xFFD6DFEA),
              ),

              child: Stack(
                children: [

                  FractionallySizedBox(
                    widthFactor: item.value,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF5C542),
                            Color(0xFFD6A419),
                          ],
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF5C542),
                            blurRadius: 8,
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
      ),
    );
  }
}
