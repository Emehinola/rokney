import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokney/backends/graphql_config.dart';
import 'package:rokney/backends/graphql_queries.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/login.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/backends/backends.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // controllers
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  // error strings
  String? usernameError, emailError, passwordError;

  // GrpahQL configs
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation queryMutation = QueryMutation();

  // indicator
  bool isLoading = false;

  final _key = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  void createUserAccount(email, username, password) async {
    // function for creating user

    // checks if the user entered the correct input format for each input field
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      var client =
          _graphQLConfiguration.clientToQuery(); // returns the signUP link
      var result = await client.mutate(MutationOptions(
          document: gql(queryMutation.register(email, username, password)),
          onError: (error) {
            print("OnError: ${error.toString()}");
          }));

      if (result.data!['register']['success']) {
        client
            .mutate(MutationOptions(
                document: gql(queryMutation.login(email, password))))
            .then((value) {
          if (value.data!['login']['success']) {
            _graphQLConfiguration.box.put('loggedIn', true);
            _graphQLConfiguration.box
              ..put('myEmail', email)
              ..put('username', username)
              ..put('password',
                  password); // saves the user's data to the local device
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

        // custom error for email
        if (result.data!['register']['errors']['email'] != null) {
          setState(() {
            emailError =
                result.data!['register']['errors']['email'][0]['message'];
          });
        }

        // custom error for username
        if (result.data!['register']['errors']['username'] != null) {
          setState(() {
            usernameError =
                result.data!['register']['errors']['username'][0]['message'];
          });
        }

        if (result.data!['register']['errors']['password'] != null) {
          setState(() {
            passwordError =
                result.data!['register']['errors']['password'][0]['message'];
          });
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
                  isLoading ? 'Validating...' : 'Create a new Account!',
                  style: TextStyle(
                      color: isLoading
                          ? Colors.green
                          : Theme.of(context).textTheme.bodyText1!.color),
                ),
                Container(
                  // height: height * 0.5,
                  width: width * 0.8,
                  padding: EdgeInsets.all(10),
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
                              // validates the email in correct format
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
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color ??
                                          Colors.green)),
                              hintText: "email",
                              errorText: emailError,
                              suffix: isLoading
                                  ? const CircularProgressIndicator()
                                  : null,
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                            validator: (username) {
                              // validates that the password is of the correct order
                              if (username!.length >= 3) {
                                return null;
                              } else {
                                return 'Username must be longer than 2 characters';
                              }
                            },
                            controller: _usernameController,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color ??
                                          Colors.green)),
                              hintText: "username",
                              errorText: usernameError,
                              suffix: isLoading
                                  ? const CircularProgressIndicator()
                                  : null,
                              hintStyle: const TextStyle(color: Colors.grey),
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.green),
                            )),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextFormField(
                            validator: (password) {
                              // validates that the password is of the correct order
                              if (password!.length >= 4) {
                                return null;
                              } else {
                                return 'Password must be greater than 6 characters';
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
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color ??
                                          Colors.green)),
                              hintText: "password",
                              errorText: passwordError,
                              suffix: isLoading
                                  ? const CircularProgressIndicator()
                                  : null,
                              hintStyle: const TextStyle(color: Colors.grey),
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
                GestureDetector(
                  child: CustomButton(
                    text: "SIGN UP",
                  ),
                  onTap: () {
                    FocusNode().unfocus;
                    createUserAccount(_emailController.text,
                        _usernameController.text, _passwordController.text);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login())),
                  child: CustomButton(
                    text: "LOGIN",
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  "Forgot your password?",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
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
