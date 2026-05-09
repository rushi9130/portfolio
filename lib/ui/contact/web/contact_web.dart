
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/utils/extension/align_extension.dart';
import 'package:personal_portfolio/freamwork/utils/extension/context_extension.dart';
import 'package:personal_portfolio/ui/utils/helper/base_widget.dart';
import 'package:personal_portfolio/ui/utils/widgets/background_animation.dart';

class ContactWeb extends ConsumerStatefulWidget {
  const ContactWeb({super.key});

  @override
  ConsumerState<ContactWeb> createState() => _ContactWebState();
}

class _ContactWebState extends ConsumerState<ContactWeb> with BaseConsumerStatefulWidget {
  @override
  Widget buildPage(BuildContext context) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final bgGradient = isDark
        ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
        : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);

    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(gradient: LinearGradient(colors: bgGradient)),
      child: Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
            child: Opacity(
              opacity: isDark ? 0.8 : 0.45,
              child: ParticleBackground(
                particleColor: isDark ? Colors.orange : const Color(0xFF8FA7BF),
              ),
            ),
          ),


          LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 1100;
              final titleSize = constraints.maxWidth >= 1200 ? 40.0 : constraints.maxWidth >= 900 ? 34.0 : 28.0;
              final footerSize = constraints.maxWidth >= 1200 ? 14.0 : 12.0;
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight * 0.01,
                  horizontal: constraints.maxWidth * 0.02,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: titleSize,
                          color: textColor,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w600,
                        ),
                        children: const [
                          TextSpan(text: 'Get In'),
                          TextSpan(text: ' Touch', style: TextStyle(color: Color(0xFFF5C542))),
                        ],
                      ),
                    ).alignAtCenter(),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: isCompact
                            ? Column(
                                children: [
                                  _buildInfoSection(context, watch, isCompact),
                                  SizedBox(height: 20.h),
                                  _buildForm(context, watch, constraints.maxWidth),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: _buildInfoSection(context, watch, isCompact)),
                                  SizedBox(width: 24.w),
                                  Expanded(child: _buildForm(context, watch, constraints.maxWidth)),
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '© 2026 Rushikesh Ghegade. All rights reserved.',
                      style: TextStyle(color: textColor.withValues(alpha: 0.8), fontSize: footerSize, letterSpacing: 0.5),
                    ).alignAtCenter(),
                    SizedBox(height: 8.h),
                    Text(
                      'Designed & Built with Flutter',
                      style: TextStyle(color: textColor.withValues(alpha: 0.65), fontSize: footerSize - 1),
                    ).alignAtCenter(),
                    SizedBox(height: 8.h),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, HomeController watch, bool isCompact) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: isCompact ? 16 : context.width * 0.018,
          runSpacing: 16,
          children: [
            _InfoCard(
              icon: Icons.phone,
              title: "Phone",
              value: '+91-${watch.phoneNumber}',
              index: 0,
              highlight: watch.clickContactContainerMouse == 0,
              compact: isCompact,
            ),
            _InfoCard(
              index: 1,
              icon: Icons.email,
              title: "Email",
              value: watch.email,
              highlight: watch.clickContactContainerMouse == 1,
              compact: isCompact,
            ),
            _InfoCard(
              index: 2,
              icon: Icons.business_center,
              title: "LinkedIn",
              value: "Connect on LinkedIn",
              highlight: watch.clickContactContainerMouse == 2,
              compact: isCompact,
            ),
            _InfoCard(
              index: 3,
              icon: Icons.code,
              title: "GitHub",
              value: "View My Code",
              highlight: watch.clickContactContainerMouse == 3,
              compact: isCompact,
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          "📍 ${watch.myLocation}",
          style: TextStyle(
            fontSize: isCompact ? 13 : 15,
            fontWeight: FontWeight.bold,
            color: watch.isDarkOn ? Colors.white : const Color(0xFF102A43),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, HomeController watch, double maxWidth) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: watch.isDarkOn ? const Color(0xFF0E2233) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _input(watch.nameController, "Name"),
          _input(watch.emailController, "Email"),
          _input(watch.subjectController, "Subject"),
          _input(watch.messageController, "Message", maxLines: 4),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19.r)),
              ),
              onPressed: watch.isSending ? null : () => watch.sendMessage(context),
              child: watch.isSending
                  ? const CircularProgressIndicator(color: Colors.black)
                  : Text(
                      "SEND MESSAGE",
                      style: TextStyle(fontSize: maxWidth >= 1200 ? 14 : 12.5, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _input(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0xFF102A43),
        ),
        cursorColor: const Color(0xFFD4AF37),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF102A43))
                .withValues(alpha: 0.6),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white24
                  : const Color(0xFFB6C2CF),
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD4AF37)),
          ),
        ),
      ),
    );
  }
}


class _InfoCard extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool highlight;
  final int index;
  final bool compact;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.index,
    required this.compact,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);

    return MouseRegion(
      onEnter: (e){
        watch.changeClickContactMouseContainer(index);
      },
      onExit: (e){
        watch.changeClickContactMouseContainer(-1);
      },
      child: GestureDetector(
        onTap: (){
          watch.changeClickContactContainer(index);
        },
        child: Container(
          // margin: EdgeInsets.only(left: context.width*0.02),
          padding: EdgeInsets.all(5.r),
          width: compact ? 250 : 280,
          constraints: BoxConstraints(minHeight: compact ? 120 : 140),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0E2233) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: (watch.clickContactContainer==index)|| highlight
                ? Border.all(color: const Color(0xFFD4AF37))
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor),
              SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(color: textColor.withValues(alpha: 0.7), fontSize: 12),
              ),
              SizedBox(height: 6.h),
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
