import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luvpark_get/classes/app_color.dart';

class CustomTitle extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final int? maxlines;
  final double wordspacing;
  final TextAlign? textAlign;

  const CustomTitle({
    super.key,
    required this.text,
    this.fontSize = 16.0,
    this.color = Colors.black87,
    this.fontWeight = FontWeight.w700,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = -1,
    this.maxlines,
    this.wordspacing = 8, // Set Normal to 4
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.manrope(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordspacing,
      ),
      maxLines: maxlines,
      textAlign: textAlign,
    );
  }
}

class CustomParagraph extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordspacing;
  final int? maxlines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const CustomParagraph({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.color,
    this.fontWeight = FontWeight.w600,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = 0.0,
    this.maxlines,
    this.wordspacing = 4,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.manrope(
        fontSize: fontSize,
        color: color ?? AppColor.paragraphColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
      maxLines: maxlines,
      overflow: overflow,
    );
  }
}

class CustomLinkLabel extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final double letterSpacing;
  final double wordspacing;
  final int? maxlines;
  final TextAlign? textAlign;

  const CustomLinkLabel({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.color = Colors.white,
    this.fontWeight = FontWeight.w700,
    this.fontStyle = FontStyle.normal,
    this.letterSpacing = 0.0,
    this.maxlines,
    this.wordspacing = 0,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.manrope(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
      maxLines: maxlines,
    );
  }
}
