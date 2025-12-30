import 'package:flutter/material.dart';

enum TugasType {
  tugas,
  kuis,
}

enum TugasStatus {
  belumDikerjakan,
  dalamPengerjaan,
  selesai,
  terlambat,
}

class TugasDetail {
  final String id;
  final String title;
  final TugasType type;
  final String pertemuan;
  final String description;
  final DateTime deadline;
  final DateTime createdAt;
  final TugasStatus status;
  final int? nilai; // null jika belum dinilai
  final String? instruksiFile; // path file instruksi
  final String? submissionUrl; // URL untuk submit tugas
  final List<TugasItem> items;

  TugasDetail({
    required this.id,
    required this.title,
    required this.type,
    required this.pertemuan,
    required this.description,
    required this.deadline,
    required this.createdAt,
    required this.status,
    this.nilai,
    this.instruksiFile,
    this.submissionUrl,
    required this.items,
  });
}

class TugasItem {
  final String id;
  final String title;
  final String? filePath;
  final String? url;
  final DateTime createdAt;

  TugasItem({
    required this.id,
    required this.title,
    this.filePath,
    this.url,
    required this.createdAt,
  });
}