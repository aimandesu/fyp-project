import 'dart:io';

import 'package:flutter/material.dart';

class PictureDisplay extends StatefulWidget {
  const PictureDisplay(
      {super.key, required this.picturesIncident, required this.removePicture});

  @override
  State<PictureDisplay> createState() => _PictureDisplayState();

  final List<File>? picturesIncident;
  final Function removePicture;
}

class _PictureDisplayState extends State<PictureDisplay> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.picturesIncident!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onLongPress: () => widget.removePicture(index),
          child: Image(
            fit: BoxFit.fitWidth,
            image: FileImage(
              widget.picturesIncident![index],
            ),
          ),
        );
      },
    );
  }
}
