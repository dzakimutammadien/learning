import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscurePassword = true;
  
  // CREDENTIAL DUMMY UNTUK TUGAS KULIAH
  final String _dummyEmail = '1301213123@365.telkomuniversity.ac.id';
  final String _dummyPassword = 'Telkom123';
  final String _dummyNama = 'Dzaki Mutammadien';

  @override
  void initState() {
    super.initState();
    // Auto-fill credential dummy untuk memudahkan testing
    _emailController.text = _dummyEmail;
    _passwordController.text = _dummyPassword;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // SIMULASI PROSES LOGIN (1.5 detik saja)
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _isLoading = false;
        });
        
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        
        // VALIDASI CREDENTIAL DUMMY
        if (email == _dummyEmail && password == _dummyPassword) {
          // LOGIN BERHASIL - LANGSUNG KE HOME
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // LOGIN GAGAL - TAMPILKAN ERROR
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Email atau password salah!'),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.help, color: AppColors.primaryRed),
              const SizedBox(width: 10),
              Text(
                'Bantuan Login (DEMO)',
                style: TextStyle(
                  color: AppColors.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '📋 Credential untuk Testing:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('📧 Email: $_dummyEmail'),
                      Text('🔐 Password: $_dummyPassword'),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'ℹ️ Ini adalah aplikasi DEMO untuk tugas kuliah.',
                  style: TextStyle(fontSize: 12, color: AppColors.grey),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/language-help');
                  },
                  child: Row(
                    children: [
                      Text(
                        'Lihat petunjuk lengkap',
                        style: TextStyle(
                          color: AppColors.primaryRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.chevron_right, color: AppColors.primaryRed),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('TUTUP', style: TextStyle(color: AppColors.primaryRed)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan logo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primaryRed,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.school,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'CeLOE DEMO',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryRed,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Aplikasi Demo Tugas Kuliah',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Title
              Text(
                'Login DEMO',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              
              const SizedBox(height: 8),
              
              Text(
                'Gunakan credential di bawah untuk testing',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
              
              // Credential Info Box
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryRed.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, size: 18, color: AppColors.primaryRed),
                        const SizedBox(width: 8),
                        Text(
                          'Credential Testing:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryRed,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Email: $_dummyEmail'),
                    Text('Password: $_dummyPassword'),
                    Text('Nama: $_dummyNama'),
                  ],
                ),
              ),
              
              // Login Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email 365',
                      hintText: 'username@365.telkomuniversity.ac.id',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email harus diisi';
                        }
                        if (!value.endsWith('@365.telkomuniversity.ac.id')) {
                          return 'Harus menggunakan format @365.telkomuniversity.ac.id';
                        }
                        return null;
                      },
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Masukkan password',
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password harus diisi';
                        }
                        if (value.length < 6) {
                          return 'Password minimal 6 karakter';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Login Button
                    CustomButton(
                      text: 'Log in',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Help Button
                    CustomButton(
                      text: 'Bantuan ?',
                      onPressed: _showHelpDialog,
                      backgroundColor: Colors.white,
                      textColor: AppColors.primaryRed,
                      fullWidth: true,
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Info Demo
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[100]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.developer_mode, color: Colors.blue[700]),
                              const SizedBox(width: 8),
                              Text(
                                'INFORMASI DEMO APP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Aplikasi ini hanya untuk demo/tugas kuliah\n'
                            '• Tidak terhubung ke sistem asli Telkom University\n'
                            '• Authentication berupa simulasi sederhana\n'
                            '• Data tidak disimpan ke server',
                            style: TextStyle(fontSize: 13, color: AppColors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      '© 2025 Telkom University - CeLOE DEMO',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grey,
                      ),
                    ),
                    Text(
                      'Tugas Kuliah - Flutter Development',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}