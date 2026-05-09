import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/theme/assets.gen.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

class SplashWebScreen extends StatefulWidget {
  const SplashWebScreen({super.key});

  @override
  State<SplashWebScreen> createState() => _SplashWebScreenState();
}

class _SplashWebScreenState extends State<SplashWebScreen>
    with BaseStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              width: context.width,
              height: context.height,
              child: Opacity(opacity: 0.5, child: ParticleBackground()),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 70.h,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 150.w,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    // border: Border.all(color: Colors.yellow),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        spreadRadius: 0.8,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,

                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.2),
                      ],
                    ),
                  ),
                  // alignment: Alignment.center,
                  /*
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 160.sp,
                        color: Colors.white,
                        wordSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(text: 'R'),

                        TextSpan(
                          text: 'G',
                          style: TextStyle(color: Colors.yellow),
                        ),
                      ],
                    ),
                  ),
                  */
                  child: Assets.images.photo.image(fit: BoxFit.cover),
                ),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 100.sp,
                      color: Colors.white,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: 'Rushikesh '),

                      TextSpan(
                        text: 'Ghegade',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 50.sp,
                      color: Colors.white,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Mobile ',
                        style: TextStyle(color: Colors.yellow),
                      ),

                      TextSpan(
                        text: 'App ',
                        style: TextStyle(color: Colors.yellow),
                      ),

                      TextSpan(
                        text: 'Developer',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              ],
            ).alignAtCenter(),
          ],
        ),
      ),
    );
  }

}
