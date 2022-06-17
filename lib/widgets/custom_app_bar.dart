import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      required this.text,
      required this.hasDrawer,
      required this.refresh,
      required this.hasRefresh})
      : super(key: key);
  final String text;
  final bool hasDrawer;
  final VoidCallback refresh;
  final bool hasRefresh;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      backgroundColor: Colors.transparent,
      actions: [
        hasRefresh
            ? IconButton(
                onPressed: () {
                  if (hasRefresh) {
                    refresh();
                  }
                },
                icon: const Icon(Icons.refresh))
            : Container(),
      ],
      leading: !hasDrawer
          ? BackButton(
              onPressed: () => routeHelper.pop(context),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
