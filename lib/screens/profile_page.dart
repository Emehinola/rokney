import 'package:flutter/material.dart';
import 'package:rokney/backends/models.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';

class ProfilePage extends StatelessWidget {
  // INSTANCE VARIABLES
  UserProfile? userProfile; // the data of the user's profile are here

  ProfilePage({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: size.width,
                    color: ColorPalette().mainColor,
                  ),
                  Positioned(
                    left: 15,
                    top: 10,
                    child: Container(
                      height: 145,
                      width: 150,
                      padding: const EdgeInsets.all(2.0),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProfileImage())),
                        child: Hero(
                          tag: 'image',
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(userProfile!.profileImage!),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  Positioned(
                      left: 130,
                      bottom: 5,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_rounded),
                          onPressed: () => {print("camera pressed")},
                          color: Colors.white,
                        ),
                      )),
                  Positioned(
                      left: 180,
                      top: 70,
                      child: Row(
                        children: [
                          const Text(
                            "Update Profile",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ))
                ],
              ),
              Container(
                height: constraints.maxHeight -
                    150, // subtract the height of the upper container
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProfile!.username!,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(userProfile!.about!,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userProfile!.address!,
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "${userProfile!.followers} rokners",
                            style: TextStyle(
                                color: ColorPalette().mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " * ${userProfile!.following} rok",
                            style: TextStyle(
                                color: ColorPalette().mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        text: "Go Premium",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        height: 80,
                        width: size.width,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List<Widget>.generate(
                              userProfile!.professions!.length,
                              (index) => Container(
                                padding: const EdgeInsets.all(10),
                                width: size.width * 0.8,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(userProfile!.professions![index],
                                    style: const TextStyle(
                                      fontSize: 20,
                                    )),
                              ),
                            )),
                      ),
                      Container(
                        height: 10,
                        width: size.width,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "My posts",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // list of posts by the user
                      PostContainer(
                        myPost:
                            false, // this tells if the post belongs to the loggedIn user or not
                        images: const ["./assets/images/social.png"],
                        subtitle: "posted by me",
                        username: "Emehinola",
                        verified: true,
                      ),
                      const SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
