import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyCustomText extends StatelessWidget {
  final String text;
  double? fontSize;
  Color? color;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  MyCustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.color,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color ?? Colors.white,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
    );
  }
}
