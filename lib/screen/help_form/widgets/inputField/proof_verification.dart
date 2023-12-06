import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../files_upload.dart';
import '../images_upload.dart';

class ProofVerification extends StatelessWidget {
  const ProofVerification({
    super.key,
    required this.navigatePictureUpload,
    this.pictures,
    required this.navigatePDFUpload,
    this.selectedPDF,
  });

  final Function navigatePictureUpload;
  final List<File>? pictures;
  final Function navigatePDFUpload;
  final File? selectedPDF;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: paddingDefined,
          child: Text(
            "Pengesahan dan Bukti",
            style: textStyling30,
          ),
        ),
        proofAndVerification(),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  SingleChildScrollView proofAndVerification() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: marginDefined,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ImagesUpload(
              navigatePictureUpload: navigatePictureUpload,
              pictures: pictures,
            ),
            const Padding(padding: paddingDefined),
            FilesUpload(
              fileName: "Pengesahan Ketua Kampung",
              navigatePDFUpload: navigatePDFUpload,
              selectedPDF: selectedPDF,
            ),
          ],
        ),
      ),
    );
  }
}
