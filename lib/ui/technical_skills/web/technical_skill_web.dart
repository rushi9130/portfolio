
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
    return Container(
      height: context.height,
      width: context.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)],
        ),
      ),
      child: Stack(
        children: [

          /// background dots
          SizedBox(
            width: context.width,
            height: context.height,
            child: Opacity(opacity: 0.8, child: ParticleBackground()),
          ),

          Column(
            children: [
              SizedBox(height: 50.h),
              /// my skills Me Text
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 100.sp,
                    color: Colors.white,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(text: 'My '),

                    TextSpan(
                      text: 'Skills',
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ],
                ),
              ).alignAtCenter(),
              SizedBox(height: 100.h),

      GridView.custom(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30.w,
          mainAxisSpacing: 60.h,
          // childAspectRatio: context.height / 340,
          mainAxisExtent: 500.h
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
            return SkillCategoryCard(
              category: watch.skillCategories[index],
            );
          },
          childCount: watch.skillCategories.length,
        ),
      )
            ],
          )


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
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0F2235),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            category.title,
            style: TextStyle(
              color: const Color(0xFFF5C542),
              fontSize: 40.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20.h),
          Divider(color: Colors.white24, height: 24.h),
          SizedBox(height: 20.h),

          /// Multiple skills
          ...category.skills.map(
                (skill) => SkillBar(
              item: SkillItem(skill.name, skill.level),
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
            color: Colors.black.withOpacity(0.4),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.name,
                  style:  TextStyle(color: Colors.white70,fontSize: 30.sp),),
              Text('${(item.value * 100).toInt()}%',
                  style:  TextStyle(color: Colors.white70,fontSize: 30.sp)),
            ],
          ),
          SizedBox(height: 9.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: item.value,
              minHeight: 10.h,
              backgroundColor: const Color(0xFF1C344D),
              valueColor:
              const AlwaysStoppedAnimation(Color(0xFFBA994A)),
            ),
          ),
        ],
      ),
    );
  }
}
