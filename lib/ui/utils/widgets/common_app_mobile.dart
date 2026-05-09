import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/helper/text_styles.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';

class CommonAppbarMobile extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const CommonAppbarMobile({
    super.key,
    this.title,
    this.centerTitle = true,
    this.isLeadingRequired = false,
    this.onLeadingTap,
    this.centerWidget,
    this.backgroundColor,
  });

  final String? title;
  final bool centerTitle;
  final bool isLeadingRequired;
  final GestureTapCallback? onLeadingTap;
  final Widget? centerWidget;
  final Color? backgroundColor;

  @override
  ConsumerState createState() => _CommonAppbarMobileState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

/// Don't forget to if you want to show transparent appbar add extendBodyBehindAppBar: true, in scaffold
class _CommonAppbarMobileState extends ConsumerState<CommonAppbarMobile> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? AppColors.transparent,
      centerTitle: widget.centerTitle,
      leading: widget.isLeadingRequired
          ? InkWell(
              onTap: () {
                // if (widget.onLeadingTap != null) {
                //   widget.onLeadingTap?.call();
                // } else {
                //   ref.read(navigationStackController).pop();
                // }
              },
              child: Icon(Icons.arrow_back_ios),
            )
          : const Offstage(),
      title:
          widget.centerWidget ??
          CommonText(
            title: widget.title ?? '',
            textAlign: TextAlign.center,
            textStyle: TextStyles.semiBold.copyWith(
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
    );
  }
}
