import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class LanguageHelpScreen extends StatefulWidget {
  const LanguageHelpScreen({Key? key}) : super(key: key);

  @override
  _LanguageHelpScreenState createState() => _LanguageHelpScreenState();
}

class _LanguageHelpScreenState extends State<LanguageHelpScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryRed),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Petunjuk Login',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryRed,
          labelColor: AppColors.primaryRed,
          unselectedLabelColor: AppColors.grey,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/indonesia_flag.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Text(
                            'ID',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('Indonesia'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/uk_flag.png',
                    width: 20,
                    height: 20,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Center(
                          child: Text(
                            'EN',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text('English'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab Indonesia
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Akses hanya untuk Dosen dan Mahasiswa Telkom University.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Login menggunakan Akun Microsoft Office 365 dengan mengikuti petunjuk berikut:',
                  style: TextStyle(fontSize: 15, color: AppColors.grey),
                ),
                const SizedBox(height: 16),
                _buildStep('1.', 'Username (Akun iGracias) ditambahkan "@365.telkomuniversity.ac.id"'),
                _buildStep('2.', 'Password (Akun iGracias) pada kolom Password.'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⚠️ Perhatian:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kegagalan yang terjadi pada Autentikasi disebabkan oleh Anda '
                        'belum mengubah Password Anda menjadi "Strong Password". '
                        'Pastikan Anda telah melakukan perubahan Password di iGracias.',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Informasi lebih lanjut dapat menghubungi Layanan CeLOE Helpdesk di:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildContactInfo(
                  Icons.mail,
                  'Mail:',
                  'infoceloe@telkomuniversity.ac.id',
                ),
                _buildContactInfo(
                  Icons.phone,
                  'WhatsApp:',
                  '+62 821-1666-3563',
                ),
              ],
            ),
          ),
          
          // Tab English
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Access restricted only for Lecturer and Student of Telkom University.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Login only using your Microsoft Office 365 Account by following these format:',
                  style: TextStyle(fontSize: 15, color: AppColors.grey),
                ),
                const SizedBox(height: 16),
                _buildStep('1.', 'Username (¡Gracias Account) followed with "@365.telkomuniversity.ac.id"'),
                _buildStep('2.', 'Password (SSO / ¡Gracias Account) on Password Field.'),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⚠️ Important:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.warning,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Failure upon Authentication could be possibly you have not yet '
                        'change your password into "Strong Password". '
                        'Make sure to change your Password only in ¡Gracias.',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'For further Information, please contact CeLOE Service Helpdesk:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildContactInfo(
                  Icons.mail,
                  'Mail:',
                  'infoceloe@telkomuniversity.ac.id',
                ),
                _buildContactInfo(
                  Icons.phone,
                  'WhatsApp:',
                  '+62 821-1666-3563',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryRed,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 15, color: AppColors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primaryRed),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.primaryRed,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}