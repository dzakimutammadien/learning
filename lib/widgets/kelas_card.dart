import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class KelasCard extends StatelessWidget {
  final Map<String, dynamic> kelas;

  const KelasCard({
    Key? key,
    required this.kelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 319,
      height: 140,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          // Gambar/Icon Kelas
          Container(
            width: 106,
            height: 140,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.school,
              size: 50,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tahun Ajaran
                Text(
                  '${kelas['tahunAjaran']}/${kelas['tahunAjaran'] + 1}',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                // Nama Mata Kuliah & Dosen
                Text(
                  '${kelas['namaMataKuliah']} ${kelas['kodeKelas']} [${kelas['dosen']}]',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                // Progress Bar
                Stack(
                  children: [
                    // Background bar
                    Container(
                      width: 197,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAF1116),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                            spreadRadius: -4,
                          ),
                        ],
                      ),
                    ),
                    // Progress fill
                    Positioned(
                      right: 0,
                      child: Container(
                        width: (197 * (1 - kelas['progress'] / 100)).toDouble(),
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomLeft: Radius.circular(0),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              spreadRadius: -4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Progress Text
                Text(
                  '${kelas['progress'].toInt()} % Selesai',
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
    );
  }
}