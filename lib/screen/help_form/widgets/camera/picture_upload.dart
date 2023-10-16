import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_module.dart';
import 'camera_option.dart';
import 'picture_display.dart';

class PictureUpload extends StatefulWidget {
  static const routeName = "/picture-upload";
  const PictureUpload({super.key});

  @override
  State<PictureUpload> createState() => _PictureUploadState();
}

class _PictureUploadState extends State<PictureUpload> {
  XFile? imageFile;
  List<File>? _pictures = [];
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];

  //features camera
  // double _minAvailableZoom = 1.0;
  // double _maxAvailableZoom = 1.0;

  void setupCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras[0],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    _cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    await _cameraController!.initialize();
    // _cameraController!
    //     .getMaxZoomLevel()
    //     .then((value) => _maxAvailableZoom = value);
    // _cameraController!
    //     .getMinZoomLevel()
    //     .then((value) => _minAvailableZoom = value);

    if (mounted) {
      setState(() {});
    }
  }

  //take picture using gallery

  Future<void> _takePicture() async {
    final XFile xFile = await _cameraController!.takePicture();
    if (mounted) {
      setState(() {
        _pictures!.add(File(xFile.path));
      });
    }
  }

  Future<void> _uploadPhotos() async {
    final picker = ImagePicker();
    List<XFile> imageFile = await picker.pickMultiImage(
        // source: ImageSource.gallery,
        // maxHeight: 1080,
        // maxWidth: 1920,
        );

    if (imageFile.isEmpty) {
      return;
    }

    setState(() {
      for (var i in imageFile) {
        _pictures!.add(File(i.path));
      }
    });
  }

  void _clearImageCache() async {
    imageFile = null;
    await _cameraController!.dispose();
  }

  void _removePicture(int index) {
    setState(() {
      _pictures = _pictures!..removeAt(index);
    });
  }

  @override
  void initState() {
    setupCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _pictures = arguments['pictures'] as List<File>?;
    Size size = MediaQuery.of(context).size;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _pictures);
        return true;
      },
      child: Scaffold(
        // body: ResponsiveLayoutController(
        // mobile: isPortrait
        //     ?
        body: isPortrait
            ? Padding(
                padding: paddingDefined,
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Sila benarkan mod putaran dan pusing kepada mod landskap",
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              PictureDisplay.routeName,
                              arguments: {
                                "pictures": _pictures,
                                "removePicture": _removePicture,
                              },
                            );
                          },
                          child: const Text("Pergi ke gambar diambil")),
                    ),
                  ],
                ),
              )
            :
            // Column(
            //     children: [
            //       CameraModule(
            //         height: size.height * 0.9,
            //         width: size.width * 1,
            //         cameraController: _cameraController,
            //       ),
            //       CameraOption(
            //         width: size.width * 1,
            //         height: size.height * 0.1,
            //         size: size,
            //         pictures: _pictures,
            //         takePicture: _takePicture,
            //         uploadPhotos: _uploadPhotos,
            //         clearImageCache: _clearImageCache,
            //         removePicture: _removePicture,
            //         isPortrait: isPortrait,
            //       )
            //     ],
            //   )
            // :
            Row(
                children: [
                  CameraModule(
                    height: size.height * 1,
                    width: size.width * 0.9,
                    cameraController: _cameraController,
                  ),
                  CameraOption(
                    width: size.width * 0.1,
                    height: size.height * 1,
                    size: size,
                    pictures: _pictures,
                    takePicture: _takePicture,
                    uploadPhotos: _uploadPhotos,
                    clearImageCache: _clearImageCache,
                    removePicture: _removePicture,
                    isPortrait: isPortrait,
                  ),
                ],
              ),
        // tablet: isPortrait
        //     ? Column(
        //         children: [
        //           CameraModule(
        //             height: size.height * 0.9,
        //             width: size.width * 1,
        //             cameraController: _cameraController,
        //           ),
        //           CameraOption(
        //             width: size.width * 1,
        //             height: size.height * 0.1,
        //             size: size,
        //             pictures: _pictures,
        //             takePicture: _takePicture,
        //             uploadPhotos: _uploadPhotos,
        //             clearImageCache: _clearImageCache,
        //             removePicture: _removePicture,
        //             isPortrait: isPortrait,
        //           )
        //         ],
        //       )
        //     : Row(
        //         children: [
        //           CameraModule(
        //             height: size.height * 1,
        //             width: size.width * 0.9,
        //             cameraController: _cameraController,
        //           ),
        //           CameraOption(
        //             width: size.width * 0.1,
        //             height: size.height * 1,
        //             size: size,
        //             pictures: _pictures,
        //             takePicture: _takePicture,
        //             uploadPhotos: _uploadPhotos,
        //             clearImageCache: _clearImageCache,
        //             removePicture: _removePicture,
        //             isPortrait: isPortrait,
        //           ),
        //         ],
        //       ),
        // ),
      ),
    );
  }
}

// class RecentPictures extends StatelessWidget {
//   const RecentPictures({
//     super.key,
//     required this.size,
//     required List<File>? pictures,
//   }) : _pictures = pictures;

//   final Size size;
//   final List<File>? _pictures;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: marginDefined,
//       height: size.height * 0.1,
//       width: size.height * 0.1,
//       color: _pictures!.isEmpty ? Colors.black : null,
//       child: _pictures!.isEmpty
//           ? null
//           : FittedBox(
//               fit: BoxFit.fill,
//               child: Image(
//                 image: FileImage(_pictures!.last),
//               ),
//             ),
//     );
//   }
// }
