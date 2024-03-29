import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/carts.dart';
import 'package:rokney/screens/screens.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: PreferredSize(
              child: Container(
                color: ColorPalette().mainColor,
                child: TabBar(isScrollable: false, tabs: <Tab>[
                  Tab(
                    child: Row(
                      children: [
                        const Text("Chats"),
                        const SizedBox(
                          width: 7,
                        ),
                        OrdinaryLabel(text: "99+")
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        const Text("Carts"),
                        const SizedBox(
                          width: 7,
                        ),
                        OrdinaryLabel(
                          text: "32",
                        )
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: [
                        const Text("Jobs"),
                        const SizedBox(
                          width: 7,
                        ),
                        OrdinaryLabel(
                          text: "12",
                        )
                      ],
                    ),
                  ),
                ]),
              ),
              preferredSize: Size(size.width, kToolbarHeight)),
          // ignore: prefer_const_constructors
          body: TabBarView(children: [
            Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: ListView(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChatScreen(username: "Emehinola"))),
                    child: CustomTile(
                      Ordertype: "order",
                      image: "./assets/images/bg.png",
                      chatNumber: "1",
                      name: "Emehinola",
                      subtitle: "Sent",
                    ),
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "message",
                    image: "./assets/images/ecc2.jpg",
                    chatNumber: null,
                    name: "Rokney",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "order",
                    image: "./assets/images/bg.png",
                    chatNumber: "13",
                    name: "Google.com",
                    subtitle: "Sending...",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/social.png",
                    chatNumber: "5",
                    name: "Samuel",
                    subtitle: "pending...",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "order type",
                    image: "./assets/images/ecc.jpg",
                    chatNumber: "11",
                    name: "iRocket",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/bg.png",
                    chatNumber: null,
                    name: "Sellout",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/ecc2.jpg",
                    chatNumber: "1",
                    name: "Pizza Seller",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/ecc.jpg",
                    chatNumber: null,
                    name: "iRocket",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/online-shopping.jpg",
                    chatNumber: "19",
                    name: "Sellout",
                    subtitle: "Delivered",
                  ),
                  Divider(
                    indent: 60,
                    color: ColorPalette().mainColor,
                  ),
                  CustomTile(
                    Ordertype: "type",
                    image: "./assets/images/bg.png",
                    chatNumber: "32",
                    name: "Pizza Seller",
                    subtitle: "Delivered",
                  ),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
            CartScreen(),
            const Scaffold()
          ]),
        ),
      ),
    );
  }
}
