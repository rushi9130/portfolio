import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/ui/utils/widgets/mobile_scrollable_section.dart';

/// Single vertical scroll; short content centers in the viewport.
class ContactMobile extends ConsumerWidget {
  const ContactMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final isDark = watch.isDarkOn;
    final textColor = isDark ? Colors.white : const Color(0xFF102A43);
    final accent = const Color(0xFFF5C542);
    final cardBg = isDark ? const Color(0xFF0E2233) : Colors.white;

    return MobileScrollableSection(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      children: [
        Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              children: const [
                TextSpan(text: 'Get In'),
                TextSpan(text: ' Touch', style: TextStyle(color: Color(0xFFF5C542))),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        /// wrap card make it correct
        LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = (constraints.maxWidth - 12) / 2;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                SizedBox(
                  width: itemWidth,
                  child: _ContactChip(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: '+91-${watch.phoneNumber}',
                    index: 0,
                    cardBg: cardBg,
                    textColor: textColor,
                    accent: accent,
                    highlight: watch.clickContactContainerMouse == 0,
                    selected: watch.clickContactContainer == 0,
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: _ContactChip(
                    icon: Icons.email,
                    title: 'Email',
                    value: watch.email,
                    index: 1,
                    cardBg: cardBg,
                    textColor: textColor,
                    accent: accent,
                    highlight: watch.clickContactContainerMouse == 1,
                    selected: watch.clickContactContainer == 1,
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: _ContactChip(
                    icon: Icons.business_center,
                    title: 'LinkedIn',
                    value: 'Connect on LinkedIn',
                    index: 2,
                    cardBg: cardBg,
                    textColor: textColor,
                    accent: accent,
                    highlight: watch.clickContactContainerMouse == 2,
                    selected: watch.clickContactContainer == 2,
                  ),
                ),

                SizedBox(
                  width: itemWidth,
                  child: _ContactChip(
                    icon: Icons.code,
                    title: 'GitHub',
                    value: 'View My Code',
                    index: 3,
                    cardBg: cardBg,
                    textColor: textColor,
                    accent: accent,
                    highlight: watch.clickContactContainerMouse == 3,
                    selected: watch.clickContactContainer == 3,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),
        Text(
          '📍 ${watch.myLocation}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: textColor.withValues(alpha: 0.12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _underlineField(
                context,
                watch.nameController,
                'Name',
                focusNode: watch.nameFocus,
                nextFocus: watch.emailFocus,
                textInputAction: TextInputAction.next,
              ),

              _underlineField(
                context,
                watch.emailController,
                'Email',
                focusNode: watch.emailFocus,
                nextFocus: watch.subjectFocus,
                textInputAction: TextInputAction.next,
              ),

              _underlineField(
                context,
                watch.subjectController,
                'Subject',
                focusNode: watch.subjectFocus,
                nextFocus: watch.messageFocus,
                textInputAction: TextInputAction.next,
              ),

              _underlineField(
                context,
                watch.messageController,
                'Message',
                maxLines: 4,
                focusNode: watch.messageFocus,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: watch.isSending ? null : () => watch.sendMessage(context),
                child: watch.isSending
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                      )
                    : const Text('SEND MESSAGE', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '© ${DateTime.now().year} ${watch.firstName} ${watch.lastName}. All rights reserved.',
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor.withValues(alpha: 0.65), fontSize: 11),
        ),
        Text(
          'Designed & Built with Flutter',
          textAlign: TextAlign.center,
          style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 11),
        ),
      ],
    );
  }

  static Widget _underlineField(
      BuildContext context,
      TextEditingController controller,
      String hint, {
        int maxLines = 1,
        FocusNode? focusNode,
        FocusNode? nextFocus,
        TextInputAction? textInputAction,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? Colors.white : const Color(0xFF102A43);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        textInputAction: textInputAction,
        onSubmitted: (_) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        style: TextStyle(color: fg),
        cursorColor: const Color(0xFFD4AF37),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: fg.withValues(alpha: 0.55)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: isDark
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

class _ContactChip extends ConsumerWidget {
  const _ContactChip({
    required this.icon,
    required this.title,
    required this.value,
    required this.index,
    required this.cardBg,
    required this.textColor,
    required this.accent,
    required this.highlight,
    required this.selected,
  });

  final IconData icon;
  final String title;
  final String value;
  final int index;
  final Color cardBg;
  final Color textColor;
  final Color accent;
  final bool highlight;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    final border = (selected || highlight) ? Border.all(color: const Color(0xFFD4AF37)) : null;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: selected ? 0.18 : 0.08,
            ),
            blurRadius: selected ? 18 : 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => watch.changeClickContactContainer(index),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha: 0.14),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: accent,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  title,
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
