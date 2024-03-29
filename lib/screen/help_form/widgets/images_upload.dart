import 'dart:io';
import 'package:flutter/material.dart';

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
    return ElevatedButton(
      onPressed: () => navigatePictureUpload(context),
      child: Row(
        children: [
          const Text("Muat Naik Gambar"),
          pictures!.isEmpty ? const Icon(Icons.close) : const Icon(Icons.done),
        ],
      ),
    );
  }
}
