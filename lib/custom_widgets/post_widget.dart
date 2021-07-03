import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/profile_page.dart';
import 'package:rokney/screens/screens.dart';
import 'package:rokney/backends/backends.dart';

class PostContainer extends StatelessWidget {
  String? username, subtitle, action, text;
  bool? myPost;
  bool? verified;
  List<String>? images;
  UserProfile? userProfile;

  PostContainer(
      {this.myPost = false,
      this.userProfile,
      this.username,
      this.subtitle,
      this.images,
      this.text,
      this.verified,
      this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilePage(userProfile: userProfile))),
            child: PostCustomTile(
                verified: verified,
                profileImage: userProfile!.profileImage,
                myPost: myPost,
                name: username,
                subtitle: "posted by me"),
          ),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text(
                  "Here we sell some technology related stuffs @ affordable cost. Even you can call us for any website deals",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color))),
          Container(
            height: 200,
            width: double.infinity,
            child: PageView(
                scrollDirection: Axis.horizontal,
                children: List<Widget>.generate(
                  images!.length,
                  (index) => Image.asset(
                    images![index],
                    height: 200,
                  ),
                )),
          ),
          action != null
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
                                  images: images!,
                                  number_of_product: "3",
                                  price: 32900,
                                  product_name: "Itel S15",
                                  username: username,
                                ))),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      color: ColorPalette().mainColor,
                      padding: const EdgeInsets.only(top: 14, left: 10),
                      child: Text(
                        action!,
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
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Icon(
                    Icons.favorite_outline,
                    size: 30,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
              ),
              Text(
                "1.2k+",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
              const SizedBox(width: 7),
              Icon(
                Icons.comment,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              Text("300",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color)),
              const Expanded(child: SizedBox()),
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              minLines: 1,
              maxLines: 2,
              autofocus: false,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color),
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        // TODO
                      },
                      icon: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              child: Icon(Icons.send,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color)))),
                  hintText: "What do you feel about this?",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      )),
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class PostCustomTile extends StatelessWidget {
  String? name, subtitle, profileImage;
  bool? myPost, verified;

  PostCustomTile(
      {this.myPost = false,
      this.name,
      this.subtitle,
      this.profileImage,
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
                      backgroundImage: AssetImage(profileImage!),
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
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Icon(Icons.delete, color: Theme.of(context).primaryColor)
                    ],
                  )
                : Row(children: [
                    const Icon(Icons.message),
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
