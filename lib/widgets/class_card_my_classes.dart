import 'package:flutter/material.dart';
import '../models/class_model.dart';
import '../utils/app_colors.dart';

class ClassCardMyClasses extends StatelessWidget {
  final ClassItem kelas;
  final VoidCallback? onTap;

  const ClassCardMyClasses({
    Key? key,
    required this.kelas,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hitung width progress bar merah
    final progressWidth = (kelas.progress / 100) * 197;
    final remainingWidth = 197 - progressWidth;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 319,
        height: 140,
        margin: const EdgeInsets.only(bottom: 28),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar kelas
            Container(
              width: 106,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.lightGrey,
                image: kelas.imageUrl.isNotEmpty
                    ? DecorationImage(
                        image: AssetImage(kelas.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: kelas.imageUrl.isEmpty
                  ? Icon(
                      Icons.class_,
                      size: 40,
                      color: AppColors.grey,
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // Informasi kelas
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tahun/Semester
                  Text(
                    kelas.tahunSemester,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Nama mata kuliah + kode kelas
                  Text(
                    '${kelas.namaMataKuliah} ${kelas.kodeKelas}',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // Progress bar container
                  Container(
                    width: 197,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                        // Bagian merah (progress)
                        Container(
                          width: progressWidth,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFFAF1116),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: progressWidth >= 197 ? Radius.circular(20) : Radius.zero,
                              bottomRight: progressWidth >= 197 ? Radius.circular(20) : Radius.zero,
                            ),
                          ),
                        ),
                        // Bagian putih (sisa)
                        Container(
                          width: remainingWidth,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              topLeft: progressWidth <= 0 ? Radius.circular(20) : Radius.zero,
                              bottomLeft: progressWidth <= 0 ? Radius.circular(20) : Radius.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Persentase selesai
                  Text(
                    '${kelas.progress.toInt()} % Selesai',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}