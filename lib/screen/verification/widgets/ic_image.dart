import 'package:flutter/material.dart';
import 'dart:io';
import '../../../responsive_layout_controller.dart';

class ICimage extends StatefulWidget {
  const ICimage({
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
  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayoutController.isTablet(context);

    final halfwidthIc = widget.mediaQuery.size.width * 0.6;
    final fullwidthIc = widget.mediaQuery.size.width * 1;

    return SizedBox(
        width: isTablet ? halfwidthIc : fullwidthIc,
        height: isTablet
            ? widget.mediaQuery.size.height - widget.paddingTop
            : (widget.mediaQuery.size.height - widget.paddingTop) * 0.4,
        child: PageView(
          children: [
            icView(context, isTablet, halfwidthIc, fullwidthIc, "Front IC",
                widget.frontIC, true),
            icView(context, isTablet, halfwidthIc, fullwidthIc, "Back IC",
                widget.backIC, false)
          ],
        )

        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Row(
        //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Theme.of(context).colorScheme.primary,
        //           ),
        //         ),
        //         width: isTablet
        //             ? widget.mediaQuery.size.width * 0.6
        //             : widget.mediaQuery.size.width * 1,
        //         padding: const EdgeInsets.all(8),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               width: isTablet
        //                   ? widget.mediaQuery.size.width * 0.6
        //                   : widget.mediaQuery.size.width * 1,
        //               height: widget.mediaQuery.size.height * 0.03,
        //               child: Row(
        //                 // crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   const Text("Front IC"),
        //                   widget.frontIC != null
        //                       ? IconButton(
        //                           onPressed: () => widget.removePicture(true),
        //                           icon: const Icon(Icons.delete),
        //                         )
        //                       : Container(),
        //                 ],
        //               ),
        //             ),
        //             Expanded(
        //               child: SizedBox(
        //                 // width: size.width * 1,
        //                 child: Center(
        //                   child: widget.frontIC == null
        //                       ? IconButton(
        //                           onPressed: () => widget.takePicture(true, true),
        //                           icon: const Icon(Icons.front_hand),
        //                         )
        //                       : Image(
        //                           fit: BoxFit.contain,
        //                           width: widget.mediaQuery.size.width * 1,
        //                           image: FileImage(widget.frontIC as File),
        //                         ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(
        //             color: Theme.of(context).colorScheme.primary,
        //           ),
        //         ),
        //         width: isTablet
        //             ? widget.mediaQuery.size.width * 0.6
        //             : widget.mediaQuery.size.width * 1,
        //         padding: const EdgeInsets.all(8),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             SizedBox(
        //               width: isTablet
        //                   ? widget.mediaQuery.size.width * 0.6
        //                   : widget.mediaQuery.size.width * 1,
        //               height: widget.mediaQuery.size.height * 0.03,
        //               child: Row(
        //                 // crossAxisAlignment: CrossAxisAlignment.start,
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   const Text("Back IC"),
        //                   widget.backIC != null
        //                       ? IconButton(
        //                           onPressed: () => widget.removePicture(false),
        //                           icon: const Icon(Icons.delete),
        //                         )
        //                       : Container(),
        //                 ],
        //               ),
        //             ),
        //             Expanded(
        //               child: SizedBox(
        //                 // width: size.width * 1,
        //                 child: Center(
        //                   child: widget.backIC == null
        //                       ? IconButton(
        //                           onPressed: () =>
        //                               widget.takePicture(false, true),
        //                           icon: const Icon(Icons.baby_changing_station),
        //                         )
        //                       : Image(
        //                           fit: BoxFit.contain,
        //                           width: widget.mediaQuery.size.width * 1,
        //                           image: FileImage(widget.backIC as File),
        //                         ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  Container icView(
    BuildContext context,
    bool isTablet,
    double halfwidthIc,
    double fullwidthIc,
    String icPosition,
    File? icPositionFile,
    bool isFront,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      width: isTablet ? halfwidthIc : fullwidthIc,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: isTablet ? halfwidthIc : fullwidthIc,
            height: widget.mediaQuery.size.height * 0.03,
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
                child: icPositionFile == null
                    ? IconButton(
                        onPressed: () => widget.takePicture(isFront),
                        icon: const Icon(Icons.front_hand),
                      )
                    : Image(
                        fit: BoxFit.contain,
                        width: widget.mediaQuery.size.width * 1,
                        image: FileImage(icPositionFile),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
