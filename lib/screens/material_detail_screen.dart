import 'package:flutter/material.dart';
import '../models/material_detail_model.dart';
import '../utils/app_colors.dart';
import '../widgets/material_item_widget.dart';

class MaterialDetailBottomSheet extends StatefulWidget {
  final MaterialDetail materialDetail;

  const MaterialDetailBottomSheet({
    Key? key,
    required this.materialDetail,
  }) : super(key: key);

  @override
  _MaterialDetailBottomSheetState createState() => _MaterialDetailBottomSheetState();
}

class _MaterialDetailBottomSheetState extends State<MaterialDetailBottomSheet> {
  int _selectedTab = 0; // 0 = Lampiran Materi, 1 = Tugas dan Kuis

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                width: 109,
                height: 6,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFC4C4C4).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),

              // Judul Materi
              Padding(
                padding: const EdgeInsets.only(top: 22, left: 20, right: 20),
                child: Text(
                  widget.materialDetail.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Deskripsi
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.materialDetail.description,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),

              // Tab selector
              Container(
                height: 35,
                margin: const EdgeInsets.only(top: 20),
                color: const Color(0xFFF7F7F7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tab Lampiran Materi
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Lampiran Materi',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: _selectedTab == 0 
                                  ? Colors.black 
                                  : Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 2),
                            if (_selectedTab == 0)
                              Container(
                                width: 50,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Tab Tugas dan Kuis
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Tugas dan Kuis',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: _selectedTab == 1 
                                  ? Colors.black 
                                  : Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 2),
                            if (_selectedTab == 1)
                              Container(
                                width: 50,
                                height: 3,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Konten berdasarkan tab
              Expanded(
                child: _selectedTab == 0
                  ? _buildMaterialItems(scrollController)
                  : _buildAssignments(scrollController),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMaterialItems(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: widget.materialDetail.items.length,
      itemBuilder: (context, index) {
        final item = widget.materialDetail.items[index];
        return MaterialItemWidget(
          item: item,
          onTap: () {
            _handleMaterialItemTap(context, item);
          },
        );
      },
    );
  }

  Widget _buildAssignments(ScrollController scrollController) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment,
              size: 60,
              color: AppColors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tidak ada tugas atau kuis untuk materi ini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleMaterialItemTap(BuildContext context, MaterialItem item) {
    // Handle ketika item material di-tap
    switch (item.type) {
      case MaterialItemType.link:
        if (item.url != null) {
          _showLinkDialog(context, item);
        }
        break;
      case MaterialItemType.document:
        _showDocumentDialog(context, item);
        break;
      case MaterialItemType.video:
        _showVideoDialog(context, item);
        break;
      case MaterialItemType.interactive:
        _showInteractiveDialog(context, item);
        break;
      case MaterialItemType.file:
        _showFileDialog(context, item);
        break;
    }
  }

  void _showLinkDialog(BuildContext context, MaterialItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buka Link'),
        content: Text('Apakah Anda ingin membuka link: ${item.title}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement buka link
              // launchUrl(Uri.parse(item.url!));
            },
            child: const Text('Buka'),
          ),
        ],
      ),
    );
  }

  void _showDocumentDialog(BuildContext context, MaterialItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buka Dokumen'),
        content: Text('Membuka dokumen: ${item.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showVideoDialog(BuildContext context, MaterialItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Putar Video'),
        content: Text('Memutar video: ${item.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement pemutaran video
            },
            child: const Text('Putar'),
          ),
        ],
      ),
    );
  }

  void _showInteractiveDialog(BuildContext context, MaterialItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konten Interaktif'),
        content: Text('Membuka konten interaktif: ${item.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showFileDialog(BuildContext context, MaterialItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buka File'),
        content: Text('Membuka file: ${item.title}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}