import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/backends/backends.dart';

class WelcomePage extends StatelessWidget {
  // HiveStore to check if user is logged In or not\
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();

  bool logInCheck(BuildContext context) {
    // returns true if user is already logged in, false otherwise
    var loggedIn =
        _graphQLConfiguration.box.get('loggedIn', defaultValue: false);

    return loggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double screenHeight = constraints.maxHeight;
      double screenWidth = constraints.maxWidth;

      return logInCheck(context)
          ? NavigationScreen() // navigates to the home screen if user is already logged In
          : Scaffold(
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
                                image:
                                    AssetImage("./assets/images/social.png"))),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: ElevatedButton(
                            style: ButtonStyle(),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        Login())),
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
