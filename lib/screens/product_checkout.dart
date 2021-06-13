import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';

class ProductCheckoutScreen extends StatefulWidget {
  final String? description,
      features,
      title,
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
      this.title});
  @override
  _ProductCheckoutScreenState createState() => _ProductCheckoutScreenState();
}

class _ProductCheckoutScreenState extends State<ProductCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.white,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: PostCheckoutContainer(
                        image: './assets/images/social.png',
                        myPost: false,
                        subtitle: widget.category,
                        username: "Jumia",
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
                      child: const Text("Description",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                          "The description is here for us to be able to see what the product is all about "),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text("Features",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                          "Good and durable battery life\nBeautiful design\nCheap and affordable\n2-years warranty is given"),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text("Delivery location",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          textInputAction: TextInputAction.newline,
                          maxLines: 5,
                          minLines: 4,
                          decoration: InputDecoration(
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
              image: image,
              myPost: myPost,
              name: username,
              subtitle: subtitle),
          Container(
              margin: const EdgeInsets.all(5.0),
              child: const Text(
                  "Here we sell some technology related stuffs @ affordable cost. Even you can call us for any website deals")),
          Image.asset(image!),
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              minLines: 1,
              maxLines: 2,
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
