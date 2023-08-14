import 'dart:io';

import 'package:flutter/material.dart';
import '../textfield_decoration.dart';

class PictureDisplay extends StatefulWidget {
  static const routeName = "/picture-display";
  const PictureDisplay({
    super.key,
  });

  @override
  State<PictureDisplay> createState() => _PictureDisplayState();
}

class _PictureDisplayState extends State<PictureDisplay> {
  List<File>? pictures;
  late Function removePicture;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    pictures = arguments['pictures'] as List<File>?;
    removePicture = arguments['removePicture'] as Function;

    return Scaffold(
      body: Container(
        height: size.height * 1,
        width: size.width * 1,

        // color: Colors.red,

        decoration: inputDecorationDefined(context),
        child: Stack(
          children: [
            pictures!.isEmpty
                ? const Center(child: Text("Tiada Gambar"))
                : ListView.builder(
                    itemCount: pictures!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            removePicture(index);
                          });
                        },
                        child: Image(
                            // width: size.width * 1,
                            image: FileImage(
                          pictures![index],
                        )),
                      );
                    }),
            Positioned(
              // top: 0,
              right: 0,
              bottom: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
