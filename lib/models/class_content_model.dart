enum ContentType {
  materi,
  tugas,
  kuis,
}

class ClassContent {
  final String id;
  final String title;
  final ContentType type;
  final String pertemuan;
  final String deskripsi;
  final String? iconUrl;
  final String? materialId; // ID untuk detail materi (jika type = materi)
  final String? tugasId; // ID untuk detail tugas (jika type = tugas/kuis)

  ClassContent({
    required this.id,
    required this.title,
    required this.type,
    required this.pertemuan,
    required this.deskripsi,
    this.iconUrl,
    this.materialId,
    this.tugasId,
  });
}