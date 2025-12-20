class ClassItem {
  final String id;
  final String kodeKelas;
  final String namaMataKuliah;
  final String dosen;
  final double progress;
  final int tahunAjaran;
  final String semester;
  final String imageUrl;
  final String tahunSemester; // Format: "2021/2"

  ClassItem({
    required this.id,
    required this.kodeKelas,
    required this.namaMataKuliah,
    required this.dosen,
    required this.progress,
    required this.tahunAjaran,
    required this.semester,
    required this.imageUrl,
    required this.tahunSemester,
  });
}