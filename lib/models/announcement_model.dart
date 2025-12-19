class Announcement {
  final String id;
  final String title;
  final String author;
  final String date;
  final String content;
  final String? imageUrl;
  final String thumbnailUrl;

  Announcement({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    this.imageUrl,
    required this.thumbnailUrl,
  });
}