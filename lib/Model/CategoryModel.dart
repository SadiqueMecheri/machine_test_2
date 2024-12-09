class Category {
  final String id;
  final String title;

  Category({required this.id, required this.title});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      title: json['title'] as String,
    );
  }
}

class Result {
  final String id;
  final String description;
  final String imageUrl;
  final String videoUrl;
  final String createdAt;
  final String userName;
  bool isPlaying;

  Result({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.videoUrl,
    required this.createdAt,
    required this.userName,
    this.isPlaying = false,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id']?.toString() ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      videoUrl: json['video'] ?? '',
      createdAt: json['created_at'] ?? '',
      userName: json['user']['name'] ?? 'Unknown',
    );
  }
}
