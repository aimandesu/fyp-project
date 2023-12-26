import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_display.dart';
import '../../../../constant.dart';

class CameraOption extends StatelessWidget {
  const CameraOption({
    required this.pictures,
    required this.takePicture,
    required this.uploadPhotos,
    required this.removePicture,
    super.key,
  });

  final List<File>? pictures;
  final VoidCallback takePicture;
  final VoidCallback uploadPhotos;
  final Function removePicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                PictureDisplay.routeName,
                arguments: {
                  "pictures": pictures,
                  "removePicture": removePicture,
                },
              );
            },
            child: Container(
              margin: marginDefined,
              height: 50,
              width: 50,
              color: pictures!.isEmpty ? Colors.white : null,
              child: pictures!.isEmpty
                  ? null
                  : FittedBox(
                      fit: BoxFit.fill,
                      child: Image(
                        image: FileImage(pictures!.last),
                      ),
                    ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: takePicture,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                ),
                // child: ,
              ),
            ),
          ),
          IconButton(
            iconSize: 50,
            onPressed: uploadPhotos,
            icon: const Icon(
              Icons.photo_album,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
