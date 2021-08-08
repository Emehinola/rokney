import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:rokney/backends/backends.dart';
import 'package:rokney/custom_widgets/color_palette.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rokney/custom_widgets/customs.dart';

// uploading of profile image
class ProfileImageUpload extends StatefulWidget {
  _ProfileImageUploadState createState() => _ProfileImageUploadState();
}

class _ProfileImageUploadState extends State<ProfileImageUpload> {
  GraphQLConfiguration _graphQLConfiguration = GraphQLConfiguration();
  QueryMutation _queryMutation = QueryMutation();
  ImagePicker _picker = ImagePicker();
  XFile? _image;

  void pickImage() {
    _picker.pickImage(source: ImageSource.gallery).then((value) {
      setState(() {
        _image = value;
      });
    });
  }

  void uploadImage() {
    _image!.readAsBytes().then((value) {
      var byteData = value;
      var multipartFile = MultipartFile.fromBytes('photo', byteData,
          filename: _image!.name, contentType: MediaType("image", "jpg"));
      dynamic email = _graphQLConfiguration.box.get('myEmail');

      _graphQLConfiguration
          .clientToQuery()
          .mutate(MutationOptions(
              document: gql(_queryMutation.updateProfile()),
              variables: {"userEmail": email, "profilePic": multipartFile}))
          .then((returnedResult) {
        try {
          if (returnedResult.data!['updateProfile']['success']) {
            Navigator.pop(context);
          } else {
            //
          }
        } catch (error) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBar(error.toString(), Icons.info));
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext coontext) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette().mainColor,
          title: const Text("Update picture"),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          actions: _image != null
              ? [
                  IconButton(
                      onPressed: pickImage, icon: const Icon(Icons.refresh)),
                  IconButton(
                      onPressed: () => uploadImage(),
                      icon: const Icon(Icons.check))
                ]
              : [],
        ),
        body: Center(
          child: _image == null
              ? Container(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () => pickImage(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.photo),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Select an image"),
                        ],
                      )))
              : Center(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(_image!.path)))),
                  ),
                ),
        ));
  }
}
