import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';

mixin BaseStatefulWidget<Page extends StatefulWidget> on State<Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => buildPage(context),
      desktop: (BuildContext context) => buildPage(context),
    );
  }

  Widget buildPage(BuildContext context);
}
mixin BaseStatelessWidget on StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => buildPage(context),
      desktop: (BuildContext context) => buildPage(context),
    );
  }

  Widget buildPage(BuildContext context);
}
mixin BaseConsumerWidget on ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => buildPage(context, ref),
      desktop: (BuildContext context) => buildPage(context, ref),
    );
  }

  Widget buildPage(BuildContext context, WidgetRef ref);
}
mixin BaseConsumerWidgetStateFullWidget<Page extends ConsumerStatefulWidget>
    on State<Page> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => buildPage(context),
      desktop: (BuildContext context) => buildPage(context),
    );
  }

  Widget buildPage(BuildContext context);
}
mixin BaseConsumerStatefulWidget<Page extends ConsumerStatefulWidget>
    on State<Page> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => buildPage(context),
      desktop: (BuildContext context) => buildPage(context),
    );
  }

  Widget buildPage(BuildContext context);
}
