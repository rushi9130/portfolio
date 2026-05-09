import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/helper/text_styles.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_progress_bar.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_svg.dart';
import 'package:personal_portfolio/ui/utils/widgets/common_text.dart';

class CommonButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final String? leftImage;
  final double? leftImageHeight;
  final double? leftImageWidth;
  final double? leftImageHorizontalPadding;
  final Widget? rightIcon;
  final String? rightImage;
  final double? rightImageHeight;
  final double? rightImageWidth;
  final double? rightImageHorizontalPadding;
  final String? buttonText;
  final int? buttonMaxLine;
  final TextStyle? buttonTextStyle;
  final double? buttonHorizontalPadding;
  final bool isButtonEnabled;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onValidateTap;
  final TextAlign? buttonTextAlignment;
  final Color? buttonTextColor;
  final Color? buttonEnabledColor;
  final Color? buttonDisabledColor;
  final double? buttonTextSize;
  final bool? isLoading;
  final bool isShowLoader;
  final Color? loadingAnimationColor;
  final Widget? leftIcon;

  const CommonButton({
    super.key,
    this.height,
    this.width,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.leftImage,
    this.leftImageHeight,
    this.leftImageWidth,
    this.leftImageHorizontalPadding,
    this.rightImage,
    this.rightImageHeight,
    this.rightImageWidth,
    this.rightImageHorizontalPadding,
    this.buttonText,
    this.buttonMaxLine,
    this.buttonTextStyle,
    this.buttonHorizontalPadding,
    this.onTap,
    this.buttonTextAlignment,
    this.buttonTextColor,
    this.isButtonEnabled = false,
    this.buttonEnabledColor,
    this.buttonDisabledColor,
    this.buttonTextSize,
    this.rightIcon,
    this.isLoading,
    this.isShowLoader = true,
    this.loadingAnimationColor,
    this.onValidateTap,
    this.leftIcon,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> with BaseStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    Color buttonColor = widget.isButtonEnabled
        ? (widget.buttonEnabledColor ?? AppColors.buttonEnableColor)
        : (widget.buttonDisabledColor ?? AppColors.clrF7F7FC);
    return /*(widget.isLoading ?? false) ? shimmerLoader() : */ AbsorbPointer(
      absorbing: widget.isLoading ?? false,
      child: InkWell(
        onTap: () {
          if (widget.isButtonEnabled && !(widget.isLoading ?? false)) {
            widget.onTap?.call();
          } else if (!(widget.isLoading ?? false)) {
            widget.onValidateTap?.call();
          }
        },
        child: Container(
          height: widget.height ?? 82.h,
          width: widget.width ?? 233.w,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(40.r),
            border: Border.all(
              color: widget.borderColor ?? AppColors.transparent,
              width: widget.borderWidth ?? 0,
            ),
          ),
          padding: widget.isShowLoader && (widget.isLoading ?? false)
              ? EdgeInsets.all(3)
              : null,
          child: widget.isShowLoader && (widget.isLoading ?? false)
              ? CommonProgressBar(isLoading: true, forPagination: false)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if ((widget.leftImage ?? '').isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.leftImageHorizontalPadding ?? 12.w,
                        ),
                        child: (widget.leftImage?.contains('.svg') ?? false)
                            ? CommonSVG(
                                strIcon: widget.leftImage!,
                                height: widget.leftImageHeight,
                                width: widget.leftImageWidth,
                              )
                            : Image.asset(
                                widget.leftImage!,
                                height: widget.leftImageHeight,
                                width: widget.leftImageWidth,
                              ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.buttonHorizontalPadding ?? 0,
                      ),
                      child: Row(
                        children: [
                          if ((widget.leftIcon != null &&
                              widget.leftImage == null))
                            widget.leftIcon ?? const Offstage(),
                          CommonText(
                            title: widget.buttonText ?? '',
                            textAlign:
                                widget.buttonTextAlignment ?? TextAlign.center,
                            maxLines: widget.buttonMaxLine ?? 1,
                            textStyle:
                                widget.buttonTextStyle ??
                                TextStyles.regular.copyWith(
                                  fontSize: widget.buttonTextSize ?? 22.sp,
                                  color:
                                      widget.buttonTextColor ??
                                      (widget.isButtonEnabled
                                          ? AppColors.white
                                          : AppColors.buttonDisableColor),
                                ),
                          ),
                          // SizedBox(
                          //   width: 5.wp,
                          // ),
                          if ((widget.rightIcon != null &&
                              widget.rightImage == null))
                            widget.rightIcon ?? const Offstage(),
                        ],
                      ),
                    ),
                    if ((widget.rightImage ?? '').isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              widget.rightImageHorizontalPadding ?? 12.w,
                        ),
                        child: Image.asset(
                          widget.rightImage!,
                          height: widget.rightImageHeight,
                          width: widget.rightImageWidth,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
