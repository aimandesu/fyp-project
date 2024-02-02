import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constant.dart';

class PictureDisplay extends StatefulWidget {
  const PictureDisplay({
    super.key,
    required this.picturesIncident,
    required this.removePicture,
    required this.navigatePictureUpload,
    required this.width,
    required this.height,
  });

  @override
  State<PictureDisplay> createState() => _PictureDisplayState();

  final List<File>? picturesIncident;
  final Function removePicture;
  final Function navigatePictureUpload;
  final double width;
  final double height;
}

class _PictureDisplayState extends State<PictureDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: marginDefined,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Stack(
        children: [
          widget.picturesIncident!.isEmpty
              ? Lottie.asset(
                  "assets/gallery.json",
                  repeat: false,
                  width: widget.width,
                  height: widget.height,
                )
              : PageView.builder(
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
                ),
          Positioned(
            bottom: 5,
            right: 5,
            child: IconButton.filledTonal(
              onPressed: () => widget.navigatePictureUpload(context),
              icon: const Icon(Icons.camera_alt),
            ),
          )
        ],
      ),
    );
  }
}
