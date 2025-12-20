import 'package:flutter/material.dart';
import '../models/class_model.dart';

class ClassProvider extends ChangeNotifier {
  final List<ClassItem> _myClasses = [
    ClassItem(
      id: '1',
      kodeKelas: 'D4SM-42-03 [ADY]',
      namaMataKuliah: 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
      dosen: 'ADY',
      progress: 89.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/uiux.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '2',
      kodeKelas: 'D4SM-41-GAB1 [BBO]',
      namaMataKuliah: 'KEWARGANEGARAAN',
      dosen: 'BBO',
      progress: 86.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/INLIS000000000011050.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '3',
      kodeKelas: 'D4SM-44-02 [DDS]',
      namaMataKuliah: 'SISTEM OPERASI',
      dosen: 'DDS',
      progress: 90.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/operatingsystem-min1.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '4',
      kodeKelas: 'D4SM-41-GAB1 [APJ]',
      namaMataKuliah: 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA',
      dosen: 'APJ',
      progress: 90.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/mobile_programming.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '5',
      kodeKelas: 'D4SM-41-GAB1 [ARS]',
      namaMataKuliah: 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC',
      dosen: 'ARS',
      progress: 90.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/english.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '6',
      kodeKelas: 'D4SM-43-04 [TPR]',
      namaMataKuliah: 'PEMROGRAMAN MULTIMEDIA INTERAKTIF',
      dosen: 'TPR',
      progress: 90.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/multimedia.png',
      tahunSemester: '2021/2',
    ),
    ClassItem(
      id: '7',
      kodeKelas: 'D3TT-44-02 [EYR]',
      namaMataKuliah: 'OLAHRAGA',
      dosen: 'EYR',
      progress: 90.0,
      tahunAjaran: 2021,
      semester: '2',
      imageUrl: 'assets/images/sports.png',
      tahunSemester: '2021/2',
    ),
  ];

  List<ClassItem> get myClasses => _myClasses;

  ClassItem getClassById(String id) {
    return _myClasses.firstWhere((kelas) => kelas.id == id);
  }
}