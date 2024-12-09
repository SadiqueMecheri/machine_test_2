import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../Model/Video.dart';
import 'VideoProvider.dart';

class VideoCard extends StatefulWidget {
  final int index;
  final Video video;

  const VideoCard({Key? key, required this.index, required this.video})
      : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.url)
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is ready
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.read<VideoProvider>().togglePlay(widget.index, _controller);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (!_controller.value.isInitialized)
                Image.network(widget.video.thumbnailUrl, fit: BoxFit.cover),
              if (_controller.value.isInitialized)
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              if (!widget.video.isPlaying)
                Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.video.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
