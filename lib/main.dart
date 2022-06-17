import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart' as rt;
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/settings/shared_pref.dart';

void main() async {  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefProvider sp = SharedPrefProvider();
  await sp.setup();
  // switch (platformDetector()) {
  //   case 1:
  //     await FlutterDownloader.initialize();
  //     await _configureAmplifyStorage();
  //     break;
  //   case 2:
  //     await FlutterDownloader.initialize();
  //     await _configureAmplifyStorage();
  //     break;
  //   case 3:
  //     break;
  //   case 4:
  //     break;
  //   default:
  //     break;
  // }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sp),
      ],
      child: const MyApp(),
    ),
  );
}

// Future<void> _configureAmplifyStorage() async {
//   try {
//     await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
//     await Amplify.configure(amplifyconfig);
//   } on AmplifyAlreadyConfiguredException {
//     debugPrint(
//         "Tried to reconfigure Amplify Storage; this can occur when your app restarts on Android.");
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final rt.Route appRouter;
  @override
  void initState() {
    // final sp = Provider.of<SharedPrefProvider>(context, listen: false);
    // appRouter = rt.Route(guard: AuthGuard(sp: sp),roleGuard: RoleGuard(sp:sp));
    appRouter = rt.Route();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SKINOLOGI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        // navigatorObservers: () => [MyObserver()],
        navigatorObservers: () =>
            [MyObserver(), AutoRouteObserver(),],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
