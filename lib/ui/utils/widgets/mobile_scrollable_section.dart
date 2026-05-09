import 'package:flutter/material.dart';

/// Column-only section content for mobile **master** scroll (see [MobileMainPage]).
/// Do not nest a vertical [ScrollView] here — the parent [ListView] scrolls everything.
class MobileScrollableSection extends StatelessWidget {
  const MobileScrollableSection({
    super.key,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  });

  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
