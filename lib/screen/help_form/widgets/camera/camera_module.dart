import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraModule extends StatelessWidget {
  const CameraModule({
    super.key,
    required CameraController? cameraController,
  }) : _cameraController = cameraController;

  final CameraController? _cameraController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _cameraController == null
          ? Container()
          : CameraPreview(
              _cameraController as CameraController,
            ),
    );
  }
}
