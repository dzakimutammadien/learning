import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/tugas_model.dart';

class TugasCard extends StatelessWidget {
  final Tugas tugas;
  final bool isTodayEmpty;

  const TugasCard({
    Key? key,
    required this.tugas,
    this.isTodayEmpty = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isTodayEmpty) {
      return Container(
        width: 334,
        height: 157,
        decoration: BoxDecoration(
          color: AppColors.darkRed,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gambar ilustrasi
            Positioned(
              left: 20,
              top: 9,
              child: Container(
                width: 100,
                height: 121,
                color: Colors.transparent,
                child: Icon(
                  Icons.sentiment_satisfied_alt,
                  size: 80,
                  color: AppColors.white,
                ),
              ),
            ),
            Positioned(
              left: 140,
              top: 132,
              child: Text(
                'Tidak Ada Tugas Dan Kuis Hari Ini',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 334,
      height: 157,
      decoration: BoxDecoration(
        color: AppColors.darkRed,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mata Kuliah
            Text(
              tugas.mataKuliah,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Judul Tugas
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  size: 16,
                  color: AppColors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  tugas.judulTugas,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Waktu Pengumpulan
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: AppColors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'Waktu Pengumpulan',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Deadline
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                tugas.deadline,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}