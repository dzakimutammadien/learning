import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tugas_detail_model.dart';
import '../providers/tugas_detail_provider.dart';
import '../utils/app_colors.dart';

class TugasDetailScreen extends StatefulWidget {
  final String tugasId;

  const TugasDetailScreen({
    Key? key,
    required this.tugasId,
  }) : super(key: key);

  @override
  _TugasDetailScreenState createState() => _TugasDetailScreenState();
}

class _TugasDetailScreenState extends State<TugasDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final tugasProvider = Provider.of<TugasDetailProvider>(context);
    final tugas = tugasProvider.getTugasDetailById(widget.tugasId);

    return Scaffold(
      body: Stack(
        children: [
          // Background merah di atas
          Container(
            height: 307,
            width: double.infinity,
            color: const Color(0xFFB74848),
          ),

          // Konten utama
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar dengan back button
                Container(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 16,
                    right: 16,
                    bottom: 20,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 36,
                          height: 37,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          tugas.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Deskripsi tugas
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tugas.description,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Info status tugas (panel bawah)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 40),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header status
                      Container(
                        height: 37,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEA6262),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Status Tugas',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Detail status
                      _buildStatusRow('Status', 'Sudah Mengirim untuk di nilai'),
                      const Divider(height: 1, color: Colors.grey),
                      _buildStatusRow('Status Nilai', 'Belum Dinilai'),
                      const Divider(height: 1, color: Colors.grey),
                      _buildStatusRow(
                        'Batas tanggal',
                        _formatDateTime(tugas.deadline),
                      ),
                      const Divider(height: 1, color: Colors.grey),
                      _buildStatusRow('Sisa Waktu', 'Tugas sudah di kirim 4 Hari 6 Jam Sebelumnya'),
                      const Divider(height: 1, color: Colors.grey),

                      // File Tugas
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'File Tugas',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 20,
                              height: 18,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/document_icon.png'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Dandy Candra Pratama_7708170114.pdf',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w300,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Lampiran tugas (items)
                      if (tugas.items.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            'Lampiran',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        ...tugas.items.map((item) {
                          return _buildAttachmentItem(item, context);
                        }).toList(),
                      ],

                      const SizedBox(height: 20),

                      // Tombol Tambahkan Tugas
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman upload file menggunakan route
                            Navigator.pushNamed(
                              context,
                              '/upload-file',
                              arguments: {
                                'tugasId': tugas.id,
                                'tugasTitle': tugas.title,
                              },
                            );
                          },
                          child: Container(
                            width: 97,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                            ),
                            child: const Center(
                              child: Text(
                                'Tambahkan Tugas',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      color: Colors.white,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w300,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(TugasItem item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Jika item adalah file PDF
        if (item.filePath != null) {
          // Buka document viewer
          Navigator.pushNamed(
            context,
            '/document-viewer',
            arguments: {
              'title': item.title,
              'type': 'pdf',
              'filePath': item.filePath,
            },
          );
        }
        // Jika item adalah URL
        else if (item.url != null) {
          // TODO: Buka URL di browser
          print('Opening URL: ${item.url}');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
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
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    
    final dayName = days[dateTime.weekday - 1];
    return '$dayName, ${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} WIB';
  }
}