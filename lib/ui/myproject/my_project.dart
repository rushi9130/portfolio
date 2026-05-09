import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/myproject/mobile/my_project_mobile.dart';
import 'package:personal_portfolio/ui/myproject/web/my_project_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => MyProjectWeb(),
      desktop: (context) => MyProjectWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const MyProjectWeb()
                : const MyProjectWeb();
          },
        );
      },
    );
  }
}
