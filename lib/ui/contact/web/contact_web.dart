
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



  Widget _input(
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
        FocusNode? focusNode,
        FocusNode? nextFocus,
        TextInputAction? textInputAction,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        maxLines: maxLines,

        onSubmitted: (_) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },

        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : const Color(0xFF102A43),
        ),

        cursorColor: const Color(0xFFD4AF37),

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: (
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF102A43)
            ).withValues(alpha: 0.6),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white24
                  : const Color(0xFFB6C2CF),
            ),
          ),

          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFD4AF37),
            ),
          ),
        ),
      ),
    );
  }

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
        SizedBox(height: 30.h),
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
          _input(
            watch.nameController,
            "Name",
            focusNode: watch.nameFocus,
            nextFocus: watch.emailFocus,
            textInputAction: TextInputAction.next,
          ),

          _input(
            watch.emailController,
            "Email",
            focusNode: watch.emailFocus,
            nextFocus: watch.subjectFocus,
            textInputAction: TextInputAction.next,
          ),

          _input(
            watch.subjectController,
            "Subject",
            focusNode: watch.subjectFocus,
            nextFocus: watch.messageFocus,
            textInputAction: TextInputAction.next,
          ),

          _input(
            watch.messageController,
            "Message",
            maxLines: 4,
            focusNode: watch.messageFocus,
            textInputAction: TextInputAction.done,
          ),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);

    final isDark = watch.isDarkOn;
    final selected = watch.clickContactContainer == index;

    final active = selected || highlight;

    final textColor =
    isDark ? Colors.white : const Color(0xFF102A43);

    return MouseRegion(
      onEnter: (_) {
        watch.changeClickContactMouseContainer(index);
      },
      onExit: (_) {
        watch.changeClickContactMouseContainer(-1);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        width: compact ? 250 : 280,
        constraints: BoxConstraints(
          minHeight: compact ? 150 : 170,
        ),

        transform: Matrix4.translationValues(
          0,
          active ? -6 : 0,
          0,
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
              const Color(0xFF11253B),
              const Color(0xFF0B1C2D),
            ]
                : [
              Colors.white,
              const Color(0xFFF7FAFC),
            ],
          ),

          border: Border.all(
            color: active
                ? const Color(0xFFF5C542)
                : (isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFE2E8F0)),
            width: active ? 1.4 : 1,
          ),

          boxShadow: [
            BoxShadow(
              color: active
                  ? const Color(0xFFF5C542).withValues(alpha: 0.18)
                  : Colors.black.withValues(
                alpha: isDark ? 0.28 : 0.08,
              ),
              blurRadius: active ? 24 : 14,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(26),

          child: InkWell(
            borderRadius: BorderRadius.circular(26),

            onTap: () {
              watch.changeClickContactContainer(index);
            },

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 24,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /// Icon Circle
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFF5C542)
                              .withValues(alpha: active ? 0.32 : 0.18),

                          const Color(0xFFD4AF37)
                              .withValues(alpha: active ? 0.22 : 0.10),
                        ],
                      ),

                      border: Border.all(
                        color: const Color(0xFFF5C542)
                            .withValues(alpha: active ? 0.7 : 0.25),
                      ),
                    ),

                    child: Icon(
                      icon,
                      size: compact ? 19 : 30,
                      color: const Color(0xFFF5C542),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  /// Title
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.7),
                      fontSize: compact ? 12 : 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  /// Value
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: compact ? 14 : 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
