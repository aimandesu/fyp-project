import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../textfield_decoration.dart';

class FilesUpload extends StatelessWidget {
  const FilesUpload({
    required this.fileName,
    required this.navigatePDFUpload,
    required this.selectedPDF,
    super.key,
  });

  final String fileName;
  final Function navigatePDFUpload;
  final File? selectedPDF;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginDefined,
      padding: paddingDefined,
      decoration: inputDecorationDefined(context),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: () => navigatePDFUpload(context),
            child: Text(fileName),
          ),
          selectedPDF == null
              ? const Icon(Icons.remove)
              : const Icon(Icons.done),
        ],
      ),
    );
  }
}
