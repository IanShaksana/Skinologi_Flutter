import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

Widget loading() {
  return Scaffold(
    body: Center(
      child: LoadingBumpingLine.circle(
        size: 100,
        backgroundColor: Colors.amber,
      ),
    ),
  );
}

Widget loading2() {
  return LoadingBumpingLine.circle(
    size: 100,
    backgroundColor: Colors.amber,
  );
}

Widget noitem(
  String appbartitle,
  String message,
) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        appbartitle.toUpperCase(),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: const BackButton(color: Colors.black),
    ),
    body: Center(
      child: Text(message),
    ),
  );
}

Widget noItem(bool check) {
  if (check) {
    return const Center(child: Text('No Data Found'));
  } else {
    return Container();
  }
}

Widget noitemWithDrawer(
    String appbartitle, String message, Widget customDrawer) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        appbartitle.toUpperCase(),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: const BackButton(color: Colors.black),
    ),
    drawer: customDrawer,
    body: Center(
      child: Text(message),
    ),
  );
}
