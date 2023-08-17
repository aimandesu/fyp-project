import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFUpload extends StatefulWidget {
  static const routeName = "/pdf-upload";
  const PDFUpload({super.key});

  @override
  State<PDFUpload> createState() => _PDFUploadState();
}

class _PDFUploadState extends State<PDFUpload> {
  File? _selectedPDF;

  void getBack() {
    Navigator.pop(context, {"pdf": _selectedPDF, "showUpload": true});
  }

  void _pickPdf() async {
    FilePickerResult? confirmationLetter = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (confirmationLetter != null) {
      setState(() {
        _selectedPDF = File(confirmationLetter.files.single.path.toString());
      });
      // PlatformFile file = confirmationLetter.files.first;

      // print(file.name);
      // print(file.bytes);
      // print(file.size);
      // print(file.extension);
      // print(file.path);
      // print(_selectedPDF == null);
      getBack();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _selectedPDF ??= arguments['pdf'] as File?;

    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, {"pdf": _selectedPDF, "showUpload": false});
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            _selectedPDF == null
                ? SizedBox(
                    height: size.height * 0.9,
                    width: size.width * 1,
                    child: const Center(
                      child: Text("No PDF File"),
                    ),
                  )
                : SizedBox(
                    height: size.height * 0.9,
                    width: size.width * 1,
                    child: PDFView(
                      filePath: _selectedPDF!.path,
                    ),
                  ),
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 1,
              child: OutlinedButton(
                onPressed: _pickPdf,
                child: const Text("Pilih PDF"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
