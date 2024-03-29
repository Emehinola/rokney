import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rokney/backends/models.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/profile_page.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/screens/settings.dart';
import 'package:rokney/backends/backends.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool? isScrolledUp;

  StreamSubscription? subscription;

  // scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final PageStorageBucket _bucket = PageStorageBucket();

  GraphQLConfiguration _graphQLConfiguration =
      GraphQLConfiguration(); // for controlling the HiveStore to log out the user

  QueryMutation _queryMutation = QueryMutation();

  // for querying database
  DatabaseMethod _databaseMethod = DatabaseMethod();
  CheckInternet internet =
      CheckInternet(); // class defined in internet.dart file, for getting connection's state

  var client = GraphQLConfiguration().clientToQuery();

  // logout the loggedIn user
  void logOut(BuildContext context) {
    _graphQLConfiguration.box
      ..put('loggedIn', false)
      ..put('myEmail', null).then((_) => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login())));
  }

  @override
  void initState() {
    subscription = Connectivity().onConnectivityChanged.listen((event) {
      internet.checkConnection(event).then((value) {
        // checks if user is connected to internet source like data or wifi
        if (value) {
          // check if internet is not accessible, maybe no data sub, lol
          internet.checkInternet().then((value) {
            if (value) {
              print("confirmed");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBar("No data connection on device", Icons.info));
            }
          });
        } else {
          // if there is no internet connection
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar("No internet connection on device", Icons.info));
        }
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isScrolledUp = true;
        });
      } else if (_scrollController.position.userScrollDirection ==
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
    ScaffoldMessenger.of(context).clearSnackBars();
    _scrollController.dispose();
    subscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // FocusScope.of(context).unfocus(); // for removing the focus of the text input field

    return Scaffold(
      key: scaffoldKey,
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
                        GestureDetector(
                          onTap: () => logOut(context),
                          child: const Chip(
                            label: Text("Logout"),
                            avatar: Icon(Icons.exit_to_app),
                          ),
                        )
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
                  pinned: false,
                  title: const Text(
                    "rokney",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vidaloka-Regular'),
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
                                  builder: (BuildContext context) =>
                                      ProfilePage(
                                        myProfile: true,
                                      )))),
                    ),
                  ],
                  bottom: TabBar(
                      isScrollable: true,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorPadding: EdgeInsets.zero,
                      indicatorWeight: 3.0,
                      tabs: <Widget>[
                        chipWidget(Icons.home, 'home'),
                        chipWidget(Icons.bed, 'appartment'),
                        chipWidget(Icons.book, 'book'),
                        chipWidget(Icons.food_bank_rounded, 'food'),
                        chipWidget(Icons.book_rounded, 'tutorial'),
                        chipWidget(Icons.ac_unit, 'clothes'),
                        chipWidget(Icons.ac_unit, 'shoes'),
                        chipWidget(Icons.phone, 'phones and accessories'),
                        chipWidget(Icons.wash, 'laundry'),
                        chipWidget(Icons.fitness_center_sharp, 'gym'),
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
