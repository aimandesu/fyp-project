import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constant.dart';

class CameraOption extends StatelessWidget {
  const CameraOption(
      {required this.width,
      required this.height,
      required this.size,
      required this.pictures,
      required this.takePicture,
      required this.uploadPhotos,
      required this.clearImageCache,
      required this.isPortrait,
      super.key});

  final double width;
  final double height;
  final Size size;
  final List<File>? pictures;
  final VoidCallback takePicture;
  final VoidCallback uploadPhotos;
  final VoidCallback clearImageCache;
  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Flex(
        direction: isPortrait ? Axis.horizontal : Axis.vertical,
        children: [
          // RecentPictures(size: size, pictures: _pictures),
          Container(
            margin: marginDefined,
            height: size.height * 0.1,
            width: size.height * 0.1,
            color: pictures!.isEmpty ? Colors.black : null,
            child: pictures!.isEmpty
                ? null
                : FittedBox(
                    fit: BoxFit.fill,
                    child: Image(
                      image: FileImage(pictures!.last),
                    ),
                  ),
          ),
          const Spacer(),
          IconButton(
            onPressed: takePicture,
            // _takePicture("camera"),
            icon: Icon(Icons.camera),
          ),
          const Spacer(),
          IconButton(
            onPressed: uploadPhotos,
            icon: Icon(
              Icons.photo_album,
            ),
          ),
          IconButton(
            onPressed: () {
              clearImageCache;
              Navigator.pop(context, pictures);
            },
            icon: Icon(
              Icons.done,
            ),
          )
        ],
      ),
    );
  }
}
