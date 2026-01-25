
import 'package:flutter/material.dart';
import 'package:personal_portfolio/ui/technical_skills/mobile/technical_skills_mobile.dart';
import 'package:personal_portfolio/ui/technical_skills/web/technical_skill_web.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TechnicalSkills extends StatelessWidget {
  const TechnicalSkills({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => TechnicalSkillsMobile(),
      desktop: (context) => TechnicalSkillWeb(),
      tablet: (context) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return orientation == Orientation.landscape
                ? const TechnicalSkillWeb()
                : const TechnicalSkillsMobile();
          },
        );
      },
    );
  }
}
