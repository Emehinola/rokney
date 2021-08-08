import 'package:flutter/material.dart';
import 'package:rokney/backends/backends.dart';
import 'package:rokney/screens/login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rokney/screens/navigation_screen.dart';
import 'package:rokney/screens/welcome.dart';

// immediate screen to verify if user is already logged in or not
class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();

  QueryMutation _queryMutation = QueryMutation();
  bool loading = true; // sets for progress indicator

  bool detailAvailable() {
    var box = _graphQLConfiguration.box;
    Map<String, dynamic> data = {
      'email': box.get('myEmail'),
      'password': box.get('password')
    };

    if ((data['email'] == null) | (data['password'] == null)) {
      return false;
    }

    return true;
  }

  Future<dynamic> login() async {
    var box = _graphQLConfiguration.box;
    Map<String, dynamic> data = {
      'email': box.get('myEmail'),
      'password': box.get('password')
    };

    var result = await _graphQLConfiguration.clientToQuery().mutate(
            MutationOptions(document: gql(_queryMutation.login()), variables: {
          "username": data['email'],
          "password": data['password']
        }));

    return result;
  }

  AlertDialog showAlertDialog() {
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => print("canceled"),
          child: Text("Canceled"),
        ),
        ElevatedButton(onPressed: () => print("Ok"), child: Text("Ok"))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
          child: detailAvailable()
              ? FutureBuilder(
                  future: login(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if ((snapshot.connectionState ==
                        ConnectionState.done)) {
                      // login user
                      return NavigationScreen();
                    } else {
                      // print("error: ${snapshot.data!['login']['errors']}");
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 10),
                          Text(snapshot.error.toString(),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color))
                        ],
                      );
                    }
                  })
              : WelcomePage()),
    );
  }
}
