import 'package:flutter/material.dart';

import '../../constant.dart';
import 'textfield_decoration.dart';

class FilesUpload extends StatefulWidget {
  const FilesUpload({required this.fileName, super.key});

  final String fileName;

  @override
  State<FilesUpload> createState() => _FilesUploadState();
}

class _FilesUploadState extends State<FilesUpload> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      decoration: inputDecorationDefined(context),
      child: Row(
        children: [
          Text(widget.fileName),
          const Icon(Icons.done),
        ],
      ),
    );
  }
}
