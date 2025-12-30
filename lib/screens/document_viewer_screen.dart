import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class DocumentViewerScreen extends StatefulWidget {
  final String documentTitle;
  final String documentType; // ppt, pdf, dll
  final List<String> imageUrls; // List gambar untuk simulasi halaman PPT

  const DocumentViewerScreen({
    Key? key,
    required this.documentTitle,
    required this.documentType,
    this.imageUrls = const [], // Default empty
  }) : super(key: key);

  @override
  State<DocumentViewerScreen> createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  int _currentPage = 1;
  final int _totalPages = 26; // Contoh total 26 halaman
  final PageController _pageController = PageController();

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // HEADER MERAH dengan judul dan tombol kembali
          Container(
            height: 120,
            width: double.infinity,
            color: const Color(0xFFB74848),
            padding: const EdgeInsets.only(top: 40),
            child: Stack(
              children: [
                // Tombol kembali - KIRI
                Positioned(
                  left: 16,
                  top: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                
                // Judul dokumen - TENGAH
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Text(
                      widget.documentTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                
                // Page indicator - KANAN
                Positioned(
                  right: 16,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF858688),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      '$_currentPage/$_totalPages',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // KONTEN UTAMA dengan PageView
          Expanded(
            child: Stack(
              children: [
                // PageView untuk konten dokumen
                PageView.builder(
                  controller: _pageController,
                  itemCount: _totalPages,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index + 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            widget.documentType == 'ppt' 
                              ? Icons.slideshow 
                              : Icons.picture_as_pdf,
                            size: 80,
                            color: AppColors.primaryRed,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.documentTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Halaman ${index + 1}/$_totalPages',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Ini adalah simulasi halaman dokumen.\nDi aplikasi sebenarnya, ini akan menampilkan konten asli.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                // Navigation buttons (kiri/kanan)
                Positioned(
                  left: 10,
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: GestureDetector(
                    onTap: _goToPreviousPage,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: AppColors.primaryRed,
                      ),
                    ),
                  ),
                ),
                
                Positioned(
                  right: 10,
                  top: MediaQuery.of(context).size.height * 0.4,
                  child: GestureDetector(
                    onTap: _goToNextPage,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: AppColors.primaryRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // FOOTER dengan page indicator
          Container(
            height: 60,
            color: Colors.grey[100],
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_currentPage / $_totalPages',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}