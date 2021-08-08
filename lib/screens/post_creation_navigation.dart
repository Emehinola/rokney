import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/screens/screens.dart';

/* THIS IS A SCREEN FOR NAVIGATING THROUGH 
         DIFFERENT KINDS OF POSTS LIKE: PRODUCTS, JOB VACANCY, NORMAL POST AND SO */

class PostCreationNavigation extends StatefulWidget {
  @override
  _PostCreationNavigationState createState() => _PostCreationNavigationState();
}

class _PostCreationNavigationState extends State<PostCreationNavigation>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              child: Container(
                color: ColorPalette().mainColor,
                child: const TabBar(tabs: <Tab>[
                  Tab(
                    child: Text('Regular'),
                  ),
                  Tab(
                    child: Text('Product'),
                  ),
                  Tab(
                    child: Text('job'),
                  )
                ]),
              ),
              preferredSize: const Size(double.infinity, kToolbarHeight)),
          body: TabBarView(
            children: [CreatePost(), Scaffold(), Scaffold()],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
