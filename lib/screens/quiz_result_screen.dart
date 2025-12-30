import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../models/quiz_model.dart';
import '../utils/app_colors.dart';

class QuizResultScreen extends StatelessWidget {
  final String quizId;

  const QuizResultScreen({
    Key? key,
    required this.quizId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final quiz = quizProvider.getQuizById(quizId);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: quiz.nilai != null && quiz.nilai! >= 70 ? Colors.green : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              'Kuis ${quiz.title} Telah Diselesaikan!',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Nilai Anda: ${quiz.nilai ?? 0}/100',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: quiz.nilai != null && quiz.nilai! >= 70 ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman detail kuis
                Navigator.pushReplacementNamed(
                  context,
                  '/quiz-detail',
                  arguments: quizId,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: const Text('Lihat Detail Kuis'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Kembali ke halaman kelas
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                'Kembali ke Kelas',
                style: TextStyle(
                  color: AppColors.primaryRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}