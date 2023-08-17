import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constant.dart';
import 'textfield_decoration.dart';

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
    return ElevatedButton(
      onPressed: () => navigatePDFUpload(context),
      child: Row(
        children: [
          Text(fileName),
          selectedPDF == null
              ? const Icon(Icons.close)
              : const Icon(Icons.done),
        ],
      ),
    );
  }
}
