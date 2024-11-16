import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final CardSwiperController controller = CardSwiperController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(36, 35, 35, 1),
          leading: Padding(
            padding: EdgeInsets.only(left: width / 40),
            child: Icon(
              Icons.person,
              size: width / 8,
              color: Colors.white,
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
                  coinContainer(width, "assets/Capa_1.png", "22"),
                  coinContainer(width, "assets/Capa_2.png", "22"),
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
        ),
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
                    cardsCount: 3,
                    backCardOffset: const Offset(20, 20),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.1,
                    ),
                    cardBuilder: (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) =>
                        Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage("assets/image.png"),
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
                                "Meow Meow Meow",
                                style: TextStyle(
                                  fontSize: width / 8,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(
                                "Meow Meow Meow",
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
                                "Some Random Dev",
                                style: TextStyle(
                                  fontSize: width / 13,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 3
                                    ..color = Colors.black,
                                ),
                              ),
                              Text(
                                "Some Random Dev",
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
                            ["Flutter", "Dart", "React", "Node.js", "Python"],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: height * 0.02, // Adjust positioning as needed
                    left: width * 0.05,
                    right: width * 0.05,
                    child: projectCategoriesRow(
                      width,
                      ["Web", "Mobile", "AI", "Blockchain", "Game Dev"],
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

  Widget techCardsRow(double width, List<String> techs) {
    double cardWidth = width / 5;
    double availableWidth = width - (2 * width / 20); // Padding
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
        children: [
          Image.asset(
            imgPath,
            width: width / 10,
            height: width / 10,
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
