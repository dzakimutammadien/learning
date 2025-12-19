import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/tugas_card.dart';
import '../widgets/kelas_card.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  // Dummy data untuk Tugas
  final List<Map<String, dynamic>> _listTugas = [
    {
      'id': '1',
      'mataKuliah': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
      'judulTugas': 'Tugas 01 - UID Android Mobile Game',
      'deadline': 'Jumat 26 Februari, 23:59 WIB',
    },
    {
      'id': '2', 
      'mataKuliah': 'SISTEM OPERASI D4SM-44-02 [DDS]',
      'judulTugas': '02. [Tugas] Laporan Akhir Praktikum ke - 2',
      'deadline': 'Jumat 26 Februari, 23:59 WIB',
    },
  ];
  
  // Dummy data untuk Kelas
  final List<Map<String, dynamic>> _listKelas = [
    {
      'id': '1',
      'kodeKelas': 'D4SM-42-03',
      'namaMataKuliah': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
      'dosen': 'ADY',
      'progress': 89.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '2',
      'kodeKelas': 'D4SM-41-GAB1',
      'namaMataKuliah': 'KEWARGANEGARAAN',
      'dosen': 'BBO',
      'progress': 86.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '3',
      'kodeKelas': 'D4SM-44-02',
      'namaMataKuliah': 'SISTEM OPERASI',
      'dosen': 'DDS',
      'progress': 90.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '4',
      'kodeKelas': 'D4SM-41-GAB1',
      'namaMataKuliah': 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA',
      'dosen': 'APJ',
      'progress': 90.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '5',
      'kodeKelas': 'D4SM-41-GAB1',
      'namaMataKuliah': 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC',
      'dosen': 'ARS',
      'progress': 90.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '6',
      'kodeKelas': 'D4SM-43-04',
      'namaMataKuliah': 'PEMROGRAMAN MULTIMEDIA INTERAKTIF',
      'dosen': 'TPR',
      'progress': 90.0,
      'tahunAjaran': 2021,
    },
    {
      'id': '7',
      'kodeKelas': 'D3TT-44-02',
      'namaMataKuliah': 'OLAHRAGA',
      'dosen': 'EYR',
      'progress': 90.0,
      'tahunAjaran': 2021,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Background merah di atas
          Positioned(
            top: -210,
            left: 0,
            child: Container(
              width: 375,
              height: 307,
              color: AppColors.lightRed,
            ),
          ),
          
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan nama user dan status
                Container(
                  padding: const EdgeInsets.only(
                    top: 37,
                    left: 13,
                    right: 20,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nama User
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hallo, DANDY CANDRA PRATAMA',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Selamat datang di CeLOE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      
                      // Status Mahasiswa
                      Container(
                        width: 105,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.darkRed,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MAHASISWA',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.white),
                              ),
                              child: Icon(
                                Icons.search,
                                size: 12,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Section: Tugas
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Tugas Yang Akan Datang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
                
                // Horizontal Scroll Tugas
                Container(
                  width: double.infinity,
                  height: 180,
                  margin: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        // Tugas 1
                        TugasCard(tugas: _listTugas[0]),
                        const SizedBox(width: 20),
                        // Tugas 2
                        TugasCard(tugas: _listTugas[1]),
                        const SizedBox(width: 20),
                        // Tugas Kosong (Hari Ini)
                        TugasCard(
                          tugas: {
                            'id': '3',
                            'mataKuliah': '',
                            'judulTugas': '',
                            'deadline': '',
                          },
                          isTodayEmpty: true,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                
                // Section: Pengumuman
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pengumuman Terakhir',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Aksi lihat semua pengumuman
                        },
                        child: Text(
                          'Lihat Semua',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: AppColors.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Container Pengumuman
                Container(
                  width: double.infinity,
                  height: 229,
                  margin: const EdgeInsets.only(top: 10),
                  color: AppColors.lightGreyTransparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 12),
                        child: Text(
                          'Maintenance Pra UAS Semester Genap 2020/2021',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Gambar Pengumuman (placeholder)
                      Center(
                        child: Container(
                          width: 310,
                          height: 169,
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.announcement,
                            size: 60,
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Section: Progres Kelas
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Progres Kelas',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
                
                // List Kelas
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: _listKelas.map((kelas) {
                      return KelasCard(kelas: kelas);
                    }).toList(),
                  ),
                ),
                
                // Spacer untuk bottom navigation
                const SizedBox(height: 80),
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
                  // Navigasi ke screen yang sesuai
                  switch (index) {
                    case 0:
                      // Sudah di Home
                      break;
                    case 1:
                      Navigator.pushNamed(context, '/my-classes');
                      break;
                    case 2:
                      Navigator.pushNamed(context, '/notifications');
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
}