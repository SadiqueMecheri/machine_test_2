import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'CategoryProvider.dart';

class CategoryPickerScreen extends StatefulWidget {
  @override
  _CategoryPickerScreenState createState() => _CategoryPickerScreenState();
}

class _CategoryPickerScreenState extends State<CategoryPickerScreen> {
  final TextEditingController descriptionController = TextEditingController();
  VideoPlayerController? _videoPlayerController;
  bool isPlaying = false; // State to track if the video is playing

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  // Initialize video playback
  void initializeVideo(File videoFile) {
    _videoPlayerController?.dispose();
    _videoPlayerController = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {}); // Update UI when the video is ready
        _videoPlayerController!.setLooping(true);
      });
  }

  // Toggle play/pause state
  void togglePlayPause() {
    if (_videoPlayerController != null &&
        _videoPlayerController!.value.isInitialized) {
      if (isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Upload Content')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Picker
              ElevatedButton(
                onPressed: () async {
                  await categoryProvider.pickThumbnail();
                  setState(() {}); // Update UI to show the selected thumbnail
                },
                child: Text(categoryProvider.thumbnail == null
                    ? 'Pick Thumbnail'
                    : 'Thumbnail Selected'),
              ),

              // Display Thumbnail
              if (categoryProvider.thumbnail != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.file(
                    categoryProvider.thumbnail!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),

              // Video Picker
              ElevatedButton(
                onPressed: () async {
                  await categoryProvider.pickVideo();
                  if (categoryProvider.video != null) {
                    initializeVideo(categoryProvider.video!);
                  }
                },
                child: Text(categoryProvider.video == null
                    ? 'Pick Video'
                    : 'Video Selected'),
              ),

              // Display Video Player
              if (_videoPlayerController != null &&
                  _videoPlayerController!.value.isInitialized)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: togglePlayPause,
                        child: Text(isPlaying ? 'Pause' : 'Play'),
                      ),
                    ],
                  ),
                ),

              // Description Input
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),

              // Categories Section
              SizedBox(height: 10),
              Text(
                'Categories:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: categoryProvider.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryProvider.categories[index];
                  final isSelected = categoryProvider.selectedCategoryIds
                      .contains(category.id);

                  return ListTile(
                    leading:
                        Image.network(category.image, width: 50, height: 50),
                    title: Text(category.title),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: isSelected ? Colors.green : null,
                    ),
                    onTap: () =>
                        categoryProvider.toggleCategorySelection(category.id),
                  );
                },
              ),

              // Upload Button
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await categoryProvider
                          .uploadData(descriptionController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Upload Successful')),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Upload Failed: $e')),
                      );
                    }
                  },
                  child: Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
