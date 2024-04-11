// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  Color color;
  double? fontHeight;
  String title;
  double fontSize;
  FontWeight fontWeight;

  TextWidget({
    super.key,
    this.color = Colors.black,
    this.fontHeight,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        height: fontHeight ?? fontHeight,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
