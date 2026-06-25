import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:coffechi2/screens_coustomer/base_screen_coustomer.dart';
import 'package:coffechi2/screens_managment/base_screen_manager.dart';
import 'package:coffechi2/screens_managment/menu_managment_screen.dart';
import 'package:coffechi2/screens_managment/comments_manager.dart';
import 'package:coffechi2/sign_up_screen.dart';
import 'package:coffechi2/splash_screen.dart';
import 'package:coffechi2/theme/app_colors.dart';
import 'package:coffechi2/theme/app_text_theme.dart';
import 'Login_Screen.dart';
import 'dio_client.dart';

void main() {
  final dioClient = DioClient();
  dioClient.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'کافه‌چی',
      debugShowCheckedModeBanner: false,
      locale: const Locale('fa', 'IR'),
      supportedLocales: const [Locale('fa', 'IR')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        fontFamily: AppTextTheme.fontFamily,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
        ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/BaseScreenCoustomer': (context) => const BaseScreenCostomer(),
        '/BaseScreenManager': (context) => const BaseScreenManager(),
        '/LoginScreen': (context) => const LoginScreen(),
        '/SignupScreen': (context) => const SignupScreen(),
        '/MenuManagementScreen': (context) => const MenuManagementScreen(),
        '/CommentsManager': (context) => const CommentsManager(),
      },
    );
  }
}