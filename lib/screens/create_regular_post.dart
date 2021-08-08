import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokney/backends/backends.dart';
import 'package:image_picker/image_picker.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// screen for creating normal regular post by users

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<XFile>? pickedImages, images;
  ImagePicker _picker = ImagePicker();
  List<MultipartFile> multipartImages = [];

  // text field controller
  TextEditingController contentController = TextEditingController();

  // form key
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  //
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation _mutation = QueryMutation();

  late String loggedInUserEmail;
  bool uploading = false;

  void pickImages() async {
    pickedImages = await _picker.pickMultiImage();
    setState(() {
      images = pickedImages;
    });
  }

  @override
  void initState() {
    loggedInUserEmail = _graphQLConfiguration.box.get('myEmail');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;

    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      padding: EdgeInsets.all(12),
      height: height,
      child: Mutation(
        options: MutationOptions(
          document: gql(_mutation.createPost()),
          onCompleted: (dynamic result) {
            Navigator.pop(context); // back to previous screen
          },
        ),
        builder: (RunMutation? runMutation, QueryResult? result) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Post content",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _key,
                child: TextFormField(
                  validator: (text) {
                    if (text!.isNotEmpty) {
                      return null;
                    } else {
                      return "Content can't be empty";
                    }
                  },
                  controller: contentController,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                      hintText:
                          "Write \n\t\t\t\t\t\tyour \n\t\t\t\t\t\t\t\t\tpost \n\t\t\t\t\t\t\t\t\t\t\t\t\t\tcontent here..."),
                ),
              ),
              // images
              const SizedBox(
                height: 15,
              ),
              Text(
                  images == null
                      ? "Add pictures"
                      : "Selected Pictures (${images!.length})",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),

              images == null
                  ? InkWell(
                      onTap: () => pickImages(),
                      child: const Icon(Icons.add_photo_alternate_rounded,
                          size: 150, color: Colors.grey),
                    )
                  : Container(
                      height: 300,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Container(
                                    height: 250,
                                    width: 170,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(
                                                File(images![index].path))),
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        images!.removeAt(
                                            index); // unselects an image at the specified index
                                        setState(() {
                                          // rebuilds widgets
                                          images!.isEmpty
                                              ? images = null
                                              : images =
                                                  images; // gives images a null value if hass it's values has been removed
                                        });
                                      },
                                      icon: Icon(Icons.cancel),
                                      tooltip: "unselect")
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: images!.length),
                    ),
              SizedBox(height: 20),
              Container(
                  alignment: Alignment.center,
                  child: Visibility(
                    visible: !uploading,
                    replacement: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text("uploading... please wait")
                        ],
                      ),
                    ),
                    child: CupertinoButton(
                        color: Colors.green,
                        pressedOpacity: 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload),
                            Text("Upload Post"),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            uploading =
                                true; // allows the progress indicator to load
                          });

                          // processing images
                          if (images!.isNotEmpty) {
                            for (var i = 0; i < images!.length; i++) {
                              images![i].readAsBytes().then((value) {
                                var byteData = value;
                                var multipartFile = MultipartFile.fromBytes(
                                    'photo', byteData,
                                    filename: images![i].name,
                                    contentType: MediaType('image', 'jpg'));

                                multipartImages.add(multipartFile);

                                if ((images!.length - 1) == i) {
                                  runMutation!(
                                    // runs mutation when all the images(s) have been added
                                    {
                                      "content": contentController.text,
                                      "userEmail": loggedInUserEmail,
                                      "subtitle": "post by user",
                                      "images": multipartImages
                                    },
                                  );
                                } else {
                                  // continues the loop
                                }
                              });
                            }
                          } else {
                            runMutation!(
                              {
                                "content": contentController.text,
                                "userEmail": loggedInUserEmail,
                                "subtitle": "post by user"
                              },
                            );
                          }
                        }),
                  ))
            ],
          );
        },
      ),
    )));
  }
}

// Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Post content",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Form(
//               key: _key,
//               child: TextFormField(
//                 validator: (text) {
//                   if (text!.isNotEmpty) {
//                     return null;
//                   } else {
//                     return "Content can't be empty";
//                   }
//                 },
//                 controller: contentController,
//                 maxLines: 5,
//                 minLines: 5,
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(),
//                     hintText:
//                         "Write \n\t\t\t\t\t\tyour \n\t\t\t\t\t\t\t\t\tpost \n\t\t\t\t\t\t\t\t\t\t\t\t\t\tcontent here..."),
//               ),
//             ),
//             // images
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//                 images == null
//                     ? "Add pictures"
//                     : "Selected Pictures (${images!.length})",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(
//               height: 5,
//             ),
      
//             images == null
//                 ? InkWell(
//                     onTap: () => pickImages(),
//                     child: const Icon(Icons.add_photo_alternate_rounded,
//                         size: 150, color: Colors.grey),
//                   )
//                 : Container(
//                     height: 300,
//                     child: ListView.separated(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             height: 300,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 250,
//                                   width: 170,
//                                   decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                           fit: BoxFit.cover,
//                                           image: FileImage(
//                                               File(images![index].path))),
//                                       borderRadius: BorderRadius.circular(5)),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       images!.removeAt(
//                                           index); // unselects an image at the specified index
//                                       setState(() {
//                                         // rebuilds widgets
//                                         images!.isEmpty
//                                             ? images = null
//                                             : images =
//                                                 images; // gives images a null value if hass it's values has been removed
//                                       });
//                                     },
//                                     icon: Icon(Icons.cancel),
//                                     tooltip: "unselect")
//                               ],
//                             ),
//                           );
//                         },
//                         separatorBuilder: (BuildContext context, int index) {
//                           return SizedBox(
//                             width: 5,
//                           );
//                         },
//                         itemCount: images!.length),
//                   ),
//             SizedBox(height: 20),
//             Container(
//                 alignment: Alignment.center,
//                 child: CupertinoButton(
//                     color: Colors.green,
//                     pressedOpacity: 0.8,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.upload),
//                         Text("Upload Post"),
//                       ],
//                     ),
//                     onPressed: () {}))
//           ],
//         ),