import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_portfolio/freamwork/controller/home/home_controller.dart';
import 'package:personal_portfolio/freamwork/dependency_injection/inject.dart';
import 'package:personal_portfolio/freamwork/provider/cloud_storage/firebase_db.dart';
import 'package:personal_portfolio/ui/mainpage/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseDb.initFirebase();
  await configureMainDependencies(environment: Env.development);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeController);
    /// navigator 1.0
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: watch.isDarkOn ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xFFF7FAFC),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFEAF1FB),
              foregroundColor: Color(0xFF102A43),
              elevation: 0,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E88E5),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0A1628),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0A182C),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFF5C542),
              brightness: Brightness.dark,
            ),
          ),
          home: const MainPage(),
        );
      },
    );
  }
}
