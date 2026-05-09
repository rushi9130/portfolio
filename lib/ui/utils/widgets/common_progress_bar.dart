import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/utils/theme/app_color.dart';

class CommonProgressBar extends StatelessWidget {
  final bool isLoading;
  final bool forPagination;

  const CommonProgressBar({
    super.key,
    required this.isLoading,
    this.forPagination = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!(isLoading)) {
      return const Offstage();
    } else {
      if ((forPagination)) {
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.black),
          ),
        );
      } else {
        return AbsorbPointer(
          absorbing: true,
          child: Container(
            color: AppColors.transparent,
            // width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(color: AppColors.black),
                ),
              ),
            ),
          ),
        );
      }
    }
  }
}
