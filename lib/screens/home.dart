import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/post_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          PostContainer(
            myPost: true,
            verified: true,
            image: "./assets/images/ecc2.jpg",
            subtitle: "Sponsored",
            username: "Rokney.com",
          ),
          const Divider(
            color: Colors.black,
          ),
          PostContainer(
            myPost: false,
            verified: false,
            image: "./assets/images/online-shopping.jpg",
            subtitle: "Fitness",
            username: "BenzyFitness",
          ),
          const Divider(
            color: Colors.black,
          ),
          PostContainer(
            myPost: true,
            verified: true,
            image: "./assets/images/mult.png",
            subtitle: "Facebook",
            username: "Social Media",
          )
        ],
      ),
    );
  }
}
