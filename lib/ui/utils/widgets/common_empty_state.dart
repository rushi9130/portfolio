import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import '../helper/base_widget.dart';
import '../helper/text_styles.dart';
import '../theme/app_color.dart';
import 'common_svg.dart';
import 'common_text.dart';

class EmptyStateWidget extends StatelessWidget with BaseStatelessWidget {
  final String? icon;
  final String? title;
  final String? description;
  final double? svgHeight;
  final double? svgWidth;

  const EmptyStateWidget({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.svgHeight,
    this.svgWidth,
  });

  @override
  Widget buildPage(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10.h,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            SizedBox(
              height: svgHeight ?? context.height * 0.3,
              width: svgWidth ?? context.height * 0.3,
              child: CommonSVG(
                strIcon: icon ?? "",
              ),
            ),

          if (title != null)
            CommonText(
              title: title ?? "",
              maxLines: 2,
              textStyle: TextStyles.medium.copyWith(
                fontSize: 36.sp,
                color: AppColors.black,
              ),
            ),

          if (description != null)
            CommonText(
              title: description ?? '',
              maxLines: 2,
              textStyle: TextStyles.medium.copyWith(
                fontSize: 32.sp,
                color: AppColors.black,
              ),
            ),
        ],
      ),
    );
  }
}
