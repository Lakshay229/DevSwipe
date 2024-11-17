import 'package:devswipe/models/user_model.dart';
import 'package:devswipe/services/provider_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
    UserModel user = Provider.of<ProviderService>(context).user!;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(width, user),
        body: Container(
          height: height,
          width: width,
          color: const Color.fromRGBO(36, 35, 35, 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width / 12,
                  ),
                ),
                Divider(
                  color: const Color.fromARGB(135, 255, 255, 255),
                  thickness: 1,
                  indent: width / 10,
                  endIndent: width / 10,
                ),
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: width / 6,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                const SizedBox(height: 20),
                Text(
                  user.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width / 15,
                  ),
                ),
                Text(
                  "@${user.username}",
                  style: TextStyle(
                    color: const Color.fromARGB(113, 255, 255, 255),
                    fontSize: width / 25,
                  ),
                ),
                // const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    Text(
                      "  ${user.rating.toString()}/5",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width / 19,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width / 10,
                  width: width / 1.2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.skills.languages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10, right: 15),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          user.skills.languages[index],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: width / 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: width / 24,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'Pixeboy',
                  ),
                  dividerColor: Colors.transparent,
                  unselectedLabelColor:
                      const Color.fromARGB(113, 255, 255, 255),
                  tabs: const [
                    Tab(text: 'About'),
                    Tab(text: 'Contributions'),
                    Tab(text: 'Projects'),
                  ],
                ),
                SizedBox(
                  height: height / 1.5,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(child: aboutSection(width, user)),
                      Center(child: contributionSection(width, user)),
                      Center(child: Text('Projects Content')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container contributionSection(double width, UserModel userData) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "History",
            style: TextStyle(
              color: Colors.white,
              fontSize: width / 20,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: width / 1.2,
                  height: width / 2.8,
                  margin: EdgeInsets.symmetric(
                    vertical: width / 40,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(147, 249, 39, 1),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Container aboutSection(double width, UserModel userData) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: width / 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: TextStyle(
              color: Colors.white,
              fontSize: width / 20,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: width / 1.2,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              userData.about,
              style: TextStyle(
                color: const Color.fromARGB(225, 255, 255, 255),
                fontFamily: 'Sometype_Mono',
                fontSize: width / 25,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Connnections",
            style: TextStyle(
              color: Colors.white,
              fontSize: width / 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              connectionButton(
                width,
                "Github",
                "assets/github.png",
                const Color.fromRGBO(147, 249, 39, 1),
                userData.socials.githubUsername,
              ),
              connectionButton(
                width,
                "LinkedIn",
                "assets/linkedin.png",
                const Color.fromRGBO(249, 0, 161, 1),
                userData.socials.linkedin,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customTextFieldWithTitle(
                  width, userData, "Date of Birth", true, false),
              customTextFieldWithTitle(
                  width, userData, "Phone Number", false, true),
            ],
          ),
          const SizedBox(height: 20),
          customTextFieldWithTitle(width, userData, "Email", false, false),
        ],
      ),
    );
  }

  Column customTextFieldWithTitle(
    double width,
    UserModel userData,
    String title,
    bool? dob,
    bool? phoneNum,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: width / 20,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            dob == false
                ? phoneNum == false
                    ? userData.email
                    : userData.phoneNum
                : "${userData.dob.day}-${userData.dob.month}-${userData.dob.year}",
            style: TextStyle(
              color: const Color.fromARGB(225, 255, 255, 255),
              fontFamily: 'Sometype_Mono',
              fontSize: width / 25,
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector connectionButton(double width, String buttonName,
      String imgPath, Color shadeColor, String? url) {
    return GestureDetector(
      onTap: () {
        // Open the url in the browser
      },
      child: SizedBox(
        height: width / 6,
        child: Stack(
          children: [
            Positioned(
              top: 5,
              left: 5,
              child: Container(
                margin: const EdgeInsets.only(top: 10, right: 15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: shadeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      imgPath,
                      width: width / 15,
                      height: width / 15,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      buttonName,
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: width / 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, right: 15),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Image.asset(
                    imgPath,
                    width: width / 15,
                    height: width / 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    buttonName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width / 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(double width, UserModel userData) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(36, 35, 35, 1),
      leading: Padding(
        padding: EdgeInsets.only(left: width / 40),
        child: const BackButton(
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
              coinContainer(width, "assets/Capa_1.png",
                  userData.coins.powerCoins.toString()),
              coinContainer(width, "assets/Capa_2.png",
                  userData.coins.achievementCoins.toString()),
            ],
          ),
        ],
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
