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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      // image: const DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: AssetImage("./assets/images/bg.png")),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color ??
                                        Colors.green)),
                            hintText: "email",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.green,
                            ),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color ??
                                        Colors.green)),
                            hintText: "username",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.green),
                          )),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextField(
                          obscureText: true,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color ??
                                        Colors.green)),
                            hintText: "password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.green,
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
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
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
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
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
