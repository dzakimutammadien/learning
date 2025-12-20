import 'package:flutter/material.dart';
import '../models/class_detail_model.dart';
import '../models/class_content_model.dart';

class ClassDetailProvider extends ChangeNotifier {
  // Data detail kelas UI/UX (contoh untuk kelas pertama)
  final ClassDetail _uiUxClass = ClassDetail(
    id: '1',
    kodeKelas: 'D4SM-42-03 [ADY]',
    namaMataKuliah: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
    dosen: 'ADY',
    progress: 89.0,
    imageUrl: 'assets/images/uiux.png',
    jumlahMurid: 31,
    deskripsi: 'Mata kuliah tentang prinsip-prinsip desain antarmuka dan pengalaman pengguna',
  );

  // Data materi untuk kelas UI/UX
  final List<ClassContent> _uiUxMaterials = [
    ClassContent(
      id: 'm1',
      title: '01 - Pengantar User Interface Design',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 1',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
    ),
    ClassContent(
      id: 'm2',
      title: '02 - Konsep User Interface Design',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 2',
      deskripsi: '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
    ),
    ClassContent(
      id: 'm3',
      title: '03 - Interaksi pada User Interface Design',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 3',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
    ),
    ClassContent(
      id: 'm4',
      title: '04 - Ethnographic Observation',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 4',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
    ),
    ClassContent(
      id: 'm5',
      title: '05 - UID Testing',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 5',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
    ),
    ClassContent(
      id: 'm6',
      title: '06 - Assessment 1',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 6',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
    ),
  ];

  // Data tugas & kuis untuk kelas UI/UX
  final List<ClassContent> _uiUxAssignments = [
    ClassContent(
      id: 'a1',
      title: 'Quiz Review 01',
      type: ContentType.kuis,
      pertemuan: 'QUIZ',
      deskripsi: 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
      iconUrl: 'assets/images/quiz.png',
    ),
    ClassContent(
      id: 'a2',
      title: 'Tugas 01 - UID Android Mobile Game',
      type: ContentType.tugas,
      pertemuan: 'Tugas',
      deskripsi: 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
      iconUrl: 'assets/images/checklist.png',
    ),
    ClassContent(
      id: 'a3',
      title: 'Kuis - Assessment 2',
      type: ContentType.kuis,
      pertemuan: 'Pertemuan 3',
      deskripsi: 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
      iconUrl: 'assets/images/quiz.png',
    ),
  ];

  ClassDetail get uiUxClass => _uiUxClass;
  List<ClassContent> get uiUxMaterials => _uiUxMaterials;
  List<ClassContent> get uiUxAssignments => _uiUxAssignments;

  // Method untuk mendapatkan detail kelas berdasarkan ID
  ClassDetail getClassDetailById(String id) {
    // Untuk sekarang hanya return UI/UX class
    // Nanti bisa ditambah logic untuk kelas lain
    return _uiUxClass;
  }

  // Method untuk mendapatkan materi berdasarkan kelas ID
  List<ClassContent> getMaterialsByClassId(String classId) {
    // Untuk sekarang hanya return UI/UX materials
    return _uiUxMaterials;
  }

  // Method untuk mendapatkan tugas berdasarkan kelas ID
  List<ClassContent> getAssignmentsByClassId(String classId) {
    // Untuk sekarang hanya return UI/UX assignments
    return _uiUxAssignments;
  }
}