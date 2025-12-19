import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/announcement_provider.dart';
import '../utils/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final String announcementId;

  const AnnouncementDetailScreen({
    Key? key,
    required this.announcementId,
  }) : super(key: key);

  @override
  _AnnouncementDetailScreenState createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  int _currentIndex = 0;

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/my-classes');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final announcementProvider = Provider.of<AnnouncementProvider>(context);
    final announcement = announcementProvider.getAnnouncementById(widget.announcementId);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // Header dengan back button
          Container(
            height: 91,
            width: double.infinity,
            color: AppColors.white,
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Pengumuman',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                      size: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),

          // Konten Detail Pengumuman
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: AppColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Judul Pengumuman
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        announcement.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Gambar Pengumuman
                    Center(
                      child: Container(
                        width: 319,
                        height: 185,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: announcement.imageUrl != null
                            ? Image.asset(
                                announcement.imageUrl!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.announcement,
                                size: 60,
                                color: AppColors.grey,
                              ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Info Penulis dan Tanggal
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Row(
                        children: [
                          // Avatar/Icon penulis
                          Container(
                            width: 23,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryRed.withOpacity(0.1),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 12,
                              color: AppColors.primaryRed,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'By ${announcement.author} - ${announcement.date}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                              color: AppColors.black.withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Judul Konten
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        'Detail Pengumuman',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Isi Konten
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        announcement.content,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}