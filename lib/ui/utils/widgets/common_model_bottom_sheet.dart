import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';

void showCommonModalBottomSheet({
  required BuildContext context,
  EdgeInsetsGeometry? bottomSheetPadding,
  Widget? child,
  bool? isScrollControlled,
  Function()? onTap,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: isScrollControlled ?? true,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 0.6,
        child: StatefulBuilder(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: AppColors.transparent,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.h),
                              topRight: Radius.circular(20.w),
                            ),
                          ),
                          child: child ?? const Offstage(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
