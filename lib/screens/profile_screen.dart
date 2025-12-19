import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;
  int _selectedTab = 0;

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.logout, color: AppColors.primaryRed),
              const SizedBox(width: 10),
              Text(
                'Konfirmasi Logout',
                style: TextStyle(
                  color: AppColors.primaryRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('BATAL', style: TextStyle(color: AppColors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, 
                  '/login', 
                  (route) => false
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
              ),
              child: const Text('LOGOUT', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get user from provider - AUTO UPDATES
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background merah di atas
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
                // Header dengan back button
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
                            'Profile',
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
                
                // Foto Profile - AUTO UPDATES dengan foto
                Container(
                  width: 151,
                  height: 114,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(color: AppColors.white, width: 3),
                  ),
                  child: user.photoUrl != null 
                    ? ClipOval(
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
                    : Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primaryRed,
                      ),
                ),
                
                const SizedBox(height: 20),
                
                // Nama User - AUTO UPDATES
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                
                // Email User - AUTO UPDATES
                Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Tab Menu
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
                      // About Me Tab
                      ProfileMenuItem(
                        icon: Icons.info_outline,
                        label: 'About Me',
                        isActive: _selectedTab == 0,
                        onTap: () => setState(() => _selectedTab = 0),
                      ),
                      
                      // Kelas Tab
                      ProfileMenuItem(
                        icon: Icons.class_,
                        label: 'Kelas',
                        isActive: _selectedTab == 1,
                        onTap: () => setState(() => _selectedTab = 1),
                      ),
                      
                      // Edit Profile Tab
                      ProfileMenuItem(
                        icon: Icons.edit,
                        label: 'Edit Profile',
                        isActive: _selectedTab == 2,
                        onTap: () {
                          Navigator.pushNamed(context, '/edit-profile');
                        },
                      ),
                    ],
                  ),
                ),
                
                // Indicator untuk tab aktif
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 31,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    margin: EdgeInsets.only(
                      left: _selectedTab == 0 ? 88 : 
                            _selectedTab == 1 ? 172 : 257,
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Content berdasarkan tab yang aktif
                if (_selectedTab == 0) ...[
                  // About Me Content - AUTO UPDATES semua data
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi User',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        
                        // Nama Lengkap
                        _buildInfoRow('Nama Lengkap', user.fullName),
                        const SizedBox(height: 10),
                        
                        // Email
                        _buildInfoRow('Email', user.email),
                        const SizedBox(height: 10),
                        
                        // Program Studi
                        _buildInfoRow('Program Studi', user.programStudi),
                        const SizedBox(height: 10),
                        
                        // Fakultas
                        _buildInfoRow('Fakultas', user.fakultas),
                        const SizedBox(height: 20),
                        
                        // Deskripsi
                        Text(
                          'Tentang Saya',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user.description.isNotEmpty 
                              ? user.description 
                              : 'Belum ada deskripsi. Klik "Edit Profile" untuk menambahkan.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        Text(
                          'Aktivitas Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildInfoRow('First Access', user.firstAccess),
                        const SizedBox(height: 10),
                        _buildInfoRow('Last Access', user.lastAccess),
                      ],
                    ),
                  ),
                ] else if (_selectedTab == 1) ...[
                  // Kelas Content
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: userProvider.userClasses.map((kelas) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context, 
                              '/kelas-detail',
                              arguments: kelas,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 46,
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              children: [
                                // Warna kelas
                                Container(
                                  width: 64,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(kelas['color'] as int),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${kelas['namaMataKuliah']} ${kelas['kodeKelas']}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Tanggal Mulai ${kelas['tanggalMulai']}',
                                        style: TextStyle(
                                          fontSize: 9,
                                          color: AppColors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                
                // Tombol Logout
                if (_selectedTab == 0) ...[
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: _handleLogout,
                    child: Container(
                      width: 104,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.darkRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 20, color: AppColors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 100),
              ],
            ),
          ),
          
          // Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                  switch (index) {
                    case 0:
                      Navigator.pushReplacementNamed(context, '/home');
                      break;
                    case 1:
                      Navigator.pushReplacementNamed(context, '/my-classes');
                      break;
                    case 2:
                      Navigator.pushReplacementNamed(context, '/notifications');
                      break;
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method untuk menampilkan info dalam format yang rapi
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          child: Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}