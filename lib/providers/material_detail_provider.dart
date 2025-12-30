import 'package:flutter/material.dart';
import '../models/material_detail_model.dart';

class MaterialDetailProvider extends ChangeNotifier {
  // Data untuk materi "01 - Pengantar User Interface Design"
  final MaterialDetail _pengantarUID = MaterialDetail(
    id: 'm1',
    title: 'Pengantar User Interface Design',
    pertemuan: 'Pertemuan 1',
    description: 'Antarmuka yang dibangun harus memperhatikan prinsip-prinsip desain yang ada. Hal ini diharapkan agar antarmuka yang dibangun bukan hanya menarik secara visual tetapi dengan memperhatikan kaidah-kaidah prinsip desain diharapkan akan mendukung pengguna dalam menggunakan produk secara baik.',
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
      MaterialItem(
        id: '10',
        title: 'Interactive UI Design Quiz',
        type: MaterialItemType.interactive,
        url: 'https://learning.com/quiz/ui-design',
        createdAt: DateTime(2024, 1, 24),
      ),
      MaterialItem(
        id: '11',
        title: 'UI Design Template File',
        type: MaterialItemType.file,
        filePath: 'templates/ui-template.fig',
        createdAt: DateTime(2024, 1, 25),
      ),
    ],
  );

  // Data untuk materi "02 - Konsep User Interface Design"
  final MaterialDetail _konsepUID = MaterialDetail(
    id: 'm2',
    title: 'Konsep User Interface Design',
    pertemuan: 'Pertemuan 2',
    description: 'Konsep dasar User Interface Design akan dipelajari bagaimana membangun sebuah Interaction Design pada antarmuka. Interaction ini sangat penting untuk aplikasi berkomunikasi dengan pengguna. Lalu dipelajari juga poin-poin penting pada interaction design seperti visibility, feedback, limitation, consistency dan affordance. Dan terakhir materi conceptual dan perceptual design interaction akan memberikan gambaran bagaimana bentuk dari Interaction.',
    stats: '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
    items: [
      MaterialItem(
        id: '12',
        title: 'Konsep Dasar Interaction Design',
        type: MaterialItemType.document,
        filePath: 'documents/konsep-interaction-design.pdf',
        createdAt: DateTime(2024, 2, 1),
      ),
      MaterialItem(
        id: '13',
        title: 'Video: Prinsip-prinsip Interaction Design',
        type: MaterialItemType.video,
        url: 'https://youtube.com/watch?v=interaction-design',
        createdAt: DateTime(2024, 2, 2),
      ),
      MaterialItem(
        id: '14',
        title: 'Interactive Quiz - Konsep UI',
        type: MaterialItemType.interactive,
        url: 'https://learning.com/quiz/konsep-ui',
        createdAt: DateTime(2024, 2, 3),
      ),
    ],
  );

  // Data untuk materi "03 - Interaksi pada User Interface Design"
  final MaterialDetail _interaksiUID = MaterialDetail(
    id: 'm3',
    title: 'Interaksi pada User Interface Design',
    pertemuan: 'Pertemuan 3',
    description: 'Materi tentang berbagai pola interaksi pada antarmuka pengguna.',
    stats: '3 URLs, 2 Files, 3 Interactive Content',
    items: [
      MaterialItem(
        id: '15',
        title: 'Patterns of Interaction Design',
        type: MaterialItemType.document,
        filePath: 'documents/interaction-patterns.pdf',
        createdAt: DateTime(2024, 2, 10),
      ),
      MaterialItem(
        id: '16',
        title: 'Interactive Demo - UI Patterns',
        type: MaterialItemType.interactive,
        url: 'https://learning.com/demo/ui-patterns',
        createdAt: DateTime(2024, 2, 11),
      ),
    ],
  );

  // Getter untuk materi
  MaterialDetail get pengantarUID => _pengantarUID;
  MaterialDetail get konsepUID => _konsepUID;
  MaterialDetail get interaksiUID => _interaksiUID;

  // Method untuk mendapatkan materi berdasarkan ID
  MaterialDetail getMaterialDetailById(String id) {
    switch (id) {
      case 'm1':
        return _pengantarUID;
      case 'm2':
        return _konsepUID;
      case 'm3':
        return _interaksiUID;
      default:
        return _pengantarUID; // Default fallback
    }
  }

  // Method untuk mendapatkan semua materi
  List<MaterialDetail> getAllMaterialDetails() {
    return [_pengantarUID, _konsepUID, _interaksiUID];
  }
}