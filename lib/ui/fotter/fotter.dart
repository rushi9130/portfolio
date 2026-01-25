
import 'package:flutter/material.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

import '../../freamwork/utils/extension/context_extension.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      alignment: Alignment.center,
      height: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)],
        ),
      ),
      child: Stack(
        children: [

          SizedBox(
            width: context.width,
            height: 170,
            child: Opacity(opacity: 0.8, child: ParticleBackground()),
          ),

          Column(
            children: [

              SizedBox(
                height: context.height*0.1,
              ),

              Text(
                '© 2026 Rushikesh Ghegade. All rights reserved.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ).alignAtCenter(),
              SizedBox(height: 8),
              Text(
                'Designed & Built with Flutter',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                ),
              ).alignAtCenter(),
            ],
          )
        ],
      ),
    );
  }
}
