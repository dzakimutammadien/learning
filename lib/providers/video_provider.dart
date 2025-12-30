import 'package:flutter/material.dart';
import '../models/video_model.dart';

class VideoProvider extends ChangeNotifier {
  // List video untuk materi pembelajaran UI/UX
  final List<VideoItem> _uiUxVideos = [
    VideoItem(
      id: 'v1',
      title: 'User Interface Design For Beginner',
      description: 'Video pembelajaran dasar tentang desain antarmuka pengguna untuk pemula',
      thumbnailUrl: 'assets/images/video/thumbnail1.jpg',
      videoUrl: 'assets/video/001.mp4',
      duration: const Duration(minutes: 15, seconds: 30),
      uploadedAt: DateTime(2024, 1, 15),
      uploader: 'Prof. ADY',
      views: 1245,
    ),
    VideoItem(
      id: 'v2',
      title: 'Interaction Design',
      description: 'Memahami prinsip-prinsip interaction design pada UI/UX',
      thumbnailUrl: 'assets/images/video/thumbnail2.jpg',
      videoUrl: 'assets/video/002.mp4',
      duration: const Duration(minutes: 12, seconds: 45),
      uploadedAt: DateTime(2024, 1, 20),
      uploader: 'Prof. ADY',
      views: 987,
    ),
    VideoItem(
      id: 'v3',
      title: 'Pengantar Desain Antarmuka Pengguna',
      description: 'Pengenalan konsep dasar desain antarmuka pengguna',
      thumbnailUrl: 'assets/images/video/thumbnail3.jpg',
      videoUrl: 'assets/video/003.mp4',
      duration: const Duration(minutes: 18, seconds: 20),
      uploadedAt: DateTime(2024, 1, 25),
      uploader: 'Prof. ADY',
      views: 1567,
    ),
    VideoItem(
      id: 'v4',
      title: '4 Teori Dasar Desain Antarmuka Pengguna',
      description: 'Empat teori fundamental dalam desain antarmuka',
      thumbnailUrl: 'assets/images/video/thumbnail4.jpg',
      videoUrl: 'assets/video/004.mp4',
      duration: const Duration(minutes: 22, seconds: 10),
      uploadedAt: DateTime(2024, 2, 1),
      uploader: 'Prof. ADY',
      views: 2103,
    ),
    VideoItem(
      id: 'v5',
      title: 'Tutorial Dasar Figma - UI/UX Design Software',
      description: 'Tutorial penggunaan Figma untuk desain UI/UX',
      thumbnailUrl: 'assets/images/video/thumbnail5.jpg',
      videoUrl: 'assets/video/005.mp4',
      duration: const Duration(minutes: 25, seconds: 40),
      uploadedAt: DateTime(2024, 2, 5),
      uploader: 'Prof. ADY',
      views: 3421,
    ),
    VideoItem(
      id: 'v6',
      title: 'Prinsip Desain Visual UI/UX',
      description: 'Prinsip-prinsip desain visual dalam UI/UX',
      thumbnailUrl: 'assets/images/video/thumbnail6.jpg',
      videoUrl: 'assets/video/006.mp4',
      duration: const Duration(minutes: 20, seconds: 15),
      uploadedAt: DateTime(2024, 2, 10),
      uploader: 'Prof. ADY',
      views: 1892,
    ),
  ];

  // Getter untuk semua video
  List<VideoItem> get allVideos => _uiUxVideos;

  // Get video by ID
  VideoItem? getVideoById(String id) {
    return _uiUxVideos.firstWhere((video) => video.id == id);
  }

  // Get related videos (excluding the current one)
  List<VideoItem> getRelatedVideos(String currentVideoId) {
    return _uiUxVideos
        .where((video) => video.id != currentVideoId)
        .take(4) // Ambil 4 video terkait
        .toList();
  }

  // Get recommended videos
  List<VideoItem> getRecommendedVideos() {
    return _uiUxVideos
        .where((video) => video.views > 1000)
        .take(4)
        .toList();
  }
}