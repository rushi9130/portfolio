import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/theme/assets.gen.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

/// Mobile splash: same visual language as web (gradient, particles, photo) without web-only sizing.
class MobileSplashScreen extends StatelessWidget {
  const MobileSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors: bg)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: isDark ? 0.75 : 0.4,
                child: ParticleBackground(
                  particleColor: isDark ? Colors.orange : const Color(0xFF8FA7BF),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: 120.r,
                    width: 120.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.white24 : const Color(0xFF102A43).withValues(alpha: 0.15),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Assets.images.photo.image(fit: BoxFit.cover),
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    'Rushikesh Ghegade',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF102A43),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Portfolio',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF5C542),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: const Color(0xFFF5C542),
                      backgroundColor: isDark ? Colors.white12 : Colors.black12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
