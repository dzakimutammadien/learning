import 'package:flutter/material.dart';
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/language_help_screen.dart';
import './screens/home_screen.dart';
import './screens/my_classes_screen.dart';
import './screens/notification_screen.dart';
import './utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CeLOE LMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryRed,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins', // Ganti ke Poppins
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB6252A),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryRed, width: 2),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/language-help': (context) => const LanguageHelpScreen(),
        '/home': (context) => const HomeScreen(),
        '/my-classes': (context) => const MyClassesScreen(),
        '/notifications': (context) => const NotificationScreen(),
      },
    );
  }
}