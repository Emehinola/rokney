import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/post_widget.dart';
import 'package:rokney/backends/backends.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final PageStorageKey _key = const PageStorageKey(
  //     'home'); // for retaining the state of the scrolling of the page

  List usersProfileList =
      DatabaseMethod().getUsers(); // gets the list of all the users' profile

  List<Post> posts = DatabaseMethod().getPosts();
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation _queryMutation = QueryMutation();
  String loggedInUserEmail = GraphQLConfiguration().box.get('myEmail');

  // check post ownership
  bool myPost(String postOwner) {
    if (loggedInUserEmail == postOwner) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // key: _key,
        body: Query(
            options: QueryOptions(
              // pollInterval: const Duration(seconds: 1),
              document: gql(_queryMutation.getPosts()),
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              // number of available posts
              var lengthOfResults = result.data!['posts'].length;

              return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey[300],
                      height: 10,
                    );
                  },
                  itemCount: lengthOfResults,
                  itemBuilder: (BuildContext context, int index) {
                    // getting the nedded queries
                    var resultData = result.data!['posts'][index];
                    var postContents = resultData['content'];
                    var tag = resultData['subtitle'];
                    var ownerUsername = resultData['user']['username'];
                    var verified = resultData['user']['profile'][
                        'verifiedUser']; // returns true if the user is a verified user
                    var profileImageUrl =
                        "http://10.0.2.2:8000/media/${resultData['user']['profile']['imageUrl']}";

                    var lengthOfImages = resultData['filealbumSet'].length;
                    var images = resultData['filealbumSet']; // list of images

                    // getting list of images with their urls associated with each post
                    var postImages = List<String>.generate(
                        lengthOfImages,
                        (int index) =>
                            'http://10.0.2.2:8000/media/${images[index]['images']}');

                    // checking for post ownership
                    var ownerEmail = resultData['user']['email'];

                    // getting post likes
                    int numberOfLikes = resultData['likeSet'].length;
                    int numberOfComments = resultData['commentSet'].length;

                    bool likedByMe =
                        false; // for checking if the logged in user likes a particular post

                    if (numberOfLikes != 0) {
                      // gets user who liked a post by his/her email
                      for (var i = 0; i < numberOfLikes; i++) {
                        if (resultData['likeSet'][i]['user']['email'] ==
                            loggedInUserEmail) {
                          likedByMe = true;
                          break;
                        } else {
                          continue;
                        }
                      }
                    } else {
                      likedByMe = false;
                    }

                    // post_id
                    int postId = int.parse(resultData['id']);

                    if (result.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return PostContainer(
                        likedByMe: likedByMe,
                        likes: numberOfLikes,
                        numberOfComments: numberOfComments,
                        postId: postId,
                        userEmail: ownerEmail,
                        profileImageUrl: profileImageUrl,
                        myPost: myPost(ownerEmail),
                        verified: verified,
                        images: postImages,
                        text: postContents,
                        subtitle: tag,
                        username: ownerUsername,
                      );
                    }
                  });
            }));
  }
}
