import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;

      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: screenHeight,
          width: screenWidth,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.8,
                  width: screenWidth * 0.8,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("./assets/images/social.png"))),
                ),
                Material(
                  color: Colors.transparent,
                  child: ElevatedButton(
                      style: ButtonStyle(),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Login())),
                      child: Text("GET STARTED >>>")),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
