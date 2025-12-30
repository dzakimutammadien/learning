import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/class_detail_provider.dart';
import '../providers/material_detail_provider.dart';
import '../providers/tugas_detail_provider.dart';
import '../models/class_content_model.dart'; // IMPORT INI
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/class_content_card.dart';
import '../widgets/material_detail_bottom_sheet.dart';
import '../widgets/tugas_detail_bottom_sheet.dart';

class ClassDetailScreen extends StatefulWidget {
  final String classId;

  const ClassDetailScreen({
    Key? key,
    required this.classId,
  }) : super(key: key);

  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  int _currentIndex = 1;
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });

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
  }

  // Fungsi untuk filter konten berdasarkan search query
  List<ClassContent> _filterContents(List<ClassContent> contents) {
    if (_searchQuery.isEmpty) {
      return contents;
    }
    
    return contents.where((content) {
      final titleLower = content.title.toLowerCase();
      final descLower = content.deskripsi.toLowerCase();
      final pertemuanLower = content.pertemuan.toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      
      return titleLower.contains(queryLower) ||
             descLower.contains(queryLower) ||
             pertemuanLower.contains(queryLower);
    }).toList();
  }

  // Fungsi untuk show material detail bottom sheet
  void _showMaterialDetailBottomSheet(BuildContext context, String materialId) {
    final materialProvider = Provider.of<MaterialDetailProvider>(context, listen: false);
    final materialDetail = materialProvider.getMaterialDetailById(materialId);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return MaterialDetailBottomSheet(materialDetail: materialDetail,materialId: materialId, );
      },
    );
  }

  // Fungsi untuk show tugas/kuis detail bottom sheet
  void _showTugasDetailBottomSheet(BuildContext context, String tugasId) {
    final tugasProvider = Provider.of<TugasDetailProvider>(context, listen: false);
    final tugasDetail = tugasProvider.getTugasDetailById(tugasId);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TugasDetailBottomSheet(tugasDetail: tugasDetail);
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final classDetailProvider = Provider.of<ClassDetailProvider>(context);
    final classDetail = classDetailProvider.getClassDetailById(widget.classId);
    
    final materials = classDetailProvider.getMaterialsByClassId(widget.classId);
    final assignments = classDetailProvider.getAssignmentsByClassId(widget.classId);
    
    // Filter konten berdasarkan search query
    final filteredMaterials = _filterContents(materials);
    final filteredAssignments = _filterContents(assignments);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header dengan background merah
          Container(
            height: 180,
            width: double.infinity,
            color: const Color(0xFFB74848),
            padding: const EdgeInsets.only(
              top: 40,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Baris 1: Back button dan Judul
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 10),
                    
                    // Judul Kelas
                    Expanded(
                      child: Text(
                        '${classDetail.namaMataKuliah} ${classDetail.kodeKelas}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.3,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Search Bar
                Container(
                  height: 40,
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
                    children: [
                      const SizedBox(width: 16),
                      Icon(Icons.search, color: AppColors.grey, size: 20),
                      const SizedBox(width: 8),
                      // TextField untuk input search
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari materi atau tugas...',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      // Clear button jika ada teks
                      if (_searchQuery.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab selector
          Container(
            height: 50,
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tab Materi
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Materi',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _selectedTab == 0 
                              ? AppColors.black 
                              : AppColors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (_selectedTab == 0)
                          Container(
                            width: 27,
                            height: 3,
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(75),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                
                // Tab Tugas & Kuis
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Tugas Dan Kuis',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _selectedTab == 1 
                              ? AppColors.black 
                              : AppColors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (_selectedTab == 1)
                          Container(
                            width: 54,
                            height: 3,
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(75),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Konten berdasarkan tab
          Expanded(
            child: Container(
              color: AppColors.white,
              child: _buildContent(
                _selectedTab == 0 ? filteredMaterials : filteredAssignments,
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

  // Widget untuk menampilkan konten dengan hasil search
  Widget _buildContent(List<ClassContent> contents) {
    if (contents.isEmpty) {
      // Tampilkan pesan jika tidak ada hasil
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 60,
              color: AppColors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty 
                ? 'Tidak ada data'
                : 'Tidak ditemukan hasil untuk "$_searchQuery"',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey,
              ),
            ),
            const SizedBox(height: 8),
            if (_searchQuery.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchQuery = '';
                  });
                },
                child: const Text('Hapus pencarian'),
              ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        children: contents.map((content) {
          return ClassContentCard(
            content: content,
            isMaterialTab: _selectedTab == 0,
            onTap: () {
              if (_selectedTab == 0) {
                // Untuk materi, tampilkan bottom sheet materi
                _showMaterialDetailBottomSheet(context, content.materialId ?? content.id);
              } else {
                // Untuk tugas/kuis, tampilkan bottom sheet tugas
                _showTugasDetailBottomSheet(context, content.tugasId ?? content.id);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}