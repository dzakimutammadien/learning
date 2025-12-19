import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/user_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _programStudiController;
  late TextEditingController _fakultasController;
  late TextEditingController _descriptionController;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.currentUser;
    final names = user.fullName.split(' ');
    _firstNameController = TextEditingController(text: names[0]);
    _lastNameController = TextEditingController(
        text: names.length > 1 ? names.sublist(1).join(' ') : '');
    _emailController = TextEditingController(text: user.email);
    _programStudiController = TextEditingController(text: user.programStudi);
    _fakultasController = TextEditingController(text: user.fakultas);
    _descriptionController = TextEditingController(
      text: user.description.isNotEmpty 
      ? user.description
      : 'Mahasiswa ${user.programStudi}, ${user.fakultas}',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _programStudiController.dispose();
    _fakultasController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      // Simulasi upload foto (dalam aplikasi nyata, upload ke server)
      String? photoUrl;
      if (_selectedImage != null) {
        photoUrl = _selectedImage!.path; // Simpan path lokal untuk demo
      }
      
      userProvider.updateUser(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        programStudi: _programStudiController.text.trim(),
        fakultas: _fakultasController.text.trim(),
        description: _descriptionController.text.trim(),
        photoUrl: photoUrl, // Kirim foto URL ke provider
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile berhasil diperbarui!'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Positioned(
            top: -99,
            left: 0,
            child: Container(
              width: 375,
              height: 419,
              color: const Color(0xFFB74848),
            ),
          ),
          
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),
                
                // Foto Profile dengan kemampuan upload
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 151,
                    height: 114,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(color: AppColors.white, width: 3),
                    ),
                    child: Stack(
                      children: [
                        // Tampilkan foto yang dipilih atau default
                        if (_selectedImage != null)
                          ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              width: 151,
                              height: 151,
                              fit: BoxFit.cover,
                            ),
                          )
                        else if (user.photoUrl != null)
                          ClipOval(
                            child: Image.network(
                              user.photoUrl!,
                              width: 151,
                              height: 151,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.person,
                                  size: 60,
                                  color: AppColors.primaryRed,
                                );
                              },
                            ),
                          )
                        else
                          Icon(
                            Icons.person,
                            size: 60,
                            color: AppColors.primaryRed,
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryRed,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                Container(
                  width: 280,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 24,
                            color: AppColors.black,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'About Me',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.class_,
                            size: 24,
                            color: AppColors.black,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kelas',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 24,
                            color: AppColors.primaryRed,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryRed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 31,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: const EdgeInsets.only(left: 257),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 47),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Pertama
                        Text(
                          'Nama Pertama',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _firstNameController,
                          label: '',
                          hintText: 'Masukkan nama pertama',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama pertama harus diisi';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Nama Terakhir
                        Text(
                          'Nama Terakhir',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _lastNameController,
                          label: '',
                          hintText: 'Masukkan nama terakhir',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama terakhir harus diisi';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Email Address
                        Text(
                          'E-mail Address',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _emailController,
                          label: '',
                          hintText: 'Masukkan email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email harus diisi';
                            }
                            if (!value.contains('@')) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Program Studi (mengganti Negara)
                        Text(
                          'Program Studi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _programStudiController,
                          label: '',
                          hintText: 'Masukkan program studi',
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Fakultas (tambahan baru)
                        Text(
                          'Fakultas',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: _fakultasController,
                          label: '',
                          hintText: 'Masukkan fakultas',
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Deskripsi
                        Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 280,
                          height: 106,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukkan deskripsi tentang Anda',
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Tombol Simpan
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 97,
                              height: 42,
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: _saveProfile,
                                child: Text(
                                  'Simpan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}