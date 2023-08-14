import 'dart:io';

import 'package:flutter/material.dart';

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
  bool showOption = false;

  double _scale = 1.0;
  double _previousScale = 1.0;
  // Offset _offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    pictures = arguments['pictures'] as List<File>?;
    removePicture = arguments['removePicture'] as Function;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            setState(() {
              showOption = !showOption;
            });
          },
          child: Column(
            children: [
              pictures!.isEmpty
                  ? const Center(child: Text("Tiada Gambar"))
                  : SizedBox(
                      width: size.width * 1,
                      height: size.height * 0.9,
                      child: Center(
                        child: ListView.builder(
                            itemCount: pictures!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: size.width,
                                // height: size.height * 0.9,
                                child: GestureDetector(
                                  onScaleUpdate: (ScaleUpdateDetails details) {
                                    // Apply zoom-in scaling
                                    double newScale =
                                        _previousScale * details.scale;
                                    if (newScale < 1.0) {
                                      newScale = 1.0; // Prevent over-zoom
                                    }
                                    if (newScale > 4.0) {
                                      newScale = 4.0; // Limit maximum zoom
                                    }

                                    setState(() {
                                      _scale = newScale;
                                    });
                                  },
                                  onScaleEnd: (_) {
                                    _previousScale = _scale;
                                  },
                                  // onPanUpdate: (details) {
                                  //   // Apply dragging if zoomed in
                                  //   if (_scale > 1.0) {
                                  //     setState(() {
                                  //       _offset = Offset(
                                  //         _offset.dx + details.delta.dx,
                                  //         _offset.dy + details.delta.dy,
                                  //       );
                                  //     });
                                  //   }
                                  // },
                                  child: Transform.scale(
                                    scale: _scale,
                                    child: Image(
                                        fit: BoxFit.fitWidth,
                                        image: FileImage(
                                          pictures![index],
                                        )),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
              !showOption
                  ? Container()
                  : SizedBox(
                      width: size.width * 1,
                      height: size.height * 0.1,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.add),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
