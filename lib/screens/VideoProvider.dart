import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import '../Model/Video.dart';

class VideoProvider extends ChangeNotifier {
  final List<Video> _videos = [
    Video(
      title: "Flutter Tutorial - Video 1",
      url:
          "https://videos.cyralearnings.com/videoclasses/englishkoot/demo_video.mp4",
      thumbnailUrl: "https://via.placeholder.com/400x200.png?text=Thumbnail+1",
    ),
    Video(
      title: "Flutter Tutorial - Video 2",
      url:
          "https://videos.cyralearnings.com/videoclasses/englishkoot/demo_video.mp4",
      thumbnailUrl: "https://via.placeholder.com/400x200.png?text=Thumbnail+2",
    ),
  ];

  List<Video> get videos => _videos;

  void togglePlay(int index, PodPlayerController controller) {
    if (_videos[index].isPlaying) {
      controller.pause();
      _videos[index].isPlaying = false;
    } else {
      controller.play();
      _videos[index].isPlaying = true;
    }
    notifyListeners();
  }
}
