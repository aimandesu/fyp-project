import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../responsive_layout_controller.dart';

class ICimage extends StatefulWidget {
  ICimage({
    super.key,
    required this.mediaQuery,
    required this.paddingTop,
    required this.frontIC,
    required this.backIC,
    required this.takePicture,
    required this.removePicture,
  });

  final MediaQueryData mediaQuery;
  final double paddingTop;
  File? frontIC;
  File? backIC;
  final Function(bool isFront, bool isCamera) takePicture;
  final Function(bool isFront) removePicture;

  @override
  State<ICimage> createState() => _ICimageState();
}

class _ICimageState extends State<ICimage> {
  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);

    return SizedBox(
      width: isTablet
          ? widget.mediaQuery.size.width * 0.6
          : widget.mediaQuery.size.width * 1,
      height: isTablet
          ? 250
          : (widget.mediaQuery.size.height - widget.paddingTop) * 0.35,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              width: isTablet
                  ? widget.mediaQuery.size.width * 0.6
                  : widget.mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: isTablet
                        ? widget.mediaQuery.size.width * 0.6
                        : widget.mediaQuery.size.width * 1,
                    height: widget.mediaQuery.size.height * 0.03,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Front IC"),
                        widget.frontIC != null
                            ? IconButton(
                                onPressed: () => widget.removePicture(true),
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
                        child: widget.frontIC == null
                            ? IconButton(
                                onPressed: () => widget.takePicture(true, true),
                                icon: const Icon(Icons.front_hand),
                              )
                            : Image(
                                fit: BoxFit.contain,
                                width: widget.mediaQuery.size.width * 1,
                                image: FileImage(widget.frontIC as File),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              width: isTablet
                  ? widget.mediaQuery.size.width * 0.6
                  : widget.mediaQuery.size.width * 1,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: isTablet
                        ? widget.mediaQuery.size.width * 0.6
                        : widget.mediaQuery.size.width * 1,
                    height: widget.mediaQuery.size.height * 0.03,
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Back IC"),
                        widget.backIC != null
                            ? IconButton(
                                onPressed: () => widget.removePicture(false),
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
                        child: widget.backIC == null
                            ? IconButton(
                                onPressed: () =>
                                    widget.takePicture(false, true),
                                icon: const Icon(Icons.baby_changing_station),
                              )
                            : Image(
                                fit: BoxFit.contain,
                                width: widget.mediaQuery.size.width * 1,
                                image: FileImage(widget.backIC as File),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
