import 'package:flutter/material.dart'; // <-- PASTIKAN INI ADA
import '../utils/constants.dart';
import '../utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(AppConstants.splashDuration);
    // Akan diisi nanti dengan navigasi ke login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryRed,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo CeLOE - menggunakan Asset Image
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.school,
                    size: 70,
                    color: AppColors.primaryRed,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                AppConstants.appFullName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppConstants.university,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: AppColors.white.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 60),
              CircularProgressIndicator(
                color: AppColors.white,
                strokeWidth: 2,
              ),
              SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 40),
              Text(
                AppConstants.appVersion,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}