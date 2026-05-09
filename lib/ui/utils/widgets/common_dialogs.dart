import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/padding_extension.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';
import '../helper/text_styles.dart';
import 'common_button.dart';
import 'common_text.dart';



/// show error  when network error come
GlobalKey errorDialogKey = GlobalKey();

showCommonErrorDialog({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  Function()? onButtonTap,
  double? height,
  double? width,
}) {
  return showCommonErrorDialogMobile(context: context, message: message, onButtonTap: onButtonTap);
}

showCommonErrorDialogMobile({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  Function()? onButtonTap,
  double? height,
  double? width,
}){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context)
      {
        return Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return AlertDialog(
              key: errorDialogKey,
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              content: Builder(
                  builder: (BuildContext context){
                    return   SizedBox(
                      width: width??context.width * 0.17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                message,
                                style: textStyle ?? TextStyles.medium.copyWith(
                                    color: AppColors.black,
                                    fontSize: 25.sp),
                                maxLines: 3,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ).paddingOnly(bottom: 30.h),
                          CommonButton(
                            height: 80.h,
                            width: context.height * 0.19,
                            buttonTextStyle: TextStyle(
                              fontSize: 29.w
                            ),
                            buttonText:
                          "OK",
                            isButtonEnabled: true,
                            onTap: onButtonTap ?? () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }
              ),
            );
          },
        );
      },
  );
}



GlobalKey permissionDialogKey = GlobalKey();

commonPermissionDialog({
  required BuildContext context,
  String? title,
  String? description,
  double? width,
  required Function() onPositiveButtonTap
}){
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context)
    {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return AlertDialog(
            key: permissionDialogKey,
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            content: Builder(
                builder: (BuildContext context){
                  return   SizedBox(
                    width: width??context.width * 0.17,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        ///title
                        if(title!=null)
                          CommonText(
                            title: title,
                            textStyle: TextStyles.medium.copyWith(
                                color: AppColors.black,fontSize: 38.sp
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                          ).paddingOnly(bottom: 15.h,left: 40.w,right: 40.w),

                        ///Sub title
                        if(description!=null)
                          CommonText(
                            title:  description,
                            textStyle: TextStyles.regular.copyWith(
                                color: AppColors.black,fontSize: 30.sp),
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ).paddingOnly(left: 40.h,right: 40.w,bottom: 30.h),

                        ///Bottom Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CommonButton(
                                height: 70.h,
                                buttonText: "No",
                                buttonTextStyle: TextStyle(
                                    fontSize: 29.w
                                ),
                                isButtonEnabled: true,
                                onTap: () {
                                  print("Click");
                                  Navigator.pop(context);
                                },
                                buttonEnabledColor: AppColors.buttonEnableColor,
                                buttonTextColor: AppColors.black),
                            SizedBox(
                              width: 15.w,
                            ),
                            CommonButton(
                                height: 55.h,
                                buttonText: "Yes",
                                onTap: onPositiveButtonTap,
                                isButtonEnabled: true,
                                buttonTextStyle: TextStyle(
                                    fontSize: 29.w
                                ),
                                buttonEnabledColor: AppColors.buttonEnableColor,
                                buttonTextColor: AppColors.black),
                          ],
                        ).paddingSymmetric(horizontal: 15.w,vertical: 15.h)

                      ],
                    ),
                  );
                }
            ),
          );
        },
      );
    },
  );
}