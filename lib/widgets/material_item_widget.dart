import 'package:flutter/material.dart';
import '../models/material_detail_model.dart';

// Widget untuk menampilkan item material
class MaterialItemWidget extends StatelessWidget {
  final MaterialItem item;
  final VoidCallback onTap;

  const MaterialItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          _getIconForMaterialType(item.type),
          color: Colors.red,
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          'Dibuat: ${_formatDate(item.createdAt)}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  IconData _getIconForMaterialType(MaterialItemType type) {
    switch (type) {
      case MaterialItemType.link:
        return Icons.link_outlined;
      case MaterialItemType.document:
        return Icons.description_outlined;
      case MaterialItemType.video:
        return Icons.videocam_outlined;
      case MaterialItemType.interactive:
        // Mengganti Icons.interactive_outlined yang tidak ada
        return Icons.touch_app_outlined; // Alternatif: Icons.games_outlined, Icons.play_circle_outline
      case MaterialItemType.file:
        return Icons.insert_drive_file_outlined;
    }
  }
}