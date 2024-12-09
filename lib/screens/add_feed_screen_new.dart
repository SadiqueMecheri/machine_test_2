import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:machine_test_2/screens/CategoryProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../contraints.dart';

class AddFeedScreen extends StatefulWidget {
  const AddFeedScreen({super.key});

  @override
  State<AddFeedScreen> createState() => _AddFeedScreenState();
}

class _AddFeedScreenState extends State<AddFeedScreen> {
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
      backgroundColor: AppColors().backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset("assets/images/back-arrow.png"),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Add Feeds",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      Consumer<CategoryProvider>(
                          builder: (context, categoryProvider, child) {
                        return categoryProvider.isLoading
                            ? const CircularProgressIndicator() // Show loader if isLoading is true
                            : InkWell(
                                onTap: () async {
                                  try {
                                    await categoryProvider
                                        .uploadData(descriptionController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Upload Successful')),
                                    );

                                    Navigator.pop(context);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Upload Failed: $e')),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      color: const Color(0xfff3a1212),
                                      border: Border.all(
                                          color: Colors.red.shade900)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Share Post",
                                          style: TextStyle(
                                              color: AppColors().borderColor,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  DottedBorder(
                    color: AppColors().borderColor,
                    strokeWidth: 1,
                    dashPattern: [10, 15],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    // padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () async {
                        await categoryProvider.pickVideo(context);
                        if (categoryProvider.video != null) {
                          initializeVideo(categoryProvider.video!);
                        }
                      },
                      child: Container(
                        height: categoryProvider.video == null
                            ? MediaQuery.of(context).size.width
                            : MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors().bottunColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            categoryProvider.video == null
                                ? Image.asset("assets/images/video.png")
                                : AspectRatio(
                                    aspectRatio: _videoPlayerController!
                                        .value.aspectRatio,
                                    child: VideoPlayer(_videoPlayerController!),
                                  ),
                            const SizedBox(height: 10),
                            categoryProvider.video == null
                                ? SizedBox()
                                : ElevatedButton(
                                    onPressed: togglePlayPause,
                                    child: Text(isPlaying ? 'Pause' : 'Play'),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            categoryProvider.video == null
                                ? const Text(
                                    "Select a video from Gallery",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                                : const Text(
                                    "Video Selected",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )
                          ],
                        )),
                      ),
                    ),
                  ),
                  // : Text(
                  //     "Video Selected",
                  //     style: TextStyle(color: Colors.white, fontSize: 15),
                  //   ),
                  const SizedBox(
                    height: 20,
                  ),
                  DottedBorder(
                    color: AppColors().borderColor,
                    strokeWidth: 1,
                    dashPattern: [10, 15],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    // padding: EdgeInsets.all(8),
                    child: InkWell(
                      onTap: () async {
                        await categoryProvider.pickThumbnail();
                        setState(
                            () {}); // Update UI to show the selected thumbnail
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors().bottunColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(),
                            categoryProvider.thumbnail != null
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Image.file(
                                      categoryProvider.thumbnail!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset("assets/images/thumbline.png"),
                            const SizedBox(
                              height: 10,
                            ),
                            categoryProvider.thumbnail == null
                                ? Text(
                                    "Add a Thumbnaile",
                                    style: TextStyle(
                                        color: AppColors().borderColor,
                                        fontSize: 15),
                                  )
                                : Text(
                                    "Thumbnaile\nSelected",
                                    style: TextStyle(
                                        color: AppColors().borderColor,
                                        fontSize: 15),
                                  ),
                            const SizedBox()
                          ],
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Description",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: descriptionController,
                          cursorColor: Colors.white,
                          maxLines: null,
                          style: TextStyle(
                              fontSize:
                                  14.0 / MediaQuery.textScaleFactorOf(context),
                              color: AppColors().borderColor),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: AppColors()
                                  .borderColor
                                  .withOpacity(0.6), // Hint text color
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors()
                                    .borderColor, // Underline color when not focused
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors()
                                    .borderColor, // Underline color when focused
                                width: 2.0, // Thickness when focused
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Underline color when there's an error
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Underline color when focused and there's an error
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Categories this project",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Container(
                              // height: 40,

                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "View All",
                                      style: TextStyle(
                                          color: AppColors().borderColor,
                                          fontSize: 13),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset("assets/images/back-arrow.png")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            categoryProvider.categories.length,
                            (index) {
                              final category =
                                  categoryProvider.categories[index];
                              final isSelected = categoryProvider
                                  .selectedCategoryIds
                                  .contains(category.id);

                              return InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  categoryProvider
                                      .toggleCategorySelection(category.id);
                                },
                                child: Container(
                                  // height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                      color: isSelected
                                          ? AppColors().bottunColor
                                          : AppColors().backgroundColor,
                                      border: Border.all(
                                          color: isSelected
                                              ? AppColors().borderColor
                                              : const Color(0xfff3a1212))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Text(
                                      category.title,
                                      style: TextStyle(
                                          color: AppColors().borderColor,
                                          fontSize: 13),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
