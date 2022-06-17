import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/settings/shared_pref.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_button.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_text_field.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> with AutoRouteAware {
  TextEditingController controllerUser =
      TextEditingController(text: '127.0.0.1');

  AutoRouteObserver? _observer;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouterScope exposes the list of provided observers
    // including inherited observers
    _observer =
        RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
    if (_observer != null) {
      debugPrint('subscribed');
      // we subscribe to the observer by passing our
      // AutoRouteAware state and the scoped routeData
      _observer!.subscribe(this, context.routeData);
    } else {
      debugPrint('not sub');
    }
  }

  @override
  void didPush() {
    setState(() {
      debugPrint('pushed');
    });
  }

  @override
  void didPop() {
    setState(() {
      debugPrint('pop next');
    });
  }

  @override
  void didPopNext() {
    setState(() {
      debugPrint('popped next');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: AppTheme.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    FilledTextField(
                      controller: controllerUser,
                      lableText: 'IP ADDRESS',
                    ),
                    Sbtn(
                      state: true,
                      text: 'Enter',
                      snack: false,
                      onPressed: () async {
                        if (controllerUser.text.isNotEmpty) {
                          final sp = Provider.of<SharedPrefProvider>(context,
                              listen: false);
                          await sp.setIpAddress(controllerUser.text.toString());
                          routeHelper.navigate(context, const Home());
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Ip Address Kosong'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
