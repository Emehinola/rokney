import 'package:flutter/material.dart';
import 'package:rokney/backends/backends.dart';
import 'package:rokney/backends/models.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfilePage extends StatefulWidget {
  // INSTANCE VARIABLE

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  QueryMutation _queryMutation = QueryMutation();
  String email = GraphQLConfiguration().box.get('myEmail');
  @override
  void dispose() async {
    // await Hive.deleteBoxFromDisk('account');
    super.dispose();
  }

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
                        child: const Hero(
                          tag: 'image',
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'http://10.0.2.2:8000/media/default.png')),
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
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProfileUpdateScreen())),
                            ),
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
                      Query(
                          // Widget for querying the database for profile
                          options: QueryOptions(
                              document: gql(_queryMutation.userInfo(email)),
                              pollInterval: const Duration(seconds: 5)),
                          builder: (
                            QueryResult result, {
                            VoidCallback? refetch,
                            FetchMore? fetchMore,
                          }) {
                            var data = result.data!['getUser']['profile'];
                            var username = result.data!['getUser']['username'];
                            List<String> professions = data['professions'].split(
                                ','); // changes the professions into  a List where they're separated by comma(,)
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  username,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(data['about'],
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data['address'],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${data['followers']} rokners",
                                      style: TextStyle(
                                          color: ColorPalette().mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      " * ${data['following']} rok",
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
                                data['professions']
                                        .toString()
                                        .isNotEmpty // Doesn't show the widget if profession is empty
                                    ? Container(
                                        // for professions and specialities
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        height: 80,
                                        width: size.width,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
                                              return const SizedBox(width: 10);
                                            },
                                            itemCount: professions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                width: size.width * 0.8,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[350],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      professions[index],
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                      )),
                                                ),
                                              );
                                            }))
                                    : const SizedBox.shrink(),
                              ],
                            );
                          }),
                      Container(
                        height: 10,
                        width: size.width,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        // for the posts the logged in user
                        "My posts",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // list of posts by the user
                      PostContainer(
                        text: 'My personal post',
                        userProfile: UserProfile(
                            about:
                                '"Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment"',
                            address: '"University of Lagos, Unilag\n Nigeria."',
                            followers: 32134,
                            following: 90,
                            username: 'Jumia',
                            profileImage: './assets/images/d1.png',
                            professions: ['Web dev', 'Build robots']),
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
