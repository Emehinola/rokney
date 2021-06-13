import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/profile_page.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  bool? isScrolledUp;

  @override
  void initState() {
    isScrolledUp = false;
    _scrollController = ScrollController();
    _scrollController?.addListener(() {
      if (_scrollController?.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isScrolledUp = true;
        });
      } else if (_scrollController?.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isScrolledUp = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // _tabController.dispose();
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // FocusScope.of(context).unfocus(); // for removing the focus of the text input field

    return Scaffold(
      drawer: Drawer(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 200,
          width: double.infinity,
          color: ColorPalette().mainColor,
        ),
        Container(
          height: size.height - 200,
          child: ListView(children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Bookmarks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "Latest world happening",
              subtitle: "Hello world",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "Education",
              subtitle: "Hello world",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "Religion",
              subtitle: "Hello world",
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  child: const Text(
                    "Read more",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Carts | How tos",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "How to prepare okra soup",
              subtitle: "Hello world",
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "How to create a 3D animation",
              subtitle: "Hello world",
            ),
            const SizedBox(
              height: 10.0,
            ),
            CustomTile(
              image: "./assets/images/bg.png",
              name: "How to create a 3D animation",
              subtitle: "Hello world",
            ),
          ]),
        ),
      ])),
      floatingActionButton: isScrolledUp != true
          ? FloatingActionButton(
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.add),
              onPressed: () {},
            )
          : const SizedBox.shrink(),
      body: DefaultTabController(
          length: 10,
          initialIndex: 0,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool isInnerBoxScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: const Color.fromRGBO(11, 77, 110, 1),
                  // ignore: avoid_unnecessary_containers
                  leading: InkWell(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset("./assets/images/social.png")),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [
                  //     SizedBox(
                  //       width: 7,
                  //     ),
                  //     Icon(Icons.help),
                  //     Icon(Icons.notifications_on),
                  //   ],
                  // ),
                  centerTitle: false,
                  elevation: 2.0,
                  snap: true,
                  floating: true,
                  pinned: true,
                  title: const Text(
                    "roKney",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    InkWell(
                      child: IconLabel(
                        icon: Icons.search,
                        label: null,
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SearchScreen())),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MessageScreen())),
                      child: IconLabel(
                        icon: Icons.chat,
                        label: "2",
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      child: IconLabel(
                        icon: Icons.person_pin,
                        label: null,
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfilePage())),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                  bottom: const TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.deepOrange,
                      indicatorPadding: EdgeInsets.only(top: 4.0),
                      indicatorWeight: 5.0,
                      tabs: <Widget>[
                        TabContainer(
                          icon: Icons.home,
                          text: "Home",
                        ),
                        TabContainer(
                          icon: Icons.food_bank_sharp,
                          text: "Food",
                        ),
                        TabContainer(
                          icon: Icons.female,
                          text: "Date",
                        ),
                        TabContainer(
                          icon: Icons.restaurant_menu,
                          text: "Restaurant",
                        ),
                        TabContainer(
                          icon: Icons.sports,
                          text: "Sports",
                        ),
                        TabContainer(
                          icon: Icons.collections_sharp,
                          text: "Fashion",
                        ),
                        TabContainer(
                          icon: Icons.phone_iphone,
                          text: "Phones",
                        ),
                        TabContainer(
                          icon: Icons.book,
                          text: "Books",
                        ),
                        TabContainer(
                          icon: Icons.wash_outlined,
                          text: "Dry cleaning",
                        ),
                        TabContainer(
                          icon: Icons.fitness_center,
                          text: "Gym",
                        ),
                      ]),
                )
              ];
            },
            body: TabBarView(children: <Widget>[
              Home(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold(),
              Scaffold()
            ]),
          )),
    );
  }
}
