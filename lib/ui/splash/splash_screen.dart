import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:personal_portfolio/ui/mainpage/main_page.dart';
import 'package:personal_portfolio/ui/splash/mobile/mobile_splash_screen.dart';
import 'package:personal_portfolio/ui/splash/web/splash_web_screen.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BaseStatefulWidget {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timer) {
      Future.delayed(Duration(seconds: 3), () {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      });
    });
  }

  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => const MobileSplashScreen(),
      desktop: (context) => SplashWebScreen(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const SplashWebScreen()
                : const MobileSplashScreen();
          },
        );
      },
    );
  }
}
