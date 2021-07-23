import 'package:flutter/material.dart';
import 'package:rokney/backends/graphql_config.dart';
import 'package:rokney/backends/graphql_queries.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/navigation_screen.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/backends/backends.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GraphQLConfiguration _graphQLConfiguration =
      GraphQLConfiguration(); // graphql config
  QueryMutation _queryMutation =
      QueryMutation(); // for the string to be posted to the url

  String? errorMessage; // for returning error for authentication

  bool isLoading = false; // for controlling progress indicatior

  final _key = GlobalKey<FormState>();

  // login function
  void login(String email, String password) async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      //  authenticating user's data
      var client = _graphQLConfiguration.clientToQuery();
      // print("box: ${_graphQLConfiguration.box.values}");

      var result = await client.mutate(MutationOptions(
          document: gql(_queryMutation.login(email, password))));

      // getting data from result
      if (result.data!['login']['success']) {
        client
            .mutate(MutationOptions(
                document: gql(_queryMutation.authenticate(email, password))))
            .then((value) {
          if (value.data!['tokenAuth']['success']) {
            _graphQLConfiguration.box
              ..put('loggedIn', true) // sets that the user is logged in
              ..put('myEmail',
                  email); // sets the logged in user email in cache memory

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NavigationScreen()));
          } else {
            //
          }
        });
      } else {
        setState(() {
          isLoading = false;
        });
        if (result.data!['login']['errors'] != null) {
          setState(() {
            errorMessage = result.data!['login']['errors'];
          });
        } else {
          //
        }
      }
    } else {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight; // the height of the screen
        double width = constraints.maxWidth; // the width of he screen

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("./assets/images/social.png"),
                  height: height * 0.3,
                  width: width * 0.3,
                ),
                Text(
                  errorMessage ?? 'Sign in to your account',
                  style: TextStyle(
                      color: errorMessage != null
                          ? Colors.red
                          : Theme.of(context).textTheme.bodyText1!.color),
                ),
                Container(
                  // height: height * 0.5,
                  width: width * 0.8,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // image: const DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: AssetImage("./assets/images/bg.png")),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                            validator: (email) {
                              // validates the email entered by the user
                              if (RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-zA-Z]\$")
                                  .hasMatch(email!)) {
                                return null;
                              } else {
                                return 'Invalid email address';
                              }
                            },
                            controller: _emailController,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color ??
                                          Colors.green)),
                              hintText: "email",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffix: isLoading
                                  ? const CircularProgressIndicator()
                                  : null,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                            )),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        TextFormField(
                            validator: (password) {
                              // validates that the password is of the correct order
                              if (password!.length >= 3) {
                                return null;
                              } else {
                                return 'Incorrect password';
                              }
                            },
                            controller: _passwordController,
                            obscureText: true,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color ??
                                          Colors.green)),
                              hintText: "password",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffix: isLoading
                                  ? const CircularProgressIndicator()
                                  : null,
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.green,
                              ),
                            )),
                        Container(),
                        SizedBox(
                          height: height * 0.05,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () =>
                      login(_emailController.text, _passwordController.text),
                  child: CustomButton(
                    text: "LOGIN",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text("Don't have an account yet?",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUp())),
                  child: CustomButton(
                    text: "SIGN UP",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text("Forgot your password?",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RecoverPassword())),
                  child: CustomButton(
                    text: "RECOVER PASSWORD",
                  ),
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        );
      }),
    );
  }
}
