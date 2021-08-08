import 'package:flutter/material.dart';

/* FOR THE PROFILE IMAGE VIEW */

class ProfileImage extends StatelessWidget {
  String profileImageUrl;
  ProfileImage({required this.profileImageUrl});

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
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(profileImageUrl), fit: BoxFit.cover)),
            )),
      )),
    ));
  }
}
