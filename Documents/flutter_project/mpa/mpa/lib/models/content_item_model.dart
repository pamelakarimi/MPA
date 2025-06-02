class ContentItem {
  final String title;
  final String subtitle;
  final String meta;
  final String image;
  final String category;

  ContentItem({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.image,
    required this.category,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      meta: json['meta'] ?? '',
      image: json['image'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'meta': meta,
      'image': image,
      'category': category,
    };
  }
}
