import 'package:flutter/material.dart';
import '../models/class_content_model.dart';
import '../utils/app_colors.dart';

class ClassContentCard extends StatelessWidget {
  final dynamic content; // Bisa ClassContent atau model lain
  final bool isMaterialTab;
  final VoidCallback? onTap;

  const ClassContentCard({
    Key? key,
    required this.content,
    required this.isMaterialTab,
    this.onTap,
  }) : super(key: key);

  // Helper method untuk mendapatkan title
  String get _title {
    return content.title ?? '';
  }

  // Helper method untuk mendapatkan deskripsi
  String get _deskripsi {
    return content.deskripsi ?? '';
  }

  // Helper method untuk mendapatkan pertemuan
  String get _pertemuan {
    return content.pertemuan ?? '';
  }

  // Helper method untuk mendapatkan type
  String get _type {
    return content.type?.toString() ?? '';
  }

  // Fungsi untuk mendapatkan icon berdasarkan type
  IconData _getContentIconWidget() {
    if (_type.contains('materi') || isMaterialTab) {
      return Icons.menu_book;
    } else if (_type.contains('tugas')) {
      return Icons.assignment;
    } else if (_type.contains('kuis')) {
      return Icons.quiz;
    } else {
      return Icons.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 332,
        height: 100,
        margin: const EdgeInsets.only(left: 21, right: 21, top: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon di kiri
            Container(
              width: 60,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF53A9E3),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Center(
                child: Icon(
                  _getContentIconWidget(),
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),

            // Konten
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Badge dan judul dalam satu baris
                    Row(
                      children: [
                        // Badge kecil
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF53A9E3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: const Color(0xFF53A9E3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            _pertemuan,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF53A9E3),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        
                        // Judul
                        Expanded(
                          child: Text(
                            _title,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),

                    // Deskripsi
                    Text(
                      _deskripsi,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // Arrow di kanan
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}