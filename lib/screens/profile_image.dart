import 'package:flutter/material.dart';

/* FOR THE PROFILE IMAGE VIEW */

class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Hero(
              tag: "image",
              child: Image.asset(
                "./assets/images/bg.png",
                fit: BoxFit.cover,
              )),
        ),
      )),
    );
  }
}
