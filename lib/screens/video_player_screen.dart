import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../providers/video_provider.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;
  final String videoTitle;

  const VideoPlayerScreen({
    Key? key,
    required this.videoId,
    required this.videoTitle,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoItem? _currentVideo;
  List<VideoItem> _relatedVideos = [];
  bool _isPlaying = false;
  double _playbackPosition = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVideoData();
    });
  }

  void _loadVideoData() {
    final videoProvider = Provider.of<VideoProvider>(context, listen: false);
    
    setState(() {
      _currentVideo = videoProvider.getVideoById(widget.videoId);
      _relatedVideos = videoProvider.getRelatedVideos(widget.videoId);
    });
  }

  void _playPauseVideo() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _playVideo(String videoId) {
    final videoProvider = Provider.of<VideoProvider>(context, listen: false);
    final newVideo = videoProvider.getVideoById(videoId);
    
    setState(() {
      _currentVideo = newVideo;
      _relatedVideos = videoProvider.getRelatedVideos(videoId);
      _isPlaying = false;
      _playbackPosition = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentVideo == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Video Tidak Ditemukan'),
          backgroundColor: const Color(0xFFB74848),
        ),
        body: const Center(
          child: Text('Video tidak ditemukan'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header dengan background merah
          Container(
            height: 97,
            color: const Color(0xFFB74848),
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                // Tombol Kembali
                Positioned(
                  left: 16,
                  top: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 36,
                      height: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.2),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),

                // Judul Video
                Positioned(
                  left: 70,
                  right: 70,
                  top: 10,
                  child: Text(
                    _currentVideo!.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Area Video Player
          Container(
            height: 268,
            color: Colors.black,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Thumbnail/Video Placeholder
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.grey[900],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_filled,
                        size: 60,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'VIDEO PLAYER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Simulasi pemutaran video "${_currentVideo!.title}"',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Play/Pause Button Overlay
                GestureDetector(
                  onTap: _playPauseVideo,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Video Controls Bottom
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      // Progress Bar
                      SizedBox(
                        height: 3,
                        child: LinearProgressIndicator(
                          value: _playbackPosition,
                          backgroundColor: Colors.grey[700],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryRed,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Time and Controls
                      Row(
                        children: [
                          Text(
                            _formatDuration(_playbackPosition * _currentVideo!.duration.inSeconds),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.replay_10, color: Colors.white, size: 20),
                            onPressed: () {
                              setState(() {
                                _playbackPosition = (_playbackPosition - 0.1).clamp(0.0, 1.0);
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: _playPauseVideo,
                          ),
                          IconButton(
                            icon: const Icon(Icons.forward_10, color: Colors.white, size: 20),
                            onPressed: () {
                              setState(() {
                                _playbackPosition = (_playbackPosition + 0.1).clamp(0.0, 1.0);
                              });
                            },
                          ),
                          const Spacer(),
                          Text(
                            _currentVideo!.formattedDuration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Video Info
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Title
                Text(
                  _currentVideo!.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Video Stats
                Row(
                  children: [
                    Text(
                      _currentVideo!.formattedViews,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _currentVideo!.formattedUploadDate,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _currentVideo!.uploader,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Video Description
                Text(
                  _currentVideo!.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Video Lainnya Section
          Expanded(
            child: Container(
              color: const Color(0xFFEEEFF1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Title
                  const Padding(
                    padding: EdgeInsets.only(left: 18, top: 20, bottom: 16),
                    child: Text(
                      'Video Lain Nya',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // List of Related Videos
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _relatedVideos.length,
                      itemBuilder: (context, index) {
                        final video = _relatedVideos[index];
                        return _buildRelatedVideoItem(video);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedVideoItem(VideoItem video) {
    return GestureDetector(
      onTap: () {
        _playVideo(video.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 142,
              height: 84,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  // Placeholder for thumbnail
                  Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 30,
                      color: Colors.grey[600],
                    ),
                  ),

                  // Duration badge
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        video.formattedDuration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Video Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Text(
                    video.uploader,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Text(
                        video.formattedViews,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        video.formattedUploadDate,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(double seconds) {
    final totalSeconds = seconds.floor();
    final minutes = (totalSeconds / 60).floor();
    final remainingSeconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}