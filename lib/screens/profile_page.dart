import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    child: const CircleAvatar(
                      backgroundImage: AssetImage("./assets/images/bg.png"),
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
                    left: 200,
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
                          width: 10,
                        ),
                        Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ))
              ],
            ),
            Container(
              height: size.height - 150 - 24,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Emehinola Samuel",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                        "Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment"),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("University of Lagos, Unilag\n Nigeria."),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "93 rokners",
                          style: TextStyle(
                              color: ColorPalette().mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " * 913 rok",
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
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.8,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(12)),
                            child:
                                const Text("Sell rice, plantain and spaghetti",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width * 0.8,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text("A programmer by profession",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          )
                        ],
                      ),
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
                      image: "./assets/images/social.png",
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
        ),
      ),
    );
  }
}
