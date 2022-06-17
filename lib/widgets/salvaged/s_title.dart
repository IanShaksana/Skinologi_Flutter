import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class STitleHome extends StatelessWidget {
  const STitleHome(
      {Key? key,
      required this.titleTxt,
      required this.subTxt,
      required this.onTapped})
      : super(key: key);
  final String titleTxt;
  final String subTxt;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return items();
  }

  Widget items() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            titleTxt,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              letterSpacing: 0.5,
              color: FitnessAppTheme.lightText,
            ),
          ),
        ),
        InkWell(
          highlightColor: Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          onTap: () {
            onTapped();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: <Widget>[
                Text(
                  subTxt,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    letterSpacing: 0.5,
                    color: FitnessAppTheme.nearlyDarkBlue,
                  ),
                ),
                const SizedBox(
                  height: 38,
                  width: 26,
                  child: Icon(
                    Icons.arrow_forward,
                    color: FitnessAppTheme.darkText,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class STitle extends StatelessWidget {
  const STitle({
    Key? key,
    required this.titleTxt,
  }) : super(key: key);
  final String titleTxt;

  @override
  Widget build(BuildContext context) {
    return items();
  }

  Widget items() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            titleTxt,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              letterSpacing: 0.5,
              color: FitnessAppTheme.lightText,
            ),
          ),
        ),
      ],
    );
  }
}

class SText extends StatelessWidget {
  const SText({
    Key? key,
    required this.txt,
  }) : super(key: key);
  final String txt;

  @override
  Widget build(BuildContext context) {
    return items();
  }

  Widget items() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: FitnessAppTheme.fontName,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.5,
              color: FitnessAppTheme.darkerText,
            ),
          ),
        ),
      ],
    );
  }
}
