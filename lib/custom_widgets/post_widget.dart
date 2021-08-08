import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/profile_page.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/backends/backends.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PostContainer extends StatefulWidget {
  String? subtitle, action, text;
  String username, userEmail;
  bool likedByMe; // used to get if a user has liked a post or not
  bool myPost;
  bool? verified;
  List<String>? images;
  int postId;
  int likes;
  int numberOfComments;
  String profileImageUrl;

  PostContainer(
      {required this.myPost,
      required this.profileImageUrl,
      required this.username,
      required this.userEmail,
      required this.postId,
      required this.likes,
      required this.likedByMe,
      required this.numberOfComments,
      this.subtitle,
      this.images,
      this.text,
      this.verified,
      this.action});

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  bool showCommentBox = true;
  bool shrinkHeight = false;

  TextEditingController _commentController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation mutation = QueryMutation();

  double height = 0;
  bool liked = false;

  @override
  void initState() {
    liked = widget.likedByMe;
    super.initState();
  }

  void getAction() {
    shrinkHeight = !shrinkHeight;
    setState(() {
      showCommentBox = false;
      height = shrinkHeight ? 90 : 0;
    });
  }

  dynamic email = GraphQLConfiguration()
      .box
      .get('myEmail'); // gets the logged in user's email

  // method for liking post
  void likePost(int postId) {
    _graphQLConfiguration
        .clientToQuery()
        .mutate(MutationOptions(
            document: gql(mutation.createLike()),
            variables: {"userEmail": email, "postId": postId}))
        .then((value) {
      setState(() {
        //
        liked = !liked;
      });
    });
  }

  void createComment() {
    // checks if the form field for the comment i not empty
    if (_key.currentState!.validate()) {
      _graphQLConfiguration
          .clientToQuery()
          .mutate(MutationOptions(
              document: gql(mutation.createComment()),
              variables: {
                "email": email,
                "postId": widget.postId,
                "content": _commentController.text
              }))
          .then((value) {
        _commentController.clear();
        if (!value.isLoading) {
          // navigates to comments screen when commet has been submitted
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CommentScreen(postId: widget.postId)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProfilePage(
                            userEmail: widget
                                .userEmail, // userEmail is used in the profile ppage to get the associated profile
                            myProfile: !widget.myPost
                                ? false
                                : true, // sends false if its not loggedin user's post
                          ))),
              child: PostCustomTile(
                  verified: widget.verified,
                  profileImageUrl: widget.profileImageUrl,
                  myPost: widget.myPost,
                  name: widget.username,
                  subtitle: widget.subtitle),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text(widget.text ?? '',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color))),
          widget.images!.isNotEmpty
              ? InkWell(
                  onDoubleTap: () => likePost(widget.postId),
                  child: Container(
                    height: 300,
                    child: PageView(
                        scrollDirection: Axis.horizontal,
                        children: List<Widget>.generate(
                            widget.images!.length,
                            (index) => Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.images![index]))),
                                ))),
                  ),
                )
              : SizedBox.shrink(),
          widget.action != null
              ? Material(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProductCheckoutScreen(
                                  category: "phones",
                                  description: "This is a phone",
                                  features:
                                      "Fine and a very neat phone with affordable cost",
                                  images: widget.images!,
                                  number_of_product: "3",
                                  price: 32900,
                                  product_name: "Itel S15",
                                  username: widget.username,
                                ))),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: ColorPalette().mainColor,
                      padding: const EdgeInsets.only(top: 14, left: 10),
                      child: Text(
                        widget.action!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Container(
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: (widget.likedByMe | liked)
                        ? IconButton(
                            onPressed: () => likePost(widget.postId),
                            icon: const Icon(
                              Icons.favorite,
                              size: 30,
                              color: Colors.deepOrange,
                            ),
                          )
                        : IconButton(
                            onPressed: () => likePost(widget.postId),
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              size: 30,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                  ),
                ),
                Text(
                  "${widget.likes}",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                verticalDivider(context),
                IconButton(
                  onPressed: () => getAction(),
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                Text("${widget.numberOfComments}",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                verticalDivider(context),
                IconButton(
                  onPressed: () => getAction(),
                  icon: const Icon(Icons.share_outlined),
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
                Text("300",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        alignment: Alignment.center,
                        child: const Text(
                          "price",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(
                        width: 2.0,
                      ),
                      Container(
                        height: 40,
                        width: 80,
                        alignment: Alignment.center,
                        child: const Text(
                          "\$4,021",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            color: ColorPalette().mainColor),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
          // ANIMATION FOR SHOWING COMMENT BOX TO BE ADDED

          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: height,
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            onEnd: () {
              setState(() {
                showCommentBox = !showCommentBox;
              });
            },
            child: Visibility(
              visible: showCommentBox,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Text("view comments...",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color)),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CommentScreen(
                                  postId: widget.postId,
                                ))),
                  ),
                  Form(
                    key: _key,
                    child: TextFormField(
                      validator: (value) {
                        if (value == "") {
                          return "Empty comment";
                        } else {
                          return null;
                        }
                      },
                      controller: _commentController,
                      minLines: 1,
                      maxLines: 1,
                      autofocus: false,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color),
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                          suffix: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: InkWell(
                              onTap: () => createComment(),
                              child: const Text("send",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                          hintText: "What do you feel about this?",
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.grey,
                          )),
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          border: const UnderlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostCustomTile extends StatelessWidget {
  String? name, subtitle;
  String profileImageUrl;
  bool? myPost, verified;

  PostCustomTile(
      {this.myPost = false,
      this.name,
      this.subtitle,
      required this.profileImageUrl,
      this.verified = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorPalette().mainColor, width: 1.0),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(profileImageUrl),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        verified!
                            ? Icon(
                                Icons.verified,
                                size: 16,
                                color: Theme.of(context).primaryColor,
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      subtitle!,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).textTheme.subtitle1!.color),
                    )
                  ],
                ),
              ],
            ),
            myPost!
                ? Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Icon(
                        Icons.delete_outlined,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      )
                    ],
                  )
                : Row(children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.bookmark_border_outlined,
                      color: Theme.of(context).primaryColor,
                    )
                  ])
          ],
        ));
  }
}
