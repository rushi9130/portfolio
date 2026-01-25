

import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/testimonial/mobile/testimonial_mobile.dart';
import 'package:personal_portfolio/ui/testimonial/web/testmonial_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Testimonial extends StatelessWidget {
  const Testimonial({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => TestimonialMobile(),
      desktop: (context) => TestimonialWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const TestimonialWeb()
                : const TestimonialMobile();
          },
        );
      },
    );
  }
}
