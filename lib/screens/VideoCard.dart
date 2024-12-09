import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

import '../Model/CategoryModel.dart';
import '../Model/Video.dart';
import 'VideoProvider.dart';

class VideoCard extends StatefulWidget {
  final int index;
  final Result video;

  const VideoCard({Key? key, required this.index, required this.video})
      : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late final PodPlayerController _controller;

  @override
  void initState() {
    _controller = PodPlayerController(
      podPlayerConfig: const PodPlayerConfig(
          autoPlay: false,
          isLooping: false,

      ),
      playVideoFrom: PlayVideoFrom.network(
        widget.video.videoUrl,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _disposeController() {
  //   if (_controller != null) {
  //     // Pause the controller if it's playing and dispose of it
  //     if (_controller!.isVideoPlaying) {
  //       _controller!.pause();
  //     }
  //     _controller!.dispose();
  //     _controller = null; // Set the controller to null
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.read<VideoProvider>().togglePlay(widget.index, _controller);
          },
          child: Container(
            height: 200,
            child: PodVideoPlayer(controller: _controller,   videoThumbnail:  DecorationImage(
    /// load from asset: AssetImage('asset_path')
    image: NetworkImage(widget.video.imageUrl,
    ),
    fit: BoxFit.cover,
    ),),
          ),
        ),
      ],
    );
  }
}
