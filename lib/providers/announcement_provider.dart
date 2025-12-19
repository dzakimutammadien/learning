import 'package:flutter/material.dart';
import '../models/announcement_model.dart';

class AnnouncementProvider extends ChangeNotifier {
  final List<Announcement> _announcements = [
    Announcement(
      id: '1',
      title: 'Maintenance Pra UAS Semester Genap 2020/2021',
      author: 'Admin Celoe',
      date: 'Rabu, 2 Juni 2021, 10:45',
      content: 'Diinformasikan kepada seluruh pengguna LMS, kami dari tim CeLOE akan melakukan maintenance pada tanggal 12 Juni 2021, untuk meningkatkan layanan server dalam menghadapi ujian akhir semester (UAS). Dengan adanya kegiatan maintenance tersebut maka situs LMS (lms.telkomuniversity.ac.id) tidak dapat diakses mulai pukul 00.00 s/d 06.00 WIB. Demikian informasi ini kami sampaikan, mohon maaf atas ketidaknyamanannya.\n\nHormat Kami,\nCeLOE Telkom University',
      thumbnailUrl: 'assets/images/announcement_icon.png',
      imageUrl: 'assets/images/announcement_banner.png',
    ),
    Announcement(
      id: '2',
      title: 'Pengumuman Maintenance',
      author: 'Admin Celoe',
      date: 'Senin, 11 Januari 2021, 7:52',
      content: 'Dalam rangka meningkatkan kualitas layanan, akan dilakukan maintenance sistem LMS pada tanggal 15 Januari 2021 pukul 00:00 - 04:00 WIB. Selama maintenance berlangsung, sistem tidak dapat diakses.',
      thumbnailUrl: 'assets/images/announcement_icon.png',
      imageUrl: null,
    ),
    Announcement(
      id: '3',
      title: 'Maintenance Pra UAS Semester Ganjil 2020/2021',
      author: 'Admin Celoe',
      date: 'Minggu, 10 Januari 2021, 9:30',
      content: 'Persiapan UAS Semester Ganjil 2020/2021 memerlukan update sistem. Maintenance akan dilakukan pada tanggal 13 Januari 2021.',
      thumbnailUrl: 'assets/images/announcement_icon.png',
      imageUrl: null,
    ),
  ];

  List<Announcement> get announcements => _announcements;

  Announcement getAnnouncementById(String id) {
    try {
      return _announcements.firstWhere((ann) => ann.id == id);
    } catch (e) {
      // Fallback jika tidak ditemukan
      return _announcements.first;
    }
  }
}