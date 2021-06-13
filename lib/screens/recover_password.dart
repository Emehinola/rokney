import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/custom_widgets/customs_export.dart';
import 'package:rokney/screens/screens.dart';

class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight; // the height of the screen
        double width = constraints.maxWidth; // the width of he screen

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset("./assets/images/social.png"),
                height: height * 0.3,
                width: width * 0.3,
              ),
              Container(
                // height: height * 0.5,
                width: width * 0.8,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "email",
                          prefixIcon: Icon(Icons.email),
                        )),
                    Container(),
                    SizedBox(
                      height: height * 0.05,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CustomButton(
                text: "RECOVER PASSWORD",
              ),
            ],
          ),
        );
      }),
    );
  }
}
