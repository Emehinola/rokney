import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rokney/backends/backends.dart';

class CommentScreen extends StatelessWidget {
  int postId; // for getting the id of the post to display it's comments
  CommentScreen({required this.postId});

  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation _query = QueryMutation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette().mainColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios)),
        title: const Text("comments"),
      ),
      body: Query(
        options: QueryOptions(
            pollInterval: const Duration(seconds: 1),
            document: gql(_query.getComment()),
            variables: {"postId": postId}),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return const Center(child: Text("Loading comments..."));
          } else {
            if (result.data!['comments'].isEmpty) {
              return const Center(
                child: Text("No comments here yet"),
              );
            } else {
              // getting returned values
              var listOfComments = result.data!['comments'];
              var numberOfComments = listOfComments.length;

              return ListView.builder(
                  itemCount: numberOfComments,
                  itemBuilder: (BuildContext context, int index) {
                    String username = listOfComments[index]['user']['username'];
                    var time = listOfComments[index]['time'];
                    var userImgUrl =
                        "http://10.0.2.2:8000/media/${listOfComments[index]['user']['profile']['imageUrl']}"; // for the image of the owner of the comment
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200]),
                          child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(userImgUrl)),
                            title: Text.rich(
                              TextSpan(
                                  text: "${listOfComments[index]['content']}__",
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: username,
                                        style: TextStyle(
                                            color: ColorPalette().mainColor))
                                  ]),
                            ),
                            subtitle: Text(time),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.favorite, color: Colors.red, size: 15),
                              SizedBox(
                                width: 7,
                              ),
                              Text("reply"),
                            ],
                          ),
                          padding: EdgeInsets.only(right: 10),
                        )
                      ],
                    );
                  });
            }
          }
        },
      ),
    );
  }
}
