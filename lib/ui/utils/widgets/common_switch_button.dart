import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';

class CommonCupertinoSwitch extends StatelessWidget with BaseStatelessWidget {
  const CommonCupertinoSwitch({super.key, required this.switchValue,required this.onChanged,this.width,this.height,this.opacity,this.absorbing });

  /// Switch Value
  final bool switchValue;
  /// On changed switch value
  final ValueChanged<bool> onChanged;
  final double? height;
  final double? width;
  final double? opacity;
  final bool? absorbing;

  @override
  Widget buildPage(BuildContext context){
    return AbsorbPointer(
      absorbing: absorbing??false,
      child: Opacity(
        opacity:opacity??1,
        child: SizedBox(
          height: height??22.h,
          width: width,
          child: FittedBox(
            fit: BoxFit.contain,
            child: CupertinoSwitch(
              value: switchValue,
              activeColor: AppColors.green35C658,
              trackColor: AppColors.black333333,
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
