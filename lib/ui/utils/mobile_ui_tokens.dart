import 'package:flutter/material.dart';

/// Shared colors and decorations so Android matches web sections (`*_web.dart`).
abstract final class MobileUiTokens {
  static const Color accent = Color(0xFFF5C542);
  static const Color textDark = Color(0xFF102A43);
  static const Color subtitleLight = Color(0xFF425466);
  static const Color progressTrackDark = Color(0xFF1C344D);
  static const Color progressTrackLight = Color(0xFFD6DFEA);
  static const Color progressValue = Color(0xFFBA994A);

  static List<Color> pageGradient(bool isDark) => isDark
      ? const [Color(0xFF0A1628), Color(0xFF0E2239), Color(0xFF132F4C)]
      : const [Color(0xFFF7FAFC), Color(0xFFEAF1FB), Color(0xFFDDE9F7)];

  static Color appBarBg(bool isDark) =>
      isDark ? const Color(0xFF0A182C) : const Color(0xFFEAF1FB);

  static Color drawerBg(bool isDark) =>
      isDark ? const Color(0xFF0E2239) : const Color(0xFFEAF1FB);

  static Color cardBg(bool isDark) =>
      isDark ? const Color(0xFF0F2235) : Colors.white;

  static Color bodyText(bool isDark) => isDark ? Colors.white : textDark;

  static Color subtitle(bool isDark) =>
      isDark ? Colors.white70 : subtitleLight;

  static List<BoxShadow> cardShadow(bool isDark) => [
        BoxShadow(
          color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.12),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];
}
