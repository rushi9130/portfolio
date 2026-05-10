import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/ui/myproject/helper/show_project_view_dialog.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

class MyProjectMobile extends ConsumerStatefulWidget {

  const MyProjectMobile({super.key});

  @override
  ConsumerState<MyProjectMobile> createState() {
    return _myProjectMobileState();
  }

}

class _myProjectMobileState extends ConsumerState<MyProjectMobile> with BaseConsumerStatefulWidget {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timer) {
      final read = ref.read(homeController);
      read.addFilter();
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    final watch = ref.watch(homeController);

    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 24),
      children: [

        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 26,
                color: watch.isDarkOn ? Colors.white : const Color(0xFF102A43),
                wordSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
              children: const [
                TextSpan(text: 'My '),
                TextSpan(text: 'Projects', style: TextStyle(color: Color(0xFFF5C542))),
              ],
            ),
          ),
        ),
        SizedBox(height: 40.h),

        SizedBox(
          height: 42,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              children: List.generate(
                watch.myProject.length,
                (index) {
                  final selected = watch.currentSelectProjectIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(right: index < watch.myProject.length - 1 ? 8 : 0),
                    child: ChoiceChip(
                      selected: selected,
                      onSelected: (_) => watch.chnageCurrentSelectProjectIndex(index),
                      label: Text(watch.myProject[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...watch.filterProjects.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                title: Text(item.projectName),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(item.projectDis, maxLines: 3, overflow: TextOverflow.ellipsis),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                onTap: () => showProjectDialog(context, item),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
