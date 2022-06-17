import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  final TextAlign align;
  final int type, typeSize, maxLines;
  final bool caps;
  final TextOverflow overflow;

  const CustomText(this.text, this.type, this.typeSize,
      {Key? key,
      this.align = TextAlign.left,
      color,
      this.caps = false,
      this.maxLines = 9999,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  late String  fontFamilyUsed;
  late FontWeight fontWeight;
  FontStyle fontStyle = FontStyle.normal;

  late Color color, labelColorUsed;

  double space = 0;

  late double fontSizeUsed, lineHeight;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 1: // 48 heavy
        labelColorUsed = Colors.black;
        fontFamilyUsed = 'Roboto-Bold';
        switch (widget.typeSize) {
          case 1:
            fontSizeUsed = 24;
            // Bold
            fontWeight = FontWeight.bold;
            color = const Color(0xffEE5434);
            break;
          case 2:
            fontSizeUsed = 24;
            // medium
            fontWeight = FontWeight.w500;
            color = const Color(0xffEE5434);
            break;
          case 3:
            fontSizeUsed = 28;
            // Regular
            fontWeight = FontWeight.w400;
            color = const Color(0xffEE5434);
            break;
          case 4:
            fontSizeUsed = 24;
            // Bold
            fontWeight = FontWeight.bold;
            color = const Color(0xff616161);
            break;
          case 5:
            fontSizeUsed = 24;
            // Medium
            fontWeight = FontWeight.w500;
            color = const Color(0xff616161);
            break;
          case 6:
            fontSizeUsed = 24;
            // Regular
            fontWeight = FontWeight.w400;
            color = const Color(0xff616161);
            break;
          case 7:
            fontSizeUsed = 24;
            fontWeight = FontWeight.bold;
            color = const Color(0xff20D174);
            break;
          case 8:
            fontSizeUsed = 16;
            // Bold
            fontWeight = FontWeight.bold;
            color = const Color(0xffEE5434);
            break;
          case 9:
            fontSizeUsed = 16;
            // Medium
            fontWeight = FontWeight.w500;
            color = const Color(0xffEE5434);
            break;
          case 10:
            fontSizeUsed = 16;
            // Medium Italic
            fontWeight = FontWeight.w500;
            fontStyle = FontStyle.italic;
            color = const Color(0xffEE5434);
            break;
          case 11:
            fontSizeUsed = 16;
            // Regular
            fontWeight = FontWeight.w500;
            color = const Color(0xffEE5434);
            break;
          case 12:
            fontSizeUsed = 16;
            // Bold
            fontWeight = FontWeight.bold;
            color = const Color(0xff616161);
            break;
          case 13:
            // fontSizeUsed = 16; lama
            fontSizeUsed = 16;
            fontWeight = FontWeight.w500;
            color = const Color(0xff616161);
            break;
          case 14:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.w500;
            fontStyle = FontStyle.italic;
            color = const Color(0xff616161);
            break;
          case 15:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w400;
            color = const Color(0xff616161);
            break;
          case 16:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w300;
            color = const Color(0xff919191);
            break;
          case 17:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w500;
            fontStyle = FontStyle.italic;
            color = const Color(0xff20D174);
            break;
          case 18:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.bold;
            color = const Color(0xff20D174);
            break;
          case 19:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.bold;
            color = Colors.white;
            break;
          case 20:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.w500;
            color = Colors.white;
            break;
          case 21:
            fontSizeUsed = 16;
            // medium
            fontWeight = FontWeight.w400;
            color = Colors.white;
            break;
          case 22:
            fontSizeUsed = 16;
            // medium
            fontWeight = FontWeight.w500;
            fontStyle = FontStyle.italic;
            color = const Color(0xffEE5434);
            break;
          case 23:
            fontSizeUsed = 24;
            fontWeight = FontWeight.bold;
            color = Colors.white;
            break;
          case 24:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w500;
            space = 2;
            color = const Color(0xff616161);
            break;
          case 25:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w500;
            color = const Color(0x80616161);
            break;
          case 26:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.w400;
            color = const Color(0x80616161);
            break;
          case 27:
            fontSizeUsed = 16;
            // light
            fontWeight = FontWeight.bold;
            color = const Color(0x80FFDC00);
            break;
          case 28:
            fontSizeUsed = 14;
            // light
            fontWeight = FontWeight.bold;
            color = const Color(0xFFFFFFFF);
            break;
          case 29:
            fontSizeUsed = 10;
            // light
            fontWeight = FontWeight.bold;
            fontStyle = FontStyle.italic;
            color = Colors.white;
            break;
          case 30:
            fontSizeUsed = 10;
            fontWeight = FontWeight.w300;
            color = const Color(0xff616161);
            break;
          case 31:
            fontSizeUsed = 10;
            fontWeight = FontWeight.w500;
            color = const Color(0xff616161);
            break;
          case 32:
            fontSizeUsed = 16;
            fontWeight = FontWeight.w500;
            color = Colors.white;
            break;
          case 33:
            fontSizeUsed = 10;
            fontWeight = FontWeight.w500;
            color = const Color(0xffEE5434);
            break;
          case 34:
            fontSizeUsed = 24;
            fontWeight = FontWeight.bold;
            color = const Color(0xff20D174);
            break;
        }
        break;
    }

    String trueText = widget.text;
    if (widget.caps) trueText = widget.text.toUpperCase();
    labelColorUsed = color;

    return Text(
      trueText,
      overflow: widget.overflow,
      style: TextStyle(
          color: labelColorUsed,
          fontFamily: fontFamilyUsed,
          fontWeight: fontWeight,
          fontSize: fontSizeUsed - 0,
          height: 1,
          fontStyle: fontStyle,
          letterSpacing: space / MediaQuery.of(context).devicePixelRatio),
      textAlign: widget.align,
      maxLines: widget.maxLines,
    );
  }
}
