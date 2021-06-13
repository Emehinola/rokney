import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("./assets/images/bg.png")),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.orange,
                            ),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "username",
                            prefixIcon:
                                Icon(Icons.person, color: Colors.orange),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.orange,
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
                CustomButton(
                  text: "SIGN UP",
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Colors.white),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login())),
                  child: CustomButton(
                    text: "LOGIN",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.white),
                ),
                CustomButton(
                  text: "RECOVER HERE?",
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
