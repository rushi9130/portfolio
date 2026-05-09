import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/helper/text_styles.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';


class CommonSnackBar {

  final BuildContext context;

  const CommonSnackBar({required this.context});

  void showSnackBar({required String message , bool? isSuccess = true}){

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior:SnackBarBehavior.floating,
            backgroundColor: (isSuccess??false) ? AppColors.success:AppColors.error,
            content: Row(
              children: [
                Expanded(child: CommonText(title: message,maxLines: 3,textStyle: TextStyles.medium.copyWith(
                  fontSize: 31.sp,
                  fontWeight: FontWeight.w600
                ))),
                GestureDetector(
                    onTap: (){
                      ScaffoldMessenger.of(context).clearSnackBars();
                    },
                    child: Icon(Icons.close,color: AppColors.white,)
                ),
              ],
            ),
        ),
    );

  }


}
