import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class UploadFileScreen extends StatefulWidget {
  final String tugasId;
  final String tugasTitle;

  const UploadFileScreen({
    Key? key,
    required this.tugasId,
    required this.tugasTitle,
  }) : super(key: key);

  @override
  _UploadFileScreenState createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    // TODO: Implement file picker menggunakan package file_picker
    // Untuk sekarang, kita simulasi dengan file dummy
    setState(() {
      _selectedFile = File('/path/to/dummy/file.pdf');
      _fileName = 'Tugas_${widget.tugasTitle.replaceAll(' ', '_')}.pdf';
    });
  }

  void _saveFile() {
    if (_selectedFile != null) {
      // TODO: Implement save/upload logic
      print('Uploading file: $_fileName for tugas: ${widget.tugasId}');
      
      // Kembali ke halaman sebelumnya dengan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('File berhasil diupload!'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih file terlebih dahulu!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Column(
            children: [
              // App Bar
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
                    const Expanded(
                      child: Text(
                        'Upload File',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Konten upload
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Drag indicator
                      Container(
                        width: 109,
                        height: 6,
                        margin: const EdgeInsets.only(top: 6, bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC4C4C4).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),

                      const Text(
                        'Maksimum File 5MB , Maksimum Jumlah File 20',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Area upload
                      Container(
                        width: 336,
                        height: 202,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Container(
                          width: 320,
                          height: 188,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                              style: BorderStyle.solid, // Ubah dari dashed ke solid
                            ),
                          ),
                          child: _selectedFile != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Ikon file placeholder
                                    Container(
                                      width: 201,
                                      height: 101,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.picture_as_pdf,
                                        size: 50,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      _fileName ?? 'File terpilih',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Placeholder icon
                                    Container(
                                      width: 201,
                                      height: 101,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.cloud_upload,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'File yang akan di upload akan tampil di sini',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w300,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Tombol Pilih File
                      GestureDetector(
                        onTap: _pickFile,
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
                              'Pilih File',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Tombol Simpan
                      GestureDetector(
                        onTap: _saveFile,
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
                              'Simpan',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}