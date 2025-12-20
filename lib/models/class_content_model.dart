enum ContentType { materi, tugas, kuis }

class ClassContent {
  final String id;
  final String title;
  final ContentType type;
  final String pertemuan;
  final String deskripsi;
  final String deadline;
  final String? iconUrl;

  ClassContent({
    required this.id,
    required this.title,
    required this.type,
    required this.pertemuan,
    required this.deskripsi,
    this.deadline = '',
    this.iconUrl,
  });
}