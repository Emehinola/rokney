import 'package:flutter/material.dart';
import 'package:rokney/custom_widgets/color_palette.dart';

// for each chat

class ChatScreen extends StatefulWidget {
  final String? username;

  ChatScreen({this.username});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette().mainColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.username!),
            const Text("Online",
                style: TextStyle(fontSize: 12, color: Colors.green))
          ],
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Hello dear",
                                style: TextStyle(
                                    color: ColorPalette()
                                        .darkForeground(context))),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15)),
                                color: Theme.of(context).primaryColor),
                          ),
                          Text("07: 21AM",
                              style: TextStyle(
                                  color:
                                      ColorPalette().darkForeground(context)))
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "I'm good and fine",
                              style: TextStyle(
                                  color:
                                      ColorPalette().darkForeground(context)),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)),
                                color: Theme.of(context).primaryColor),
                          ),
                          Text(
                            "08:34 PM",
                            style: TextStyle(
                                color: ColorPalette().darkForeground(context)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  color: ColorPalette().mainColor,
                  height: 66,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: TextField(
                        minLines: 1,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.white)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 3.0),
                            prefixIcon: const Icon(Icons.keyboard),
                            hintText: "write message here...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      )),
                      MaterialButton(
                        onPressed: () {
                          print("message sent!");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          child: const Icon(Icons.send),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        );
      }),
    );
  }
}
