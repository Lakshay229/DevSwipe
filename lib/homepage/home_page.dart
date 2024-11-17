import 'dart:convert';

import 'package:devswipe/const.dart';
import 'package:devswipe/models/user_model.dart';
import 'package:devswipe/profile_page/profile_page.dart';
import 'package:devswipe/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserModel user;
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String error = '';
  List projects = [];

  @override
  void initState() {
    super.initState();
    fetchProjects();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchProjects() async {
    const String url = "$api/projects/get-projects";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": authToken,
          "x-api-key": apiKey
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        setState(() {
          projects = data;
        });
        print(projects[0]["images"][0]);
      } else {
        setState(() {
          projects = [];
        });
      }
    } catch (e) {
      setState(() {
        error = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final provider = Provider.of<ProviderService>(context);
    provider.getUser();
    final UserModel userData = provider.user!;

    final CardSwiperController controller = CardSwiperController();

    return SafeArea(
      child: Scaffold(
        appBar: appBar(width, userData),
        body: PageView(
          controller: _tabController.index == 0
              ? PageController(initialPage: 0)
              : PageController(initialPage: 1),
          physics:
              const NeverScrollableScrollPhysics(), // Disable swipe gestures
          children: [
            Container(
              child: Stack(
                children: [
                  CardSwiper(
                    controller: controller,
                    cardsCount: 2,
                    backCardOffset: const Offset(20, 20),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.1,
                    ),
                    cardBuilder: (context, index, horizontalThresholdPercentage,
                        verticalThresholdPercentage) {
                      if (projects.isEmpty) {
                        return Center(
                          child: Text(
                            'No Projects Available',
                            style: TextStyle(
                              fontSize: width / 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    projects[index]["images"][0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: width / 4,
                              left: width / 20,
                              child: Stack(
                                children: [
                                  Text(
                                    projects[index]["name"],
                                    style: TextStyle(
                                      fontSize: width / 8,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.black,
                                    ),
                                  ),
                                  Text(
                                    projects[index]["name"],
                                    style: TextStyle(
                                      fontSize: width / 8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: width / 5,
                              left: width / 20,
                              child: Stack(
                                children: [
                                  Text(
                                    projects[index]["owner_name"],
                                    style: TextStyle(
                                      fontSize: width / 13,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.black,
                                    ),
                                  ),
                                  Text(
                                    projects[index]["owner_name"],
                                    style: TextStyle(
                                      fontSize: width / 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: width / 20,
                              left: width / 40,
                              child: techCardsRow(
                                width,
                                projects[index]["techUsed"]["languages"],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Positioned(
                    top: height * 0.02,
                    left: width * 0.05,
                    right: width * 0.05,
                    child: projectCategoriesRow(
                      width,
                      List<String>.from(
                        // projects[0]["categories"],
                        ["Web", "App", "node.js", "React js", "mongodb"],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.02,
                    left: width * 0.3,
                    right: width * 0.3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: width / 25,
                          horizontal: width / 10,
                        ),
                      ),
                      onPressed: () {
                        // Action for the "Show More" button
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.grey[850],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "More Details",
                                      style: TextStyle(
                                        fontSize: width / 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Here you can add more details about the project or developer. Customize this as per your requirementsHere you can add more details about the project or developer. Customize this as per your requirementsHere you can add more details about the project or developer. Customize this as per your requirements.Here you can add more details about the project or developer. Customize this as per your requirementsHere you can add more details about the project or developer. Customize this as per your requirementsHere you can add more details about the project or developer. Customize this as per your requirementsHere you can add more details about the project or developer. Customize this as per your requirements",
                                      style: TextStyle(
                                        fontSize: width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Show More",
                        style: TextStyle(
                          fontSize: width / 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "Developers List",
                style: TextStyle(color: Colors.white, fontSize: width / 20),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(36, 35, 35, 1),
      ),
    );
  }

  AppBar appBar(double width, UserModel userData) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(36, 35, 35, 1),
      leading: Padding(
        padding: EdgeInsets.only(left: width / 40),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          child: CircleAvatar(
            backgroundImage: NetworkImage(userData.profilePicture),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: width / 7),
          Image.asset(
            "assets/devswipe_logo.png",
            width: width / 5,
            height: width / 5,
          ),
          Row(
            children: [
              coinContainer(width, "assets/Capa_1.png",
                  userData.coins.powerCoins.toString()),
              coinContainer(width, "assets/Capa_2.png",
                  userData.coins.achievementCoins.toString()),
            ],
          ),
        ],
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(
          fontSize: width / 17,
          fontWeight: FontWeight.bold,
          fontFamily: 'Pixeboy',
        ),
        tabs: const [
          Tab(text: "Projects"),
          Tab(text: "Developers"),
        ],
      ),
    );
  }

  Widget projectCategoriesRow(double width, List<String> categories) {
    double cardWidth = width / 5;
    double availableWidth = width - (2 * width / 20); // Padding
    int maxCards = (availableWidth ~/ cardWidth);
    bool overflow = categories.length > maxCards;

    return Row(
      children: [
        ...categories
            .take(maxCards - (overflow ? 1 : 0))
            .map((category) => Container(
                  padding: EdgeInsets.symmetric(
                    vertical: width / 55,
                    horizontal: width / 30,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width / 18,
                    ),
                  ),
                )),
        if (overflow)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[850],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: width / 55,
                            horizontal: width / 30,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width / 15,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: width / 55,
                horizontal: width / 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Text(
                "+${categories.length - maxCards + 1}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width / 23,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget techCardsRow(double width, List<dynamic> techs) {
    double cardWidth = width / 5;
    double availableWidth = width - (2 * width / 20);
    int maxCards = (availableWidth ~/ cardWidth);
    bool overflow = techs.length > maxCards;

    return Row(
      children: [
        ...techs
            .take(maxCards - (overflow ? 1 : 0))
            .map((tech) => techCard(width, tech)),
        if (overflow)
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey[850],
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: techs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: width / 55,
                            horizontal: width / 30,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(147, 249, 39, 1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            techs[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: width / 17,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: width / 55,
                horizontal: width / 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Text(
                "+${techs.length - maxCards + 1}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width / 17,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Container techCard(double width, String techName) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: width / 55,
        horizontal: width / 30,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(147, 249, 39, 1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        techName,
        style: TextStyle(
          color: Colors.black,
          fontSize: width / 17,
        ),
      ),
    );
  }

  Container coinContainer(double width, String imgPath, String coinsCount) {
    return Container(
      width: width / 6,
      height: width / 10,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imgPath,
            width: width / 20,
            height: width / 20,
          ),
          Text(
            coinsCount,
            style: TextStyle(
              color: Colors.white,
              fontSize: width / 20,
            ),
          ),
        ],
      ),
    );
  }
}
