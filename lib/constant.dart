import 'package:flutter/material.dart';

const String googleApiKey = "AIzaSyD3RGwE1INwks_lLKM728DxI8HfS54z9xU";

const marginDefined = EdgeInsets.all(10);
const paddingDefined = EdgeInsets.all(5);

const textStyling = TextStyle(
  fontSize: 30,
);

Decoration decorationDefined(Color color, double circular) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(circular),
    // border: Border.all(
    //   width: 1,
    // ),
  );
}

Decoration decorationDefinedShadow(Color color, double circular) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(circular),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 2,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  );
}
