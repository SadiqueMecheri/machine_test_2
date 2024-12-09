import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'VideoCard.dart';
import 'VideoProvider.dart';
import 'Video_uploadScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('YouTube Clone'),
        ),
        body: Consumer<VideoProvider>(
          builder: (context, videoProvider, child) {
            final videos = videoProvider.videos;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return VideoCard(index: index, video: videos[index]);
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryPickerScreen()));
            print('Extended FAB Pressed!');
          },
          icon: const Icon(Icons.navigation),
          label: const Text('Feed'),
          backgroundColor: Colors.green,
        ));
  }
}
