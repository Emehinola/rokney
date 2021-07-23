import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/post_widget.dart';
import 'package:rokney/backends/backends.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final PageStorageKey _key = const PageStorageKey(
  //     'home'); // for retaining the state of the scrolling of the page

  List usersProfileList =
      DatabaseMethod().getUsers(); // gets the list of all the users' profile

  List<Post> posts = DatabaseMethod().getPosts();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // key: _key,
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return PostContainer(
              userProfile: usersProfileList[index],
              myPost: true,
              verified: true,
              images: posts[index].images,
              text: posts[index].text,
              subtitle: "Sponsored",
              username: usersProfileList[index].username,
            );
          }),
    );
  }
}
