class Video {
  final String title;
  final String url; // URL of the video
  final String thumbnailUrl;

  bool isPlaying; // Track whether the video is playing or not

  Video({
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    this.isPlaying = false,
  });
}
