import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/class_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/class_card_my_classes.dart';

class MyClassesScreen extends StatefulWidget {
  const MyClassesScreen({Key? key}) : super(key: key);

  @override
  _MyClassesScreenState createState() => _MyClassesScreenState();
}

class _MyClassesScreenState extends State<MyClassesScreen> {
  int _currentIndex = 1; // Karena ini halaman "Kelas Saya"

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Sudah di halaman Kelas Saya
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final classProvider = Provider.of<ClassProvider>(context);
    final myClasses = classProvider.myClasses;

    return Scaffold(
      backgroundColor: AppColors.lightGreyTransparent,
      body: Column(
        children: [
          // Header dengan back button
          Container(
            height: 91,
            width: double.infinity,
            color: AppColors.white,
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Kelas Saya',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // Konten Kelas
          Expanded(
            child: Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  top: 25,
                  bottom: 100,
                ),
                child: Column(
                  children: myClasses.map((kelas) {
                    return ClassCardMyClasses(
                      kelas: kelas,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/kelas-detail',
                          arguments: {
                            'id': kelas.id,
                            'kodeKelas': kelas.kodeKelas,
                            'namaMataKuliah': kelas.namaMataKuliah,
                            'dosen': kelas.dosen,
                            'progress': kelas.progress,
                            'tahunAjaran': kelas.tahunAjaran,
                            'imageUrl': kelas.imageUrl,
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}