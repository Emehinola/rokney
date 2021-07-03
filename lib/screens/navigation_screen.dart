import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rokney/backends/models.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/profile_page.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/screens/settings.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  bool? isScrolledUp;

  final PageStorageBucket _bucket = PageStorageBucket();

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
          // for the header
          height: 200,
          width: double.infinity,
          color: ColorPalette().mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: const Chip(
                            label: Text("Settings"),
                            avatar: Icon(Icons.settings),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SettingScreen())),
                        ),
                        const Chip(
                          label: Text("Logout"),
                          avatar: Icon(Icons.exit_to_app),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        Container(
          height: size.height - 200,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: ListView(children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Bookmarks",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color),
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
                  child: Text(
                    "Read more",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                )),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Carts | How tos",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color),
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
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PostCreationNavigation()));
              },
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
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: IconLabel(
                          icon: Icons.person_pin,
                          label: null,
                        ),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => ProfilePage(
                                      userProfile: UserProfile(
                                          about:
                                              '"Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment"',
                                          address: '"University of Lagos, Unilag\n Nigeria."',
                                          followers: 32134,
                                          following: 90,
                                          profileImage: './assets/images/d1.png',
                                          professions: [
                                            'Web dev',
                                            'Build robots'
                                          ]),
                                    ))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                  bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorPadding: EdgeInsets.only(top: 4.0),
                      indicatorWeight: 3.0,
                      tabs: const <Widget>[
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
