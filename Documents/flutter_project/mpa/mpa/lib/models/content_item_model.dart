class ContentItem {
  final String title;
  final String description;
  final String category;
  final String imageUrl;
  final String dateRead;

  ContentItem({
    required this.title,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.dateRead,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      imageUrl: json['imageUrl'],
      dateRead: json['dateRead'],
    );
  }
}

