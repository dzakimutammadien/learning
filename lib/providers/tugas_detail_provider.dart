import 'package:flutter/material.dart';
import '../models/tugas_detail_model.dart';

class TugasDetailProvider extends ChangeNotifier {
  // Data untuk "Quiz Review 01"
  final TugasDetail _quizReview01 = TugasDetail(
    id: 'a1',
    title: 'Quiz Review 01',
    type: TugasType.kuis,
    pertemuan: 'QUIZ',
    description: 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan. Kerjakan sebelum hari Jum\'at, 26 Februari 2021 jam 23:59 WIB.',
    deadline: DateTime(2021, 2, 26, 23, 59),
    createdAt: DateTime(2021, 2, 20),
    status: TugasStatus.belumDikerjakan,
    items: [
      TugasItem(
        id: 'q1',
        title: 'Link Kuis - Quiz Review 01',
        url: 'https://e-learning.ittelkom-sby.ac.id/quiz/123',
        createdAt: DateTime(2021, 2, 20),
      ),
    ],
  );

  // Data untuk "Tugas 01 - UID Android Mobile Game"
  final TugasDetail _tugas01 = TugasDetail(
    id: 'a2',
    title: 'Tugas 01 - UID Android Mobile Game',
    type: TugasType.tugas,
    pertemuan: 'Tugas',
    description: '1. Buatlah desain tampilan (antarmuka) pada aplikasi mobile game FPS (First Person Shooter) yang akan menjadi tugas pada mata kuliah Pemrograman Aplikasi Permainan.\n\n2. Desain yang dibuat harus melingkupi seluruh tampilan pada aplikasi/game, dari pertama kali aplikasi dibuka hingga selesai bermain.\n\n3. Desain harus memperhatikan prinsip-prinsip desain antarmuka yang telah dipelajari.',
    deadline: DateTime(2021, 2, 26, 23, 59),
    createdAt: DateTime(2021, 2, 21),
    status: TugasStatus.dalamPengerjaan,
    instruksiFile: 'documents/tugas-01-instructions.pdf',
    submissionUrl: 'https://e-learning.ittelkom-sby.ac.id/submission/456',
    items: [
      TugasItem(
        id: 't1',
        title: 'Instruksi Tugas 01',
        filePath: 'documents/tugas-01-instructions.pdf',
        createdAt: DateTime(2021, 2, 21),
      ),
      TugasItem(
        id: 't2',
        title: 'Contoh Desain Game FPS',
        url: 'https://dribbble.com/game-fps-examples',
        createdAt: DateTime(2021, 2, 21),
      ),
    ],
  );

  // Data untuk "Kuis - Assessment 2"
  final TugasDetail _kuisAssessment2 = TugasDetail(
    id: 'a3',
    title: 'Kuis - Assessment 2',
    type: TugasType.kuis,
    pertemuan: 'Pertemuan 3',
    description: 'Kuis ini meliputi materi dari pertemuan 1 hingga 3. Waktu pengerjaan 30 menit. Pastikan koneksi internet stabil sebelum memulai.',
    deadline: DateTime(2021, 3, 5, 23, 59),
    createdAt: DateTime(2021, 2, 27),
    status: TugasStatus.belumDikerjakan,
    items: [
      TugasItem(
        id: 'q2',
        title: 'Link Kuis - Assessment 2',
        url: 'https://e-learning.ittelkom-sby.ac.id/quiz/789',
        createdAt: DateTime(2021, 2, 27),
      ),
    ],
  );

  // Data untuk "Tugas - Konsep UI Design" (dari materi pertemuan 2)
  final TugasDetail _tugasKonsepUI = TugasDetail(
    id: 'a4',
    title: 'Tugas - Konsep UI Design',
    type: TugasType.tugas,
    pertemuan: 'Pertemuan 2',
    description: 'Buat konsep desain antarmuka untuk aplikasi mobile banking dengan memperhatikan prinsip-prinsip desain yang telah dipelajari. Fokus pada aspek usability dan user experience.',
    deadline: DateTime(2021, 3, 10, 23, 59),
    createdAt: DateTime(2021, 2, 28),
    status: TugasStatus.belumDikerjakan,
    instruksiFile: 'documents/tugas-konsep-ui.pdf',
    submissionUrl: 'https://e-learning.ittelkom-sby.ac.id/submission/789',
    items: [
      TugasItem(
        id: 't3',
        title: 'Instruksi Tugas Konsep UI',
        filePath: 'documents/tugas-konsep-ui.pdf',
        createdAt: DateTime(2021, 2, 28),
      ),
      TugasItem(
        id: 't4',
        title: 'Template Wireframe',
        filePath: 'documents/wireframe-template.fig',
        createdAt: DateTime(2021, 2, 28),
      ),
    ],
  );

  // Data untuk "Quiz - Prinsip Desain"
  final TugasDetail _quizPrinsipDesain = TugasDetail(
    id: 'a5',
    title: 'Quiz - Prinsip Desain',
    type: TugasType.kuis,
    pertemuan: 'QUIZ',
    description: 'Kuis tentang prinsip-prinsip desain antarmuka yang telah dipelajari pada pertemuan 1-4.',
    deadline: DateTime(2021, 3, 12, 23, 59),
    createdAt: DateTime(2021, 3, 1),
    status: TugasStatus.belumDikerjakan,
    items: [
      TugasItem(
        id: 'q3',
        title: 'Link Quiz Prinsip Desain',
        url: 'https://e-learning.ittelkom-sby.ac.id/quiz/101112',
        createdAt: DateTime(2021, 3, 1),
      ),
    ],
  );

  // Getter untuk tugas
  TugasDetail get quizReview01 => _quizReview01;
  TugasDetail get tugas01 => _tugas01;
  TugasDetail get kuisAssessment2 => _kuisAssessment2;
  TugasDetail get tugasKonsepUI => _tugasKonsepUI;
  TugasDetail get quizPrinsipDesain => _quizPrinsipDesain;

  // Method untuk mendapatkan tugas berdasarkan ID
  TugasDetail getTugasDetailById(String id) {
    switch (id) {
      case 'a1':
        return _quizReview01;
      case 'a2':
        return _tugas01;
      case 'a3':
        return _kuisAssessment2;
      case 'a4':
        return _tugasKonsepUI;
      case 'a5':
        return _quizPrinsipDesain;
      default:
        return _quizReview01;
    }
  }

  // Method untuk mendapatkan semua tugas
  List<TugasDetail> getAllTugasDetails() {
    return [
      _quizReview01,
      _tugas01,
      _kuisAssessment2,
      _tugasKonsepUI,
      _quizPrinsipDesain,
    ];
  }

  // Method untuk update status tugas
  void updateTugasStatus(String id, TugasStatus newStatus) {
    // Implementasi update status jika diperlukan
    notifyListeners();
  }
}