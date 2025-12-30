import 'dart:async'; // TAMBAHKAN INI
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/quiz_model.dart'; // TAMBAHKAN INI
import '../utils/app_colors.dart';

class QuizQuestionScreen extends StatefulWidget {
  final String quizId;
  final int questionNumber;

  const QuizQuestionScreen({
    Key? key,
    required this.quizId,
    required this.questionNumber,
  }) : super(key: key);

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final quiz = quizProvider.getQuizById(widget.quizId);
    
    _remainingTime = quiz.sisaWaktu ?? Duration(minutes: quiz.waktuPengerjaan);
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime -= const Duration(seconds: 1);
        } else {
          timer.cancel();
          // Waktu habis, submit kuis
          _submitQuiz();
        }
      });
    });
  }

  void _submitQuiz() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.submitQuiz(widget.quizId);
    
    Navigator.pushReplacementNamed(
      context,
      '/quiz-result',
      arguments: widget.quizId,
    );
  }

  void _nextQuestion() {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final quiz = quizProvider.getQuizById(widget.quizId);
    
    // Simpan jawaban jika ada
    if (_selectedAnswer != null) {
      final currentQuestion = quiz.questions[widget.questionNumber - 1];
      quizProvider.saveAnswer(
        widget.quizId,
        currentQuestion.id,
        _selectedAnswer!,
      );
    }
    
    if (widget.questionNumber < quiz.questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizQuestionScreen(
            quizId: widget.quizId,
            questionNumber: widget.questionNumber + 1,
          ),
        ),
      );
    } else {
      // Pindah ke halaman review
      Navigator.pushReplacementNamed(
        context,
        '/quiz-review',
        arguments: widget.quizId,
      );
    }
  }

  void _previousQuestion() {
    if (widget.questionNumber > 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizQuestionScreen(
            quizId: widget.quizId,
            questionNumber: widget.questionNumber - 1,
          ),
        ),
      );
    }
  }

  void _selectAnswer(String answerId) {
    setState(() {
      _selectedAnswer = answerId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final quiz = quizProvider.getQuizById(widget.quizId);
    final question = quiz.questions[widget.questionNumber - 1];
    
    // Load jawaban yang sudah disimpan
    if (_selectedAnswer == null && question.jawabanUser != null) {
      _selectedAnswer = question.jawabanUser;
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background merah di atas
          Container(
            height: 307,
            width: double.infinity,
            color: const Color(0xFFB74848),
          ),

          // Konten utama
          Column(
            children: [
              // App Bar
              Container(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 16,
                  right: 16,
                  bottom: 20,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 37,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        quiz.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Timer
                    Row(
                      children: [
                        // Icon jam
                        Container(
                          width: 25,
                          height: 21,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                        // Waktu
                        Text(
                          _formatDuration(_remainingTime),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Nomor soal navigator
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: List.generate(quiz.questions.length, (index) {
                    final isCurrent = index + 1 == widget.questionNumber;
                    final isAnswered = quiz.questions[index].jawabanUser != null;
                    
                    return GestureDetector(
                      onTap: () {
                        if (index + 1 != widget.questionNumber) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizQuestionScreen(
                                quizId: widget.quizId,
                                questionNumber: index + 1,
                              ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isAnswered ? const Color(0xFF2BEE1A) : Colors.transparent,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              // Konten soal
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nomor soal
                        Text(
                          'Soal Nomor ${widget.questionNumber} / ${quiz.questions.length}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Pertanyaan
                        Text(
                          question.pertanyaan,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Pilihan jawaban
                        ...question.options.map((option) {
                          final isSelected = _selectedAnswer == option.id;
                          
                          return GestureDetector(
                            onTap: () => _selectAnswer(option.id),
                            child: Container(
                              width: 294,
                              height: 42,
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: isSelected 
                                  ? const Color(0xFFEA6262) 
                                  : const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Text(
                                    '${option.label}.',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected ? Colors.white : AppColors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    option.text,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: isSelected ? Colors.white : AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),

                        const SizedBox(height: 40),

                        // Tombol navigasi
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Tombol sebelumnya (hanya jika bukan soal pertama)
                            if (widget.questionNumber > 1)
                              GestureDetector(
                                onTap: _previousQuestion,
                                child: Container(
                                  width: 97,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7F7F7),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Soal Sebelumnya',
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Tombol selanjutnya atau selesai
                            GestureDetector(
                              onTap: _nextQuestion,
                              child: Container(
                                width: 97,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: widget.questionNumber == quiz.questions.length
                                    ? const Color(0xFF2BEE1A)
                                    : const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.questionNumber == quiz.questions.length
                                      ? 'Selesai'
                                      : 'Soal Selanjutnya',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}