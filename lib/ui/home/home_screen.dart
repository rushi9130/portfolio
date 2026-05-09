import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/home/mobile/home_screen_mobile.dart';
import 'package:personal_portfolio/ui/home/web/home_screen_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => const HomeScreenMobile(),
      desktop: (context) => HomeScreenWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const HomeScreenWeb()
                : const HomeScreenMobile();
          },
        );
      },
    );
  }
}
