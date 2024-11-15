import 'package:devswipe/Sign_in_pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: const Color.fromRGBO(14, 12, 12, 1),
            child: Column(
              children: [
                SizedBox(height: width / 8),
                Image.asset(
                  "assets/devswipe_logo_2.png",
                ),
                SizedBox(height: width / 7),
                customTextField(
                  width,
                  "EMAIL / USERNAME",
                ),
                SizedBox(height: width / 18),
                customTextField(width, "Password"),
                SizedBox(height: width / 10),
                loginButton(width),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Don't have an Account ?",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: width / 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector loginButton(double width) {
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
            "Login",
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
