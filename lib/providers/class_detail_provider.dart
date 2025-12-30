import 'package:flutter/material.dart';
import '../models/class_detail_model.dart';
import '../models/class_content_model.dart';

class ClassDetailProvider extends ChangeNotifier {
  // Data detail kelas UI/UX
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
      materialId: 'm1', // Hubungkan dengan MaterialDetail
    ),
    ClassContent(
      id: 'm2',
      title: '02 - Konsep User Interface Design',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 2',
      deskripsi: '2 URLs, 1 Kuis, 3 Files, 1 Tugas',
      materialId: 'm2',
    ),
    ClassContent(
      id: 'm3',
      title: '03 - Interaksi pada User Interface Design',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 3',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
      materialId: 'm3',
    ),
    ClassContent(
      id: 'm4',
      title: '04 - Ethnographic Observation',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 4',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
      materialId: 'm4',
    ),
    ClassContent(
      id: 'm5',
      title: '05 - UID Testing',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 5',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
      materialId: 'm5',
    ),
    ClassContent(
      id: 'm6',
      title: '06 - Assessment 1',
      type: ContentType.materi,
      pertemuan: 'Pertemuan 6',
      deskripsi: '3 URLs, 2 Files, 3 Interactive Content',
      materialId: 'm6',
    ),
  ];

  // Data tugas & kuis untuk kelas UI/UX - INI YANG DITAMPILKAN DI TAB "TUGAS & KUIS"
  final List<ClassContent> _uiUxAssignments = [
    ClassContent(
      id: 'a1',
      title: 'Quiz Review 01',
      type: ContentType.kuis,
      pertemuan: 'QUIZ',
      deskripsi: 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
      iconUrl: 'assets/images/quiz.png',
      tugasId: 'a1', // Hubungkan dengan TugasDetail
    ),
    ClassContent(
      id: 'a2',
      title: 'Tugas 01 - UID Android Mobile Game',
      type: ContentType.tugas,
      pertemuan: 'Tugas',
      deskripsi: 'Tenggat Waktu : 26 Februari 2021 23:59 WIB',
      iconUrl: 'assets/images/checklist.png',
      tugasId: 'a2',
    ),
    ClassContent(
      id: 'a3',
      title: 'Kuis - Assessment 2',
      type: ContentType.kuis,
      pertemuan: 'Pertemuan 3',
      deskripsi: 'Tenggat Waktu : 5 Maret 2021 23:59 WIB',
      iconUrl: 'assets/images/quiz.png',
      tugasId: 'a3',
    ),
    // Tambahkan tugas dari materi pertemuan 2
    ClassContent(
      id: 'a4',
      title: 'Tugas - Konsep UI Design',
      type: ContentType.tugas,
      pertemuan: 'Pertemuan 2',
      deskripsi: 'Buat konsep desain untuk aplikasi mobile',
      iconUrl: 'assets/images/checklist.png',
      tugasId: 'a4',
    ),
    // Tambahan tugas lainnya
    ClassContent(
      id: 'a5',
      title: 'Quiz - Prinsip Desain',
      type: ContentType.kuis,
      pertemuan: 'QUIZ',
      deskripsi: 'Tenggat Waktu : 12 Maret 2021 23:59 WIB',
      iconUrl: 'assets/images/quiz.png',
      tugasId: 'a5',
    ),
  ];

  ClassDetail get uiUxClass => _uiUxClass;
  List<ClassContent> get uiUxMaterials => _uiUxMaterials;
  List<ClassContent> get uiUxAssignments => _uiUxAssignments;

  // Method untuk mendapatkan detail kelas berdasarkan ID
  ClassDetail getClassDetailById(String id) {
    // Untuk sekarang hanya return UI/UX class
    return _uiUxClass;
  }

  // Method untuk mendapatkan materi berdasarkan kelas ID
  List<ClassContent> getMaterialsByClassId(String classId) {
    return _uiUxMaterials;
  }

  // Method untuk mendapatkan tugas berdasarkan kelas ID
  List<ClassContent> getAssignmentsByClassId(String classId) {
    return _uiUxAssignments;
  }

  // Method untuk mendapatkan ClassContent berdasarkan ID
  ClassContent? getClassContentById(String id) {
    // Cari di materi
    final material = _uiUxMaterials.firstWhere(
      (element) => element.id == id,
      orElse: () => ClassContent(
        id: '',
        title: '',
        type: ContentType.materi,
        pertemuan: '',
        deskripsi: '',
      ),
    );
    
    if (material.id.isNotEmpty) return material;
    
    // Cari di assignments
    final assignment = _uiUxAssignments.firstWhere(
      (element) => element.id == id,
      orElse: () => ClassContent(
        id: '',
        title: '',
        type: ContentType.tugas,
        pertemuan: '',
        deskripsi: '',
      ),
    );
    
    if (assignment.id.isNotEmpty) return assignment;
    
    return null;
  }
}