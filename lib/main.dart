import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rokney/backends/graphql_config.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/screens/splash.dart';
import 'package:rokney/screens/welcome.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rokney/backends/backends.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('account'); // for storing the users login details
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: GraphQLProvider(
          client: GraphQLConfiguration().client, child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return MaterialApp(
        title: 'Rokney',
        debugShowCheckedModeBanner: false,
        theme: theme.getTheme(),
        home: Splash(),
      );
    });
  }
}
