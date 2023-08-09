import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PictureUpload extends StatefulWidget {
  static const routeName = "/picture-upload";
  const PictureUpload({super.key});

  @override
  State<PictureUpload> createState() => _PictureUploadState();
}

class _PictureUploadState extends State<PictureUpload> {
  XFile? imageFile;
  List<File>? _pictures = [];

  Future<void> _takePicture(String option) async {
    final picker = ImagePicker();
    imageFile = await picker.pickImage(
      source: option == "camera" ? ImageSource.camera : ImageSource.gallery,
      maxHeight: 1080,
      maxWidth: 1920,
    );

    if (imageFile == null) {
      return;
    }

    setState(() {
      _pictures!.add(File(imageFile!.path));
    });
  }

  void _clearImageCache() {
    imageFile = null;
  }

  void _removePicture(int index) {
    setState(() {
      _pictures = _pictures!..removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _pictures = arguments['pictures'] as List<File>?;
    Size size = MediaQuery.of(context).size;

    print("here: $_pictures");

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _pictures);
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: size.width * 1,
              height: size.width * 0.8,
              child: _pictures!.isEmpty
                  ? Text("empty")
                  : ListView.builder(
                      itemCount: _pictures!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Image(
                            image: FileImage(
                          _pictures![index],
                        ));
                      }),
            ),
            Container(
              width: size.width * 1,
              height: size.width * 0.1,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _takePicture("camera"),
                    icon: Icon(Icons.camera),
                  ),
                  IconButton(
                    onPressed: () => _takePicture("gallery"),
                    icon: Icon(Icons.photo_album),
                  ),
                  IconButton(
                    onPressed: () {
                      _clearImageCache();
                      Navigator.pop(context, _pictures);
                    },
                    icon: Icon(Icons.done),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
