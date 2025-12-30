import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/user_provider.dart';
import './providers/announcement_provider.dart'; 
import './providers/class_provider.dart';
import './providers/class_detail_provider.dart';
import './providers/material_detail_provider.dart';
import './providers/tugas_detail_provider.dart';
import './providers/video_provider.dart';
import './providers/quiz_provider.dart'; // TAMBAHKAN INI
import './screens/splash_screen.dart';
import './screens/login_screen.dart';
import './screens/language_help_screen.dart';
import './screens/home_screen.dart';
import './screens/my_classes_screen.dart';
import './screens/notification_screen.dart';
import './screens/profile_screen.dart';
import './screens/kelas_detail_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/announcements_screen.dart';
import './screens/announcement_detail_screen.dart';
import './screens/class_detail_screen.dart';
import './screens/material_detail_screen.dart';
import './screens/document_viewer_screen.dart';
import './screens/video_player_screen.dart';
import './screens/tugas_detail_screen.dart';
import './screens/upload_file_screen.dart';
import './screens/quiz_detail_screen.dart'; // TAMBAHKAN INI
import './screens/quiz_question_screen.dart'; // TAMBAHKAN INI
import './screens/quiz_review_screen.dart'; // TAMBAHKAN INI
import './screens/quiz_result_screen.dart'; // TAMBAHKAN INI
import './utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
        ChangeNotifierProvider(create: (_) => ClassProvider()),
        ChangeNotifierProvider(create: (_) => ClassDetailProvider()),
        ChangeNotifierProvider(create: (_) => MaterialDetailProvider()),
        ChangeNotifierProvider(create: (_) => TugasDetailProvider()), 
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()), // TAMBAHKAN INI
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CeLOE LMS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryRed,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB6252A),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.primaryRed, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          hintStyle: const TextStyle(
            color: AppColors.grey,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 14,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryRed,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryRed,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          displaySmall: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: AppColors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: AppColors.black,
          ),
        ),
        useMaterial3: false,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/language-help': (context) => const LanguageHelpScreen(),
        '/home': (context) => const HomeScreen(),
        '/my-classes': (context) => const MyClassesScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
        '/kelas-detail': (context) {
          final kelas = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return KelasDetailScreen(kelas: kelas);
        },
        '/announcement-detail': (context) {
          final announcementId = ModalRoute.of(context)!.settings.arguments as String;
          return AnnouncementDetailScreen(announcementId: announcementId);
        },
        '/class-detail': (context) {
          final classId = ModalRoute.of(context)!.settings.arguments as String;
          return ClassDetailScreen(classId: classId);
        },
        '/video-player': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return VideoPlayerScreen(
            videoId: args['videoId'],
            videoTitle: args['videoTitle'],
          );
        },
        '/document-viewer': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return DocumentViewerScreen(
            documentTitle: args['title'],
            documentType: args['type'],
            imageUrls: args['images'] ?? [],
          );
        },
        '/tugas-detail': (context) {
          final tugasId = ModalRoute.of(context)!.settings.arguments as String;
          return TugasDetailScreen(tugasId: tugasId);
        },
        '/upload-file': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return UploadFileScreen(
            tugasId: args['tugasId'],
            tugasTitle: args['tugasTitle'],
          );
        },
        // ROUTE BARU UNTUK KUIS
        '/quiz-detail': (context) {
          final quizId = ModalRoute.of(context)!.settings.arguments as String;
          return QuizDetailScreen(quizId: quizId);
        },
        '/quiz-question': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return QuizQuestionScreen(
            quizId: args['quizId'],
            questionNumber: args['questionNumber'],
          );
        },
        '/quiz-review': (context) {
          final quizId = ModalRoute.of(context)!.settings.arguments as String;
          return QuizReviewScreen(quizId: quizId);
        },
        '/quiz-result': (context) {
          final quizId = ModalRoute.of(context)!.settings.arguments as String;
          return QuizResultScreen(quizId: quizId);
        },
      },
      onGenerateRoute: (settings) {
        print('Unknown route: ${settings.name}');
        print('Arguments: ${settings.arguments}');
        
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Halaman Tidak Ditemukan'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Halaman "${settings.name}" tidak ditemukan',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Coba akses: /home, /my-classes, /class-detail, dll',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                    child: const Text('Kembali ke Home'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}