import 'dart:io';

import 'package:flutter/material.dart';

import '../../constant.dart';
import 'textfield_decoration.dart';

class ImagesUpload extends StatelessWidget {
  const ImagesUpload({
    required this.navigatePictureUpload,
    required this.pictures,
    super.key,
  });

  final Function navigatePictureUpload;
  final List<File>? pictures;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: marginDefined,
      decoration: inputDecorationDefined(context),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () => navigatePictureUpload(context),
            child: const Text("Upload Gambar"),
          ),
          pictures!.isEmpty ? const Icon(Icons.close) : const Icon(Icons.done),
        ],
      ),
    );
  }
}
