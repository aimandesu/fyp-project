import 'package:flutter/material.dart';

class ChipsModel {
  final String label;
  bool selected = false;

  ChipsModel({
    required this.label,
    this.selected = false,
  });
}
