import 'package:flutter/material.dart';
import '../models/class_content_model.dart';
import '../utils/app_colors.dart';

class ClassContentCard extends StatelessWidget {
  final ClassContent content;
  final bool isMaterialTab;

  const ClassContentCard({
    Key? key,
    required this.content,
    required this.isMaterialTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332,
      height: 100, // Lebih pendek
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
            decoration: const BoxDecoration(
              color: Color(0xFF53A9E3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: _getContentIconWidget(),
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
                          content.pertemuan,
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
                          content.title,
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
                    content.deskripsi,
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
    );
  }

  // Widget untuk icon berdasarkan type
  Widget _getContentIconWidget() {
    IconData iconData;
    switch (content.type) {
      case ContentType.materi:
        iconData = Icons.menu_book;
        break;
      case ContentType.tugas:
        iconData = Icons.assignment;
        break;
      case ContentType.kuis:
        iconData = Icons.quiz;
        break;
      default:
        iconData = Icons.description;
    }

    return Icon(
      iconData,
      size: 28,
      color: Colors.white,
    );
  }
}