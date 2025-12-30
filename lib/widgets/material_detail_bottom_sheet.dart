import 'package:flutter/material.dart';
import '../models/material_detail_model.dart';
import '../models/tugas_detail_model.dart';
import '../utils/app_colors.dart';
import '../providers/tugas_detail_provider.dart';
import 'package:provider/provider.dart';
import '../screens/document_viewer_screen.dart'; 

class MaterialDetailBottomSheet extends StatefulWidget {
  final MaterialDetail materialDetail;
  final String materialId;

  const MaterialDetailBottomSheet({
    Key? key,
    required this.materialDetail,
    required this.materialId,
  }) : super(key: key);

  @override
  State<MaterialDetailBottomSheet> createState() => _MaterialDetailBottomSheetState();
}

class _MaterialDetailBottomSheetState extends State<MaterialDetailBottomSheet> {
  int _selectedTab = 0;

  List<TugasDetail> _getRelatedAssignments(BuildContext context) {
    final tugasProvider = Provider.of<TugasDetailProvider>(context, listen: false);
    final semuaTugas = tugasProvider.getAllTugasDetails();
    
    switch (widget.materialId) {
      case 'm1':
        return [];
      case 'm2':
        return [
          tugasProvider.getTugasDetailById('a1'),
          tugasProvider.getTugasDetailById('a2'),
        ];
      case 'm3':
        return [
          tugasProvider.getTugasDetailById('a3'),
        ];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final relatedAssignments = _getRelatedAssignments(context);
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          // Header dengan drag indicator
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),

          // Judul Materi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.materialDetail.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Info Pertemuan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.materialDetail.pertemuan,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryRed,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.materialDetail.stats,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 12),

          // Tab selector - TAMBAHKAN CONTAINER DENGAN HEIGHT FIXED
          Container(
            height: 35,
            color: const Color(0xFFF7F7F7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tab Lampiran Materi
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Lampiran Materi',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: _selectedTab == 0 
                              ? AppColors.black 
                              : AppColors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (_selectedTab == 0)
                          Container(
                            width: 60,
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
                
                // Tab Tugas dan Kuis
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 100),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tugas dan Kuis',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: _selectedTab == 1 
                              ? AppColors.black 
                              : AppColors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (_selectedTab == 1)
                          Container(
                            width: 60,
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

          // Konten berdasarkan tab - GUNAKAN EXPANDED DENGAN SINGLECHILDSCROLLVIEW
          Expanded(
            child: _selectedTab == 0 
              ? _buildMaterialTab() 
              : _buildAssignmentTab(context, relatedAssignments),
          ),
        ],
      ),
    );
  }

  // Widget untuk tab Lampiran Materi
  Widget _buildMaterialTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Deskripsi Materi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.materialDetail.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.black,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // List Lampiran
            if (widget.materialDetail.items.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lampiran Materi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...widget.materialDetail.items.map((item) {
                    return _buildMaterialItem(item);
                  }).toList(),
                ],
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget untuk tab Tugas dan Kuis
  Widget _buildAssignmentTab(BuildContext context, List<TugasDetail> assignments) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            if (assignments.isEmpty)
              // Jika tidak ada tugas
              Column(
                children: [
                  const SizedBox(height: 40),
                  // Ganti dengan asset Anda
                  Container(
                    width: 214,
                    height: 227,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(
                        Icons.assignment,
                        size: 64,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tidak Ada Tugas Dan Kuis Hari Ini',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Belum ada tugas atau kuis yang ditugaskan untuk materi ini',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            else
              // Jika ada tugas
              Column(
                children: [
                  ...assignments.map((tugas) {
                    return _buildAssignmentItem(tugas);
                  }).toList(),
                  const SizedBox(height: 20),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Widget untuk item Lampiran Materi
  Widget _buildMaterialItem(MaterialItem item) {
    IconData icon;
    Color iconColor;
    String typeText;

    switch (item.type) {
      case MaterialItemType.link:
        icon = Icons.link;
        iconColor = Colors.blue;
        typeText = 'Link';
        break;
      case MaterialItemType.document:
        icon = Icons.description;
        iconColor = Colors.orange;
        typeText = 'Dokumen';
        break;
      case MaterialItemType.video:
        icon = Icons.video_library;
        iconColor = Colors.red;
        typeText = 'Video';
        break;
      case MaterialItemType.interactive:
        icon = Icons.touch_app;
        iconColor = Colors.purple;
        typeText = 'Interaktif';
        break;
      case MaterialItemType.file:
        icon = Icons.insert_drive_file;
        iconColor = Colors.green;
        typeText = 'File';
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  typeText,
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              _handleItemTap(item);
            },
          ),
        ],
      ),
    );
  }

  // Widget untuk item Tugas/Kuis
  Widget _buildAssignmentItem(TugasDetail tugas) {
    IconData icon;
    Color iconColor;
    String typeText;

    if (tugas.type == TugasType.kuis) {
      icon = Icons.quiz;
      iconColor = Colors.orange;
      typeText = 'Kuis';
    } else {
      icon = Icons.assignment;
      iconColor = Colors.blue;
      typeText = 'Tugas';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tugas.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 10),
          
          Text(
            tugas.description,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.black,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          const SizedBox(height: 10),
          
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                'Tenggat: ${_formatDateTime(tugas.deadline)}',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.grey,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(tugas.status),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getStatusText(tugas.status),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleItemTap(MaterialItem item) {
    print('Item tapped: ${item.title}');
    switch (item.type) {
    case MaterialItemType.link:
      if (item.url != null) {
        print('Opening URL: ${item.url}');
        // Bisa tambahkan: launchUrl(Uri.parse(item.url!));
      }
      break;
    case MaterialItemType.document:
      // Navigasi ke DocumentViewerScreen untuk dokumen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DocumentViewerScreen(
            documentTitle: item.title,
            documentType: 'ppt', // atau 'pdf' sesuai kebutuhan
            imageUrls: [], // Berikan list image URLs jika ada
          ),
        ),
      );
      break;
    case MaterialItemType.video:
      if (item.url != null) {
        print('Opening video: ${item.url}');
        // Bisa navigasi ke VideoPlayerScreen
      }
      break;
    case MaterialItemType.interactive:
      print('Opening interactive content');
      break;
    case MaterialItemType.file:
      if (item.filePath != null) {
        print('Opening file: ${item.filePath}');
        // Untuk file, juga bisa ke DocumentViewerScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DocumentViewerScreen(
              documentTitle: item.title,
              documentType: 'file',
              imageUrls: [],
            ),
          ),
        );
      } else if (item.url != null) {
        print('Opening file from URL: ${item.url}');
      }
      break;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getDocumentType(String title) {
  final lowerTitle = title.toLowerCase();
  if (lowerTitle.contains('ppt') || 
      lowerTitle.contains('slide') ||
      lowerTitle.contains('presentation') ||
      lowerTitle.contains('powerpoint')) {
    return 'ppt';
  } else if (lowerTitle.contains('pdf')) {
    return 'pdf';
  } else if (lowerTitle.contains('word') || lowerTitle.contains('doc')) {
    return 'word';
  } else {
    return 'document';
  }
}

// Helper function untuk mendapatkan gambar dokumen (simulasi)
List<String> _getDocumentImages(String title) {
  // Ini contoh mapping sederhana untuk simulasi
  // Di aplikasi sebenarnya, ini akan mengambil dari server/asset
  if (title.contains('Pengantar User Interface Design')) {
    return [
      'assets/images/ppt/slide1.jpg',
      'assets/images/ppt/slide2.jpg',
      'assets/images/ppt/slide3.jpg',
      'assets/images/ppt/slide4.jpg',
    ];
  } else if (title.contains('Empat Teori Dasar Antarmuka Pengguna')) {
    return [
      'assets/images/docs/doc1.jpg',
      'assets/images/docs/doc2.jpg',
    ];
  }
  return [];
}

// Fungsi untuk menampilkan dialog link
void _showLinkDialog(String title, String url) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Buka Link: $title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('URL: $url'),
          const SizedBox(height: 10),
          const Text('Apakah Anda ingin membuka link ini di browser?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('BATAL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // launchUrl(Uri.parse(url));
            print('Opening browser: $url');
          },
          child: const Text('BUKA'),
        ),
      ],
    ),
  );
}

// Fungsi untuk menampilkan dialog video
void _showVideoDialog(String title, String url) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Putar Video: $title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('URL: $url'),
          const SizedBox(height: 10),
          const Text('Apakah Anda ingin memutar video ini?'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('BATAL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push untuk video player screen
            print('Opening video player: $url');
          },
          child: const Text('PUTAR'),
        ),
      ],
    ),
  );
}

// Fungsi untuk menampilkan dialog konten interaktif
void _showInteractiveDialog(String title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Konten Interaktif: $title'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.touch_app, size: 50, color: Colors.blue),
          SizedBox(height: 10),
          Text('Konten interaktif akan terbuka di aplikasi pembelajaran.'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('BATAL'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigasi ke screen konten interaktif
            print('Opening interactive content: $title');
          },
          child: const Text('BUKA'),
        ),
      ],
    ),
  );
}

  Color _getStatusColor(TugasStatus status) {
    switch (status) {
      case TugasStatus.belumDikerjakan:
        return Colors.orange;
      case TugasStatus.dalamPengerjaan:
        return Colors.blue;
      case TugasStatus.selesai:
        return Colors.green;
      case TugasStatus.terlambat:
        return Colors.red;
    }
  }

  String _getStatusText(TugasStatus status) {
    switch (status) {
      case TugasStatus.belumDikerjakan:
        return 'Belum Dikerjakan';
      case TugasStatus.dalamPengerjaan:
        return 'Dalam Pengerjaan';
      case TugasStatus.selesai:
        return 'Selesai';
      case TugasStatus.terlambat:
        return 'Terlambat';
    }
  }
}