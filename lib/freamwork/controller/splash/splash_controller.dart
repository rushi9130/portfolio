import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:personal_portfolio/freamwork/dependency_injection/inject.dart';

final splashController = ChangeNotifierProvider((ref) {
  return getIt<SplashController>();
});

@injectable
class SplashController extends ChangeNotifier {

  

}
