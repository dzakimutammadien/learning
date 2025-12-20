class ClassDetail {
  final String id;
  final String kodeKelas;
  final String namaMataKuliah;
  final String dosen;
  final double progress;
  final String imageUrl;
  final int jumlahMurid;
  final String deskripsi;

  ClassDetail({
    required this.id,
    required this.kodeKelas,
    required this.namaMataKuliah,
    required this.dosen,
    required this.progress,
    required this.imageUrl,
    this.jumlahMurid = 31,
    required this.deskripsi,
  });
}