class Tugas {
  final String id;
  final String mataKuliah;
  final String judulTugas;
  final String deskripsi;
  final String deadline;
  final bool isCompleted;
  final String iconPath;

  Tugas({
    required this.id,
    required this.mataKuliah,
    required this.judulTugas,
    required this.deskripsi,
    required this.deadline,
    this.isCompleted = false,
    required this.iconPath,
  });
}