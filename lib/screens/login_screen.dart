import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulasi proses login
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Navigasi ke home screen nanti
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              // Back button (optional)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primaryRed,
              ),
              
              const SizedBox(height: 30),
              
              // Title
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryRed,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'Access restricted only for Lecturer and Student\nof Telkom University',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Login Form
              // AKAN DIISI DENGAN FORM DETAIL
              
              // Help Button
              // AKAN DIISI
              
              const SizedBox(height: 20),
              
              // Login Button
              // AKAN DIISI
            ],
          ),
        ),
      ),
    );
  }
}