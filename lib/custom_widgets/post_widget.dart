import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/screens.dart';

class PostContainer extends StatelessWidget {
  String? username, subtitle, image, action;
  bool? myPost;
  bool? verified;

  PostContainer(
      {this.myPost = false,
      this.username,
      this.subtitle,
      this.image,
      this.verified,
      this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostCustomTile(
              verified: verified,
              image: image,
              myPost: myPost,
              name: "Emehinola",
              subtitle: "posted by me"),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: const Text(
                  "Here we sell some technology related stuffs @ affordable cost. Even you can call us for any website deals")),
          Image.asset(image!),
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
                                  images: const ['./assets/images/d1.png'],
                                  number_of_product: "3",
                                  price: 32900,
                                  product_name: "Itel S15",
                                  title: "phone",
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
            child: Row(children: const [
              Icon(
                Icons.favorite_outline,
                size: 30,
                color: Colors.black,
              ),
              Text("1.2k+"),
              SizedBox(width: 7),
              Icon(Icons.comment),
              Text("300")
            ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              minLines: 1,
              maxLines: 2,
              autofocus: false,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        // TODO
                      },
                      icon: const Icon(Icons.send)),
                  hintText: "What do feel about this?",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ],
      ),
    );
  }
}

class PostCustomTile extends StatelessWidget {
  String? name, subtitle, image;
  bool? myPost, verified;

  PostCustomTile(
      {this.myPost = false,
      this.name,
      this.subtitle,
      this.image,
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
                      borderRadius: BorderRadius.circular(80),
                    ),
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(image!),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                      style: const TextStyle(fontSize: 12),
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
                    const Icon(Icons.shopping_cart_outlined),
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
