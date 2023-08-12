import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant.dart';
import 'textfield_decoration.dart';

class PictureDisplay extends StatelessWidget {
  const PictureDisplay(
      {required this.height,
      required this.width,
      required this.pictures,
      required this.navigatePictureUpload,
      super.key});

  final double height;
  final double width;
  final List<File> pictures;
  final Function navigatePictureUpload;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      // color: Colors.red,
      height: height,
      width: width,
      decoration: inputDecorationDefined(context),
      child: Stack(
        children: [
          pictures.isEmpty
              ? const Center(child: Text("Tiada Gambar"))
              : ListView.builder(
                  itemCount: pictures.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Image(
                        // width: size.width * 1,
                        image: FileImage(
                      pictures[index],
                    ));
                  }),
          Positioned(
            // top: 0,
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: () => navigatePictureUpload(context),
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
