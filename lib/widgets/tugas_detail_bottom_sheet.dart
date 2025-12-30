import 'package:flutter/material.dart';
import '../models/tugas_detail_model.dart';
import '../utils/app_colors.dart';

class TugasDetailBottomSheet extends StatelessWidget {
  final TugasDetail tugasDetail;

  const TugasDetailBottomSheet({
    Key? key,
    required this.tugasDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 10, bottom: 20),
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

          // Judul
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              tugasDetail.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 8),

          // Info deadline
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _getStatusColor(tugasDetail.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: _getStatusColor(tugasDetail.status),
                ),
                const SizedBox(width: 8),
                Text(
                  'Tenggat: ${_formatDateTime(tugasDetail.deadline)}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _getStatusColor(tugasDetail.status),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(tugasDetail.status),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _getStatusText(tugasDetail.status),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Deskripsi
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Deskripsi tugas
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
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
                          tugasDetail.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.black,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Lampiran
                  if (tugasDetail.items.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lampiran',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...tugasDetail.items.map((item) {
                          return _buildAttachmentItem(item);
                        }).toList(),
                      ],
                    ),

                  const SizedBox(height: 20),

                  // Tombol Aksi
                  if (tugasDetail.status != TugasStatus.selesai)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigasi ke halaman pengerjaan tugas/kuis
                              print('Mulai mengerjakan: ${tugasDetail.title}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryRed,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              tugasDetail.type == TugasType.kuis 
                                ? 'Mulai Kuis' 
                                : 'Kerjakan Tugas',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(TugasItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            item.filePath != null ? Icons.description : Icons.link,
            color: AppColors.primaryRed,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              // Handle open file/link
              if (item.url != null) {
                print('Opening URL: ${item.url}');
              } else if (item.filePath != null) {
                print('Opening file: ${item.filePath}');
              }
            },
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

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}