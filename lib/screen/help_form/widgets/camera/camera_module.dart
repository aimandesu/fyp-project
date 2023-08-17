import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraModule extends StatelessWidget {
  const CameraModule({
    super.key,
    required this.height,
    required this.width,
    required CameraController? cameraController,
  }) : _cameraController = cameraController;

  final double height;
  final double width;
  final CameraController? _cameraController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: _cameraController == null
          ? Container()
          : CameraPreview(
              _cameraController as CameraController,
            ),
      // _pictures!.isEmpty
      //     ? const Text("empty")
      //     : const Text("Change to camera")
      // ListView.builder(
      //     itemCount: _pictures!.length,
      //     scrollDirection: Axis.horizontal,
      //     itemBuilder: (context, index) {
      //       return Image(
      //           // width: size.width * 1,
      //           // height: 1080,
      //           image: FileImage(
      //         _pictures![index],
      //       ));
      //     }),
    );
  }
}
