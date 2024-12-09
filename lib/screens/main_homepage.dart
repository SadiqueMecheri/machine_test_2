import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:machine_test_2/screens/Category_Provider_Home.dart';
import 'package:machine_test_2/screens/VideoCard.dart';
import 'package:provider/provider.dart';
import '../contraints.dart';
import 'add_feed_screen_new.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categorylist = [
    "Explore",
    "Trending",
    "All Categories",
    "photo"
  ];
  int selectindex = 0;
  int secondindex = 2;
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider_Home>(context);
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
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hello Maria",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Welcome back to Section",
                              style: TextStyle(
                                  color: AppColors().borderColor, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/profile.jpg"),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 25,
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: categoryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectindex =
                                    index; // Update the selected index on tap
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(30)),
                                        color: selectindex == index
                                            ? const Color(0xfff3a1212)
                                            : secondindex == index
                                                ? AppColors().bottunColor
                                                : AppColors().backgroundColor,
                                        border: Border.all(
                                            color: selectindex == index
                                                ? Colors.red.shade900
                                                : AppColors().borderColor)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            categoryProvider
                                                .categories[index].title,
                                            style: TextStyle(
                                                color: AppColors().borderColor,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  selectindex == index
                                      ? Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: 1,
                                              color: const Color.fromARGB(
                                                  52, 255, 255, 255),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            )
                                          ],
                                        )
                                      : const SizedBox()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            categoryProvider.isLoading
                ? SizedBox()
                : Column(
                    children: List.generate(
                      categoryProvider.results.length,
                      (index) {
                        final data = categoryProvider.results[index];

                        DateTime parsedDate = DateTime.parse(
                            data.createdAt); // Parse the ISO 8601 string
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(parsedDate);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors().bottunColor,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage:
                                                NetworkImage(data.imageUrl),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.userName,

                                                /// "Anaga Krishna",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                    color:
                                                        AppColors().borderColor,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Container(
                                //   height: MediaQuery.of(context).size.width,
                                //   decoration: BoxDecoration(
                                //       color: Colors.blueGrey,
                                //       image: DecorationImage(
                                //           image:
                                //               AssetImage("assets/images/class.jpg"))),
                                // ),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    // add player here
                                    VideoCard(index: index, video: data),
                                    // Image.asset(
                                    //   "assets/images/class.jpg",
                                    //   // height: MediaQuery.of(context).size.width,
                                    //   width: MediaQuery.of(context).size.width,
                                    // ),
                                    // Container(
                                    //   height: 50,
                                    //   width: 50,
                                    //   decoration: BoxDecoration(
                                    //       color:
                                    //           Colors.white70.withOpacity(0.5),
                                    //       shape: BoxShape.circle,
                                    //       border: Border.all(
                                    //           color: Colors.white, width: 2)),
                                    //   child: const Center(
                                    //     child: Icon(
                                    //       Icons.play_arrow,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data.description,

                                      //    "Lorem ipsum dolor sit amet consectetur. Porta at id hac\nvitae. Et tortor at vehicula euismod mi viverra. Lorem ipsum dolor sit amet consectetur. Porta at id hac\nvitae. Et tortor at vehicula euismod mi viverra.",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: AppColors().borderColor,
                                          fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFeedScreen()));
        },
        backgroundColor: const Color(0xfffc70000),
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
