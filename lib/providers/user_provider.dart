import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User _currentUser = User(
    id: '1',
    firstName: 'DANDY CANDRA',
    lastName: 'PRATAMA',
    email: 'dandycandra@365.telkomuniversity.ac.id',
    role: 'MAHASISWA',
    programStudi: 'D4 Teknologi Rekayasa Multimedia',
    fakultas: 'Fakultas FIT',
    firstAccess: 'Monday, 7 September 2020, 9:27 AM (288 days 12 hours)',
    lastAccess: 'Tuesday, 22 June 2021, 9:44 PM (now)',
    description: 'Mahasiswa D4 Teknologi Rekayasa Multimedia, Fakultas FIT',
  );

  User get currentUser => _currentUser;

  // Update user data and notify all listeners
  void updateUser({
    String? firstName,
    String? lastName,
    String? email,
    String? programStudi,
    String? fakultas,
    String? description,
     String? photoUrl,
  }) {
    _currentUser = User(
      id: _currentUser.id,
      firstName: firstName ?? _currentUser.firstName,
      lastName: lastName ?? _currentUser.lastName,
      email: email ?? _currentUser.email,
      role: _currentUser.role,
      programStudi: programStudi ?? _currentUser.programStudi,
      fakultas: fakultas ?? _currentUser.fakultas,
      firstAccess: _currentUser.firstAccess,
      lastAccess: '${DateTime.now()} (now)',
      description: description ?? _currentUser.description,
      photoUrl: photoUrl ?? _currentUser.photoUrl,
    );
    notifyListeners(); // This will update ALL screens listening to this provider
  }

  // Get user classes (static data for now)
  List<Map<String, dynamic>> get userClasses => [
    {
      'id': '1',
      'kodeKelas': 'D4SM-41-GAB1 [ARS]',
      'namaMataKuliah': 'BAHASA INGGRIS: BUSINESS AND SCIENTIFIC',
      'dosen': 'ARS',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '2',
      'kodeKelas': 'D4SM-42-03 [ADY]',
      'namaMataKuliah': 'DESAIN ANTARMUKA & PENGALAMAN PENGGUNA',
      'dosen': 'ADY',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '3',
      'kodeKelas': 'D4SM-41-GAB1 [BBO]',
      'namaMataKuliah': 'KEWARGANEGARAAN',
      'dosen': 'BBO',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '4',
      'kodeKelas': 'D4SM-43-04 [TPR]',
      'namaMataKuliah': 'PEMROGRAMAN MULTIMEDIA INTERAKTIF',
      'dosen': 'TPR',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '5',
      'kodeKelas': 'D4SM-41-GAB1 [APJ]',
      'namaMataKuliah': 'PEMROGRAMAN PERANGKAT BERGERAK MULTIMEDIA',
      'dosen': 'APJ',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '6',
      'kodeKelas': 'D4SM-44-02 [DDS]',
      'namaMataKuliah': 'SISTEM OPERASI',
      'dosen': 'DDS',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
    {
      'id': '7',
      'kodeKelas': 'D3TT-44-02 [EYR]',
      'namaMataKuliah': 'OLAHRAGA',
      'dosen': 'EYR',
      'tanggalMulai': 'Monday, 8 February 2021',
      'color': 0xFF83B8DA,
    },
  ];
}