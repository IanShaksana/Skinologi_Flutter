import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class RouteHelper {
  void navigate(BuildContext context, PageRouteInfo<dynamic> route) {
    if (kIsWeb) {
      // AutoRouter.of(context).navigate(route);
      AutoRouter.of(context).push(route);
    } else {
      AutoRouter.of(context).push(route);
    }
  }

  void pop(BuildContext context) {
    if (kIsWeb) {
      // AutoRouter.of(context).navigateBack();
      AutoRouter.of(context).pop();
    } else {
      AutoRouter.of(context).pop();
    }
  }

  void replace(BuildContext context, PageRouteInfo<dynamic> route) {
    if (kIsWeb) {
      // AutoRouter.of(context).navigate(route);
      // AutoRouter.of(context).popUntilRoot();
      AutoRouter.of(context).replace(route);
    } else {
      AutoRouter.of(context).replace(route);
    }
  }
}

final routeHelper = RouteHelper();

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    debugPrint('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    debugPrint(
        'New route popped: ${route.settings.name}, Now ${previousRoute!.settings.name} ');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    debugPrint('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    debugPrint('Tab route re-visited: ${route.name}');
  }
}
