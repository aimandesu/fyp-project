import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_project/screen/help_form/widgets/camera/picture_display.dart';

import '../../../../constant.dart';

class CameraOption extends StatelessWidget {
  const CameraOption(
      {required this.width,
      required this.height,
      required this.size,
      required this.pictures,
      required this.takePicture,
      required this.uploadPhotos,
      // required this.clearImageCache,
      required this.isPortrait,
      required this.removePicture,
      super.key});

  final double width;
  final double height;
  final Size size;
  final List<File>? pictures;
  final VoidCallback takePicture;
  final VoidCallback uploadPhotos;
  // final VoidCallback clearImageCache;
  final bool isPortrait;
  final Function removePicture;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.black,
      child: Flex(
        direction: isPortrait ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // RecentPictures(size: size, pictures: _pictures),
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
              height: size.height * 0.1,
              width: size.height * 0.1,
              color: pictures!.isEmpty ? Colors.white : null,
              child: pictures!.isEmpty
                  ? null
                  : FittedBox(
                      fit: BoxFit.fill,

                      //go to picture display, terima delete punya logic and terima list of gmbr

                      child: Image(
                        image: FileImage(pictures!.last),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 50),
          Center(
            child: GestureDetector(
              onTap: takePicture,
              child: Container(
                // margin: marginDefined,
                // color: Colors.white,
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
          // IconButton(
          //   onPressed: takePicture,
          //   // _takePicture("camera"),
          //   icon: const Icon(Icons.camera),
          // ),
          // const Spacer(),
          const SizedBox(height: 50),
          IconButton(
            iconSize: 30,
            onPressed: uploadPhotos,
            icon: const Icon(
              Icons.photo_album,
              color: Colors.white,
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     clearImageCache;
          //     Navigator.pop(context, pictures);
          //   },
          //   icon: const Icon(
          //     Icons.done,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
