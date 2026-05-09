import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/my_journey/mobile/my_jouney_mobile.dart';
import 'package:personal_portfolio/ui/my_journey/web/my_journey_web.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyJourney extends StatelessWidget with BaseStatelessWidget {
  const MyJourney({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => const MyJouneyMobile(),
      desktop: (context) => MyJourneyWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const MyJourneyWeb()
                : const MyJouneyMobile();
          },
        );
      },
    );
  }
}
