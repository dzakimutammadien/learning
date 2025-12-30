import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/quiz_model.dart';
import '../utils/app_colors.dart';

class QuizReviewScreen extends StatelessWidget {
  final String quizId;

  const QuizReviewScreen({
    Key? key,
    required this.quizId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final quiz = quizProvider.getQuizById(quizId);

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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar dengan back button
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
                      const Expanded(
                        child: Text(
                          'Review Jawaban',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Info kuis
                Container(
                  width: 295,
                  height: 116,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Di Mulai Pada',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              quiz.mulaiMengerjakan != null 
                                ? _formatDateTime(quiz.mulaiMengerjakan!)
                                : '-',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            const Text(
                              'Selesai',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Selesai Pada',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              quiz.selesaiMengerjakan != null 
                                ? _formatDateTime(quiz.selesaiMengerjakan!)
                                : '-',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Waktu Penyelesaian',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              quiz.mulaiMengerjakan != null && quiz.selesaiMengerjakan != null
                                ? _calculateDuration(quiz.mulaiMengerjakan!, quiz.selesaiMengerjakan!)
                                : '-',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            const Text(
                              'Nilai',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${quiz.nilai ?? 0} / 100',
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Daftar pertanyaan
                ...quiz.questions.map((question) {
                  final userAnswer = question.jawabanUser;
                  final selectedOption = userAnswer != null 
                    ? question.options.firstWhere((opt) => opt.id == userAnswer, orElse: () => question.options.first)
                    : null;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nomor pertanyaan
                        Text(
                          'Pertanyaan ${question.nomor}',
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        // Bar progress (placeholder)
                        Container(
                          width: 252,
                          height: question.pertanyaan.length > 50 ? 57 : 16,
                          color: const Color(0xFFC4C4C4),
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            question.pertanyaan,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        // Jawaban yang tersimpan
                        if (selectedOption != null)
                          Text(
                            'Jawaban Tersimpan ${selectedOption.label}. ${selectedOption.text}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        
                        const SizedBox(height: 4),
                        
                        // Tombol lihat soal
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              // Navigasi ke soal yang dipilih
                              Navigator.pushNamed(
                                context,
                                '/quiz-question',
                                arguments: {
                                  'quizId': quizId,
                                  'questionNumber': question.nomor,
                                },
                              );
                            },
                            child: const Text(
                              'Lihat Soal',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF0500FF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                const SizedBox(height: 40),

                // Tombol Kirim Jawaban
                Center(
                  child: GestureDetector(
                    onTap: () {
                      quizProvider.submitQuiz(quizId);
                      Navigator.pushReplacementNamed(
                        context,
                        '/quiz-result',
                        arguments: quizId,
                      );
                    },
                    child: Container(
                      width: 97,
                      height: 42,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2BEE1A),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: const Center(
                        child: Text(
                          'Kirim Jawaban',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    
    final dayName = days[dateTime.weekday - 1];
    return '$dayName ${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _calculateDuration(DateTime start, DateTime end) {
    final duration = end.difference(start);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes Menit $seconds Detik';
  }
}