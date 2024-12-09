class FeedResponse {
  final String message;
  final bool status;

  FeedResponse({required this.message, required this.status});

  factory FeedResponse.fromJson(Map<String, dynamic> json) {
    return FeedResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}
