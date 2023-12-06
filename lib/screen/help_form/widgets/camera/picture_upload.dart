import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:image/image.dart' as img;
import 'camera_module.dart';
import 'camera_option.dart';

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
  int turns = 0;

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

  Future<void> _takePicture() async {
    final XFile xFile = await _cameraController!.takePicture();
    if (turns != 0) {
      int angle = 90;
      if (turns == 1) {
        angle = -90;
      }
      img.Image? capturedImage =
          img.decodeImage(await File(xFile.path).readAsBytes());
      final orientedImage =
          img.copyRotate(capturedImage!, angle: angle.toInt());
      await File(xFile.path).writeAsBytes(img.encodeJpg(orientedImage));
    }
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

  // void _clearImageCache() async {
  //   imageFile = null;
  //   await _cameraController!.dispose();
  // }

  void _removePicture(int index) {
    setState(() {
      _pictures = _pictures!..removeAt(index);
    });
  }

  @override
  void initState() {
    setupCamera();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    super.dispose();
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
        body: NativeDeviceOrientationReader(
          useSensor: true,
          builder: (ctx) {
            final orientation = NativeDeviceOrientationReader.orientation(ctx);
            switch (orientation) {
              case NativeDeviceOrientation.portraitUp:
                turns = 0;
                break;
              case NativeDeviceOrientation.portraitDown:
                turns = 2;
                break;
              case NativeDeviceOrientation.landscapeLeft:
                turns = 1;
                break;
              case NativeDeviceOrientation.landscapeRight:
                turns = 3;
                break;
              case NativeDeviceOrientation.unknown:
                turns = 0;
                break;
            }
            return Column(
              children: [
                Container(
                  color: Colors.black,
                  height: size.height * 0.05,
                  width: size.width * 1,
                ),
                SizedBox(
                  height: size.height * 0.8,
                  width: size.width * 1,
                  child: CameraModule(
                    cameraController: _cameraController,
                  ),
                ),
                Expanded(
                  child: CameraOption(
                    pictures: _pictures,
                    takePicture: _takePicture,
                    uploadPhotos: _uploadPhotos,
                    removePicture: _removePicture,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
