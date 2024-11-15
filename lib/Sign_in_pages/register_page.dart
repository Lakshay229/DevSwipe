import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: height,
          width: width,
          color: const Color.fromRGBO(14, 12, 12, 1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: width / 20),
                Image.asset(
                  "assets/devswipe_logo_2.png",
                  height: width / 2,
                ),
                // SizedBox(height: width / 20),
                customTextField(width, "Username"),
                customTextField(width, "Email"),
                customTextField(width, "Date of Birth"),
                customTextField(width, "Github"),
                customTextField(width, "Linkedin"),
                uploadResume(width),
                registerButton(width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector uploadResume(double width) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: width / 20),
        child: DottedBorder(
          color: Colors.white,
          strokeWidth: 2,
          dashPattern: const [8, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(16),
          child: Container(
            width: width / 2,
            height: width / 7,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(14, 12, 12, 1),
              borderRadius: BorderRadius.circular(32),
            ),
            alignment: Alignment.center,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Upload\nResume",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.upload,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector registerButton(double width) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          top: width / 20,
          bottom: width / 25,
        ),
        width: width / 1.5,
        height: width / 6,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(10, 106, 197, 1),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Text(
            "Register",
            style: TextStyle(
              color: Colors.white,
              fontSize: width / 10,
            ),
          ),
        ),
      ),
    );
  }

  Container customTextField(double width, String hintText) {
    return Container(
      height: width / 6,
      margin: EdgeInsets.symmetric(
        horizontal: width / 20,
        vertical: width / 70,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: width / 18,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: width / 24,
            horizontal: width / 24,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
      ),
    );
  }
}
