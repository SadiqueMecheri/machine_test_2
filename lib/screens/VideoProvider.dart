import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

  void togglePlay(int index, VideoPlayerController controller) {
    for (int i = 0; i < _videos.length; i++) {
      if (i != index) {
        _videos[i].isPlaying = false;
      }
    }
    _videos[index].isPlaying = !_videos[index].isPlaying;

    notifyListeners();

    if (_videos[index].isPlaying) {
      controller.play();
    } else {
      controller.pause();
    }
  }
}
