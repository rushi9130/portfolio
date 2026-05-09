import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/contact/mobile/contact_mobile.dart';
import 'package:personal_portfolio/ui/contact/web/contact_web.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Contact extends StatelessWidget with BaseStatelessWidget {
  const Contact({super.key});

  @override
  Widget buildPage(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => const ContactMobile(),
      desktop: (context) => ContactWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const ContactWeb()
                : const ContactMobile();
          },
        );
      },
    );
  }
}
