

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_svg.dart';

class IconWidget extends StatelessWidget {
  final String icon;
  final Function() onTap;
  final Alignment? alignment;
  final double? height;
  final double? width;
  const IconWidget({super.key,required this.icon, required this.onTap, this.alignment,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: alignment ?? Alignment.centerRight,
        child: InkWell(
            onTap: onTap,
            child: CommonSVG(strIcon: icon,height: height??24.h,width: width??24.w,)));
  }
}
