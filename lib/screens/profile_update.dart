import 'package:flutter/material.dart';
import 'package:rokney/backends/backends.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rokney/screens/profile_page.dart';

// SCREEN FOR UPDATING PROFILE BY THE USER

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  // controllers for each of the text field for updating the profile
  TextEditingController usernameContrl = TextEditingController();
  TextEditingController bioCtrl = TextEditingController();
  TextEditingController aboutCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  TextEditingController profCtrl = TextEditingController();

  // Grpahql
  final GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  final QueryMutation _queryMutation = QueryMutation();

  OutlineInputBorder enabledBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green));
  }

  @override
  void initState() {
    String email = _graphQLConfiguration.box.get('myEmail');
    // getting the previos profile of the user and use it to populate the fields
    _graphQLConfiguration
        .clientToQuery()
        .query(QueryOptions(document: gql(_queryMutation.userInfo(email))))
        .then((returnedValue) {
      var data = returnedValue.data!['getUser'];

      usernameContrl.text = data['username'];
      bioCtrl.text = data['profile']['bio'];
      aboutCtrl.text = data['profile']['about'];
      addressCtrl.text = data['profile']['address'];
      profCtrl.text = data['profile']['professions'];
    });

    super.initState();
  }

  //  method to update user's profile
  void updateProfile() {
    // getting the fields
    String email = _graphQLConfiguration.box.get('myEmail');
    String username = usernameContrl.text;
    String bio = bioCtrl.text;
    String about = aboutCtrl.text;
    String address = addressCtrl.text;
    String professions = profCtrl.text;

    // update the database with user's new profile data
    _graphQLConfiguration
        .clientToQuery()
        .mutate(MutationOptions(
            document: gql(_queryMutation.updateProfile()),
            variables: {
              "userEmail": email,
              "username": username,
              "bio": bio,
              "about": about,
              "professions": professions,
              "address": address
            }))
        .then((returnedValue) {
      var result = returnedValue.data!['updateProfile'];
      if (result['success']) {
        Navigator.pop(context); // back to profile page
      } else {
        //
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette().mainColor,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("rokney app"),
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;

          return Center(
            child: Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: SingleChildScrollView(
                  child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Text("update your profile",
                          style: TextStyle(fontSize: 20)),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        enabled: false,
                        controller: usernameContrl,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: enabledBorder(),
                            helperText: 'Username',
                            suffixIcon: const Icon(Icons.verified_sharp),
                            hintText: 'Samuel'),
                      ),
                      const Divider(),
                      TextField(
                        controller: bioCtrl,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: enabledBorder(),
                            helperText: 'bio',
                            suffixIcon: const Icon(Icons.verified_sharp),
                            hintText: 'Hello world'),
                      ),
                      const Divider(),
                      TextField(
                        controller: aboutCtrl,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: enabledBorder(),
                            helperText: 'about',
                            suffixIcon: const Icon(Icons.verified_sharp),
                            hintText: 'About me'),
                      ),
                      const Divider(),
                      TextField(
                        controller: addressCtrl,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: enabledBorder(),
                            helperText: 'address',
                            suffixIcon: const Icon(Icons.verified_sharp),
                            hintText: '8, olawole'),
                      ),
                      const Divider(),
                      TextField(
                        controller: profCtrl,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            enabledBorder: enabledBorder(),
                            helperText:
                                'professions[separate each value by a comma(,)]',
                            suffixIcon: const Icon(Icons.verified_sharp),
                            hintText: 'professions'),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          child: CustomButton(
                            text: 'Update',
                          ),
                          onTap: () => updateProfile(),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        }),
      ),
    );
  }
}
