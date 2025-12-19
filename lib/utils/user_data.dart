import '../models/user_model.dart';

class UserData {
  // Data user dummy (sesuai login)
  static User currentUser = User(
    id: '1',
    firstName: 'DANDY CANDRA',
    lastName: 'PRATAMA',
    email: 'dandycandra@365.telkomuniversity.ac.id',
    role: 'MAHASISWA',
    programStudi: 'D4 Teknologi Rekayasa Multimedia',
    fakultas: 'Fakultas FIT',
    firstAccess: 'Monday, 7 September 2020, 9:27 AM (288 days 12 hours)',
    lastAccess: 'Tuesday, 22 June 2021, 9:44 PM (now)',
  );

  // Data kelas user
  static final List<Map<String, dynamic>> userClasses = [
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