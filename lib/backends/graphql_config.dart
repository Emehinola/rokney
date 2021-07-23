import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink('http://10.0.2.2:8000/graphql/');

  var box = Hive.box('account'); // cached box for storing users histories

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore(Hive.box('account')))));

  GraphQLClient clientToQuery() {
    return GraphQLClient(
        link: httpLink, cache: (GraphQLCache(store: HiveStore(box))));
  }
}
