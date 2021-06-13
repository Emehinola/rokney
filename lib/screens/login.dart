import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/navigation_screen.dart';
import 'package:rokney/screens/screens.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight; // the height of the screen
        double width = constraints.maxWidth; // the width of he screen

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("./assets/images/social.png"),
                  height: height * 0.3,
                  width: width * 0.3,
                ),
                Container(
                  // height: height * 0.5,
                  width: width * 0.8,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("./assets/images/bg.png")),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.white,
                            ),
                          )),
                      Container(),
                      SizedBox(
                        height: height * 0.05,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NavigationScreen())),
                  child: CustomButton(
                    text: "LOGIN",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Dont have an account yet?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUp())),
                  child: CustomButton(
                    text: "SIGN UP",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RecoverPassword())),
                  child: CustomButton(
                    text: "RECOVER HERE",
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
