import 'package:flutter/material.dart';
import 'dart:io';

class ICimage extends StatefulWidget {
  const ICimage({
    super.key,
    required this.frontIC,
    required this.backIC,
    required this.takePicture,
    required this.removePicture,
  });

  final File? frontIC;
  final File? backIC;

  // final Function(bool isFront, bool isCamera) takePicture;
  // final Function(bool isFront) removePicture;
  final Function takePicture;
  final Function removePicture;

  @override
  State<ICimage> createState() => _ICimageState();
}

class _ICimageState extends State<ICimage> {
  late Future<dynamic> theFutureLoad;

  Future<dynamic> runFutureLoad() {
    return Future.delayed(const Duration(seconds: 7));
  }

  @override
  void initState() {
    theFutureLoad = runFutureLoad();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        icView(context, "Depan", widget.frontIC, true),
        icView(context, "Belakang", widget.backIC, false)
      ],
    );
  }

  Container icView(
    BuildContext context,
    String icPosition,
    File? icPositionFile,
    bool isFront,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(icPosition),
                icPositionFile != null
                    ? IconButton(
                        onPressed: () => widget.removePicture(isFront),
                        icon: const Icon(Icons.delete),
                      )
                    : Container(),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              // width: size.width * 1,
              child: Center(
                child: FutureBuilder(
                  //wait until futurebuilder object is received
                  future: theFutureLoad,
                  builder: (c, s) =>
                      s.connectionState == ConnectionState.waiting
                          ? const CircularProgressIndicator()
                          : icPositionFile == null
                              ? FilledButton.tonal(
                                  onPressed: () => widget.takePicture(isFront),
                                  child: const Text("Pilih Gambar"),
                                )
                              : Image(
                                  fit: BoxFit.contain,
                                  image: FileImage(icPositionFile),
                                ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
