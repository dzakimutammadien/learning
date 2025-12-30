import 'package:flutter/material.dart';
import '../models/quiz_model.dart';

class QuizProvider extends ChangeNotifier {
  // Data kuis
  final List<QuizDetail> _quizzes = [
    QuizDetail(
      id: 'a1', // Sama dengan ID di class_detail_provider
      title: 'Quiz Review 01',
      description: 'Silahkan kerjakan kuis ini dalam waktu 15 menit sebagai nilai pertama komponen kuis. Jangan lupa klik tombol Submit Answer setelah menjawab seluruh pertanyaan. Kerjakan sebelum hari Jum\'at, 26 Februari 2021 jam 23:59 WIB.',
      deadline: DateTime(2021, 2, 26, 23, 59),
      createdAt: DateTime(2021, 2, 20),
      status: QuizStatus.belumDikerjakan,
      waktuPengerjaan: 15,
      questions: [
        QuizQuestion(
          id: 'q1-1',
          quizId: 'a1',
          nomor: 1,
          pertanyaan: 'Radio button dapat digunakan untuk menentukan ?',
          jawabanBenar: 'q1-1-a',
          options: [
            QuizOption(id: 'q1-1-a', questionId: 'q1-1', label: 'A', text: 'Jenis Kelamin'),
            QuizOption(id: 'q1-1-b', questionId: 'q1-1', label: 'B', text: 'Alamat'),
            QuizOption(id: 'q1-1-c', questionId: 'q1-1', label: 'C', text: 'Hobby'),
            QuizOption(id: 'q1-1-d', questionId: 'q1-1', label: 'D', text: 'Riwayat Pendidikan'),
            QuizOption(id: 'q1-1-e', questionId: 'q1-1', label: 'E', text: 'Umur'),
          ],
        ),
        QuizQuestion(
          id: 'q1-2',
          quizId: 'a1',
          nomor: 2,
          pertanyaan: 'Dalam perancangan web yang baik, untuk teks yang menyampaikan isi konten digunakan font yang sama di setiap halaman, ini merupakan salah satu tujuan yaitu ?',
          jawabanBenar: 'q1-2-b',
          options: [
            QuizOption(id: 'q1-2-a', questionId: 'q1-2', label: 'A', text: 'Intergrasi'),
            QuizOption(id: 'q1-2-b', questionId: 'q1-2', label: 'B', text: 'Konsistensi'),
            QuizOption(id: 'q1-2-c', questionId: 'q1-2', label: 'C', text: 'Standarisasi'),
            QuizOption(id: 'q1-2-d', questionId: 'q1-2', label: 'D', text: 'Koefensi'),
            QuizOption(id: 'q1-2-e', questionId: 'q1-2', label: 'E', text: 'Koreksi'),
          ],
        ),
        // Tambahkan soal-soal lain sesuai kebutuhan
      ],
    ),
    QuizDetail(
      id: 'a3', // Kuis Assessment 2
      title: 'Kuis - Assessment 2',
      description: 'Kuis ini meliputi materi dari pertemuan 1 hingga 3. Waktu pengerjaan 30 menit. Pastikan koneksi internet stabil sebelum memulai.',
      deadline: DateTime(2021, 3, 5, 23, 59),
      createdAt: DateTime(2021, 2, 27),
      status: QuizStatus.belumDikerjakan,
      waktuPengerjaan: 30,
      questions: [
        QuizQuestion(
          id: 'q2-1',
          quizId: 'a3',
          nomor: 1,
          pertanyaan: 'Contoh soal untuk Assessment 2?',
          jawabanBenar: 'q2-1-a',
          options: [
            QuizOption(id: 'q2-1-a', questionId: 'q2-1', label: 'A', text: 'Jawaban A'),
            QuizOption(id: 'q2-1-b', questionId: 'q2-1', label: 'B', text: 'Jawaban B'),
            QuizOption(id: 'q2-1-c', questionId: 'q2-1', label: 'C', text: 'Jawaban C'),
            QuizOption(id: 'q2-1-d', questionId: 'q2-1', label: 'D', text: 'Jawaban D'),
          ],
        ),
      ],
    ),
  ];

  // Getter untuk semua kuis
  List<QuizDetail> get quizzes => _quizzes;

  // Method untuk mendapatkan kuis berdasarkan ID
  QuizDetail getQuizById(String id) {
    return _quizzes.firstWhere((quiz) => quiz.id == id, orElse: () => _quizzes.first);
  }

  // Method untuk memulai kuis
  void startQuiz(String quizId) {
    final index = _quizzes.indexWhere((quiz) => quiz.id == quizId);
    if (index != -1) {
      _quizzes[index] = QuizDetail(
        id: _quizzes[index].id,
        title: _quizzes[index].title,
        description: _quizzes[index].description,
        deadline: _quizzes[index].deadline,
        createdAt: _quizzes[index].createdAt,
        status: QuizStatus.sedangDikerjakan,
        waktuPengerjaan: _quizzes[index].waktuPengerjaan,
        nilai: _quizzes[index].nilai,
        mulaiMengerjakan: DateTime.now(),
        selesaiMengerjakan: _quizzes[index].selesaiMengerjakan,
        questions: _quizzes[index].questions,
        submissionUrl: _quizzes[index].submissionUrl,
      );
      notifyListeners();
    }
  }

  // Method untuk menyimpan jawaban
  void saveAnswer(String quizId, String questionId, String answerId) {
    final quizIndex = _quizzes.indexWhere((quiz) => quiz.id == quizId);
    if (quizIndex == -1) return;

    final questionIndex = _quizzes[quizIndex].questions.indexWhere((q) => q.id == questionId);
    if (questionIndex == -1) return;

    final updatedQuestions = List<QuizQuestion>.from(_quizzes[quizIndex].questions);
    updatedQuestions[questionIndex] = QuizQuestion(
      id: updatedQuestions[questionIndex].id,
      quizId: updatedQuestions[questionIndex].quizId,
      nomor: updatedQuestions[questionIndex].nomor,
      pertanyaan: updatedQuestions[questionIndex].pertanyaan,
      options: updatedQuestions[questionIndex].options,
      jawabanUser: answerId,
      jawabanBenar: updatedQuestions[questionIndex].jawabanBenar,
    );

    _quizzes[quizIndex] = QuizDetail(
      id: _quizzes[quizIndex].id,
      title: _quizzes[quizIndex].title,
      description: _quizzes[quizIndex].description,
      deadline: _quizzes[quizIndex].deadline,
      createdAt: _quizzes[quizIndex].createdAt,
      status: _quizzes[quizIndex].status,
      waktuPengerjaan: _quizzes[quizIndex].waktuPengerjaan,
      nilai: _quizzes[quizIndex].nilai,
      mulaiMengerjakan: _quizzes[quizIndex].mulaiMengerjakan,
      selesaiMengerjakan: _quizzes[quizIndex].selesaiMengerjakan,
      questions: updatedQuestions,
      submissionUrl: _quizzes[quizIndex].submissionUrl,
    );
    
    notifyListeners();
  }

  // Method untuk submit kuis
  void submitQuiz(String quizId) {
    final index = _quizzes.indexWhere((quiz) => quiz.id == quizId);
    if (index != -1) {
      // Hitung nilai
      int correctAnswers = 0;
      for (var question in _quizzes[index].questions) {
        if (question.jawabanUser == question.jawabanBenar) {
          correctAnswers++;
        }
      }
      
      final nilai = (_quizzes[index].questions.isNotEmpty)
          ? (correctAnswers / _quizzes[index].questions.length * 100).round()
          : 0;

      _quizzes[index] = QuizDetail(
        id: _quizzes[index].id,
        title: _quizzes[index].title,
        description: _quizzes[index].description,
        deadline: _quizzes[index].deadline,
        createdAt: _quizzes[index].createdAt,
        status: QuizStatus.selesai,
        waktuPengerjaan: _quizzes[index].waktuPengerjaan,
        nilai: nilai,
        mulaiMengerjakan: _quizzes[index].mulaiMengerjakan,
        selesaiMengerjakan: DateTime.now(),
        questions: _quizzes[index].questions,
        submissionUrl: _quizzes[index].submissionUrl,
      );
      
      notifyListeners();
    }
  }
}