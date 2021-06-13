import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/carts.dart';

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
          appBar: PreferredSize(
              child: Container(
                color: ColorPalette().mainColor,
                child: TabBar(tabs: <Tab>[
                  Tab(
                    child: Row(
                      children: [
                        const Text("Messages"),
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
              backgroundColor: Colors.white,
              body: ListView(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTile(
                    Ordertype: "order",
                    image: "./assets/images/bg.png",
                    chatNumber: "1",
                    name: "Emehinola",
                    subtitle: "Sent",
                  ),
                  Divider(
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
