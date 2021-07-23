import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:rokney/custom_widgets/customs.dart';
import 'package:rokney/screens/screens.dart';

// custom button
class CustomButton extends StatelessWidget {
  final text;

  CustomButton({this.text});

  @override
  Widget build(BuildContext context) {
    LinearGradient buttonGradient = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.pink, Colors.orange, Color.fromRGBO(11, 77, 110, 1)]);

    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 300,
      child: Center(
          child: Text("$text",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ))),
      decoration: BoxDecoration(
          gradient: buttonGradient, borderRadius: BorderRadius.circular(30)),
    );
  }
}

// for custom designed Icons
class CustomIcon extends StatelessWidget {
  final IconData? icon;

  const CustomIcon({Key? key, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        icon,
        size: 35,
      ),
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white)),
          color: Colors.transparent),
    );
  }
}

// TabBar's items
class TabContainer extends StatelessWidget {
  final IconData? icon;
  final String? text;

  const TabContainer({this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(),
      child: Row(
        children: [
          Icon(icon),
          Text(
            text!,
          )
        ],
      ),
    );
  }
}

// Creating icons with label
class IconLabel extends StatelessWidget {
  IconData? icon;
  String? label;

  IconLabel({this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      height: 30,
      width: 50,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white))),
            child: Icon(icon, size: 30),
          ),
          label != null
              ? Positioned(
                  top: -1,
                  right: 1,
                  child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        label!,
                        style: const TextStyle(color: Colors.white),
                      )))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

// ordinary label
class OrdinaryLabel extends StatelessWidget {
  final String? text;

  OrdinaryLabel({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30)),
      child: Text(
        text!,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

// Widget for each of friend's chat

class CustomTile extends StatelessWidget {
  String? name, subtitle, chatNumber, image, Ordertype;

  CustomTile(
      {this.name, this.subtitle, this.chatNumber, this.image, this.Ordertype});

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
                  height: 60,
                  width: 60,
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProfileImage())),
                    child: Hero(
                      tag: 'image',
                      child: CircleAvatar(
                        backgroundImage: AssetImage(image!),
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                  const SizedBox(height: 5.0),
                  Text(subtitle!,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle1!.color))
                ],
              ),
            ],
          ),
          chatNumber != null
              ? Row(
                  children: [
                    Text(
                      Ordertype!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    OrdinaryLabel(
                      text: chatNumber,
                    )
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

// build snackbar
SnackBar snackBar(String message, IconData icon) {
  return SnackBar(
    backgroundColor: Colors.white,
    duration: const Duration(seconds: 3),
    content: Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      height: 30,
      width: double.infinity,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(icon),
          Text(message, style: const TextStyle(fontSize: 16, color: Colors.red))
        ],
      )),
    ),
  );
}
