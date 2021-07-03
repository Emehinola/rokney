import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';

class ProductCheckoutScreen extends StatefulWidget {
  final String? description,
      features,
      username,
      product_name,
      category,
      number_of_product;

  final List<String>? images;

  final double? price;

  ProductCheckoutScreen(
      {this.category,
      this.images,
      this.description,
      this.features,
      this.number_of_product,
      this.price,
      this.product_name,
      this.username});
  @override
  _ProductCheckoutScreenState createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette().mainColor,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.product_name!),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight; // the availbale height
        double width = constraints.maxWidth; // the available width

        return Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: PostCheckoutContainer(
                        image: widget.images![0],
                        myPost: false,
                        subtitle: widget.category,
                        username: widget.username,
                        verified: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: width,
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            child: const Text(
                              "price",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
                            height: 50,
                            width: 100,
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text("Description",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "The description is here for us to be able to see what the product is all about ",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text("Features",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Good and durable battery life\nBeautiful design\nCheap and affordable\n2-years warranty is given",
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text("Delivery location",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .color)),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          textInputAction: TextInputAction.newline,
                          maxLines: 5,
                          minLines: 4,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        )),
                    const SizedBox(
                      height: 70,
                    )
                  ])),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  alignment: Alignment.center,
                  height: 50,
                  color: ColorPalette().mainColor,
                  child: MaterialButton(
                    onPressed: () => {},
                    child: const Text(
                      "Checkout",
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ),
                ))
          ],
        );
      }),
    );
  }
}

class PostCheckoutContainer extends StatelessWidget {
  String? username, subtitle, image;
  bool? myPost;
  bool? verified;

  PostCheckoutContainer(
      {this.myPost = false,
      this.username,
      this.subtitle,
      this.image,
      this.verified});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostCustomTile(
              verified: verified,
              profileImage: image,
              myPost: myPost,
              name: username,
              subtitle: subtitle),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: Text(
                "Here we sell some technology related stuffs @ affordable cost. Even you can call us for any website deals",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              )),
          Image.asset(image!),
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Row(children: [
              Icon(Icons.favorite_outline,
                  size: 30,
                  color: Theme.of(context).textTheme.bodyText1!.color),
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
              Text(
                "300",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              )
            ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              minLines: 1,
              maxLines: 2,
              textInputAction: TextInputAction.newline,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Colors.grey)),
                  suffixIcon: IconButton(
                      onPressed: () {
                        // TODO
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                  hintText: "What do feel about this?",
                  hintStyle: TextStyle(
                      color: Theme.of(context).textTheme.subtitle1!.color),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey))),
            ),
          ),
        ],
      ),
    );
  }
}
