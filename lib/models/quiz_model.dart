import 'package:flutter/material.dart';

enum QuizStatus {
  belumDikerjakan,
  sedangDikerjakan,
  selesai,
  direview,
}

class QuizDetail {
  final String id;
  final String title;
  final String description;
  final DateTime deadline;
  final DateTime createdAt;
  final QuizStatus status;
  final int waktuPengerjaan; // dalam menit
  final int? nilai; // null jika belum dinilai
  final DateTime? mulaiMengerjakan;
  final DateTime? selesaiMengerjakan;
  final List<QuizQuestion> questions;
  final String? submissionUrl;

  QuizDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.createdAt,
    required this.status,
    required this.waktuPengerjaan,
    this.nilai,
    this.mulaiMengerjakan,
    this.selesaiMengerjakan,
    required this.questions,
    this.submissionUrl,
  });

  // Hitung sisa waktu pengerjaan
  Duration? get sisaWaktu {
    if (mulaiMengerjakan == null) return null;
    final totalWaktu = Duration(minutes: waktuPengerjaan);
    final now = DateTime.now();
    final waktuTerpakai = now.difference(mulaiMengerjakan!);
    return totalWaktu - waktuTerpakai;
  }

  // Format waktu untuk tampilan
  String get formattedSisaWaktu {
    final sisa = sisaWaktu;
    if (sisa == null || sisa.isNegative) return '00:00';
    final minutes = sisa.inMinutes;
    final seconds = sisa.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class QuizQuestion {
  final String id;
  final String quizId;
  final int nomor;
  final String pertanyaan;
  final List<QuizOption> options;
  final String? jawabanUser; // id option yang dipilih user
  final String? jawabanBenar; // id option yang benar

  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.nomor,
    required this.pertanyaan,
    required this.options,
    this.jawabanUser,
    this.jawabanBenar,
  });

  // Cek apakah jawaban user benar
  bool get isCorrect {
    if (jawabanUser == null || jawabanBenar == null) return false;
    return jawabanUser == jawabanBenar;
  }
}

class QuizOption {
  final String id;
  final String questionId;
  final String label; // A, B, C, D, E
  final String text;
  
  QuizOption({
    required this.id,
    required this.questionId,
    required this.label,
    required this.text,
  });
}