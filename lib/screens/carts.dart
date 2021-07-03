import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs_export.dart';

// FOR THE LIST OF ALL THE PRODUCTS ADDED TO CART BY THE LOGGED IN USER
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          PostContainer(
            action: "Checkout",
            images: const ["./assets/images/d1.png"],
            myPost: false,
            subtitle: "phone",
            username: "Jumia",
            verified: true,
          )
        ],
      ),
    );
  }
}
