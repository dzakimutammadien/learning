import 'package:flutter/material.dart';

enum MaterialItemType {
  link,
  document,
  video,
  interactive,
  file,
}

class MaterialItem {
  final String id;
  final String title;
  final MaterialItemType type;
  final String? url;
  final String? filePath;
  final DateTime createdAt;

  MaterialItem({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    this.filePath,
    required this.createdAt,
  });

  // Factory method untuk membuat dari JSON
  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      type: _parseType(json['type'] ?? 'file'),
      url: json['url'],
      filePath: json['filePath'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }

  // Helper function untuk parse type
  static MaterialItemType _parseType(String type) {
    switch (type.toLowerCase()) {
      case 'link':
        return MaterialItemType.link;
      case 'document':
        return MaterialItemType.document;
      case 'video':
        return MaterialItemType.video;
      case 'interactive':
        return MaterialItemType.interactive;
      case 'file':
        return MaterialItemType.file;
      default:
        return MaterialItemType.file;
    }
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': _typeToString(type),
      'url': url,
      'filePath': filePath,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static String _typeToString(MaterialItemType type) {
    switch (type) {
      case MaterialItemType.link:
        return 'link';
      case MaterialItemType.document:
        return 'document';
      case MaterialItemType.video:
        return 'video';
      case MaterialItemType.interactive:
        return 'interactive';
      case MaterialItemType.file:
        return 'file';
    }
  }

  // Helper method untuk mendapatkan icon
  IconData getIconData() {
    switch (type) {
      case MaterialItemType.link:
        return Icons.link_outlined;
      case MaterialItemType.document:
        return Icons.description_outlined;
      case MaterialItemType.video:
        return Icons.videocam_outlined;
      case MaterialItemType.interactive:
        return Icons.touch_app_outlined;
      case MaterialItemType.file:
        return Icons.insert_drive_file_outlined;
    }
  }
}

class MaterialDetail {
  final String id;
  final String title;
  final String pertemuan; // Tambahkan field pertemuan
  final String description;
  final String stats; // Tambahkan field stats
  final List<MaterialItem> items;

  MaterialDetail({
    required this.id,
    required this.title,
    required this.pertemuan, // Wajib
    required this.description,
    required this.stats, // Wajib
    required this.items,
  });

  factory MaterialDetail.fromJson(Map<String, dynamic> json) {
    return MaterialDetail(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      pertemuan: json['pertemuan'] ?? '', // Tambahkan dari JSON
      description: json['description'] ?? '',
      stats: json['stats'] ?? '', // Tambahkan dari JSON
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => MaterialItem.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'pertemuan': pertemuan, // Tambahkan ke JSON
      'description': description,
      'stats': stats, // Tambahkan ke JSON
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}