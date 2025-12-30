import 'package:flutter/material.dart';
import '../models/material_detail_model.dart';

class MaterialDetailProvider extends ChangeNotifier {
  // Data untuk materi "01 - Pengantar User Interface Design"
  final MaterialDetail _pengantarUID = MaterialDetail(
    id: 'm1',
    title: 'Pengantar User Interface Design',
    pertemuan: 'Pertemuan 1',
    description: 'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik. Pelajaran mengenai prinsip UID ini sudah pernah diajarkan dalam mata kuliah Implementasi Desain Antarmuka Pengguna tetap pada matakuliah ini akan direview kembali sehingga dapat menjadi bekal saat memasukki materi mengenai User Experience',
    stats: '3 URLs, 2 Files, 3 Interactive Content',
    items: [
      MaterialItem(
        id: '1',
        title: 'Zoom Meeting Syncronous',
        type: MaterialItemType.link,
        url: 'https://zoom.us/j/123456789',
        createdAt: DateTime(2024, 1, 15),
      ),
      MaterialItem(
        id: '2',
        title: 'Pengantar User Interface Design',
        type: MaterialItemType.document,
        filePath: 'documents/uid-pengantar.pdf',
        createdAt: DateTime(2024, 1, 16),
      ),
      MaterialItem(
        id: '3',
        title: 'Empat Teori Dasar Antarmuka Pengguna',
        type: MaterialItemType.document,
        filePath: 'documents/teori-dasar.pdf',
        createdAt: DateTime(2024, 1, 17),
      ),
      MaterialItem(
        id: '4',
        title: 'Empat Teori Dasar Antarmuka Pengguna',
        type: MaterialItemType.document,
        filePath: 'documents/teori-dasar-2.pdf',
        createdAt: DateTime(2024, 1, 18),
      ),
      MaterialItem(
        id: '5',
        title: 'User Interface Design for Beginner',
        type: MaterialItemType.video,
        url: 'https://youtube.com/watch?v=abc123',
        createdAt: DateTime(2024, 1, 19),
      ),
      MaterialItem(
        id: '6',
        title: '20 Prinsip Desain',
        type: MaterialItemType.link,
        url: 'https://prinsip-desain.com',
        createdAt: DateTime(2024, 1, 20),
      ),
      MaterialItem(
        id: '7',
        title: 'Best Practice UI Design',
        type: MaterialItemType.link,
        url: 'https://ui-best-practice.com',
        createdAt: DateTime(2024, 1, 21),
      ),
      MaterialItem(
        id: '8',
        title: 'Pengantar Desain Antarmuka Pengguna',
        type: MaterialItemType.video,
        url: 'https://youtube.com/watch?v=def456',
        createdAt: DateTime(2024, 1, 22),
      ),
      MaterialItem(
        id: '9',
        title: '4 Teori Dasar Desain Antarmuka Pengguna',
        type: MaterialItemType.video,
        url: 'https://youtube.com/watch?v=ghi789',
        createdAt: DateTime(2024, 1, 23),
      ),
    ],
  );

  // Data untuk materi "02 - UX Research"
  final MaterialDetail _uxResearch = MaterialDetail(
    id: 'm2',
    title: 'UX Research',
    pertemuan: 'Pertemuan 2',
    description: 'UX Research adalah proses memahami pengguna, kebutuhan mereka, dan konteks penggunaannya. Penelitian UX membantu tim desain dan produk membuat keputusan berbasis data.',
    stats: '2 URLs, 3 Documents, 1 Video',
    items: [
      MaterialItem(
        id: '10',
        title: 'Introduction to UX Research',
        type: MaterialItemType.document,
        filePath: 'documents/ux-research-intro.pdf',
        createdAt: DateTime(2024, 2, 1),
      ),
      MaterialItem(
        id: '11',
        title: 'UX Research Methods',
        type: MaterialItemType.video,
        url: 'https://youtube.com/watch?v=jkl012',
        createdAt: DateTime(2024, 2, 2),
      ),
    ],
  );

  // Getter untuk materi
  MaterialDetail get pengantarUID => _pengantarUID;
  MaterialDetail get uxResearch => _uxResearch;

  // Method untuk mendapatkan materi berdasarkan ID
  MaterialDetail getMaterialDetailById(String id) {
    switch (id) {
      case 'm1':
        return _pengantarUID;
      case 'm2':
        return _uxResearch;
      default:
        return _pengantarUID; // Default fallback
    }
  }

  // Method untuk mendapatkan semua materi
  List<MaterialDetail> getAllMaterialDetails() {
    return [_pengantarUID, _uxResearch];
  }
}