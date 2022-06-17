import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/settings/shared_pref.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class CustomDrawer3 extends StatefulWidget {
  const CustomDrawer3({Key? key, required this.currentRoute}) : super(key: key);

  final String currentRoute;

  @override
  _CustomDrawer3State createState() => _CustomDrawer3State();
}

class _CustomDrawer3State extends State<CustomDrawer3> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    super.initState();
  }

  String position = '';
  String nama = '';

  void setDrawerListArray(BuildContext context) {
    final sp = Provider.of<SharedPrefProvider>(context);
    position = sp.position;
    position = 'OWNER';
    nama = sp.nama;
    nama = 'IAN';
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.beranda,
        labelName: 'Beranda',
        icon: const Icon(Icons.home),
        url: '/home',
      ),
      DrawerList(
        index: DrawerIndex.taskMar,
        labelName: 'Member',
        icon: const Icon(Icons.people),
        url: '/member',
      ),
      DrawerList(
        index: DrawerIndex.loanMar,
        labelName: 'Inventory',
        icon: const Icon(Icons.inventory),
        url: '/inventory',
      ),
      DrawerList(
        index: DrawerIndex.depoMan,
        labelName: 'Inventory Tx',
        icon: const Icon(Icons.inventory_2_outlined),
        url: '/inventory/tx',
      ),
    ];

    if (position == 'OWNER') {
      drawerList!.add(DrawerList(
          index: DrawerIndex.taskMan,
          labelName: 'Treatment',
          icon: const Icon(Icons.add_circle),
          url: '/treatment'));
      drawerList!.add(DrawerList(
        index: DrawerIndex.loanMan,
        labelName: 'Treatment Tx',
        icon: const Icon(Icons.add_circle_outline),
        url: '/treatment/tx',
      ));
      drawerList!.add(DrawerList(
        index: DrawerIndex.depoMan,
        labelName: 'Appointment',
        icon: const Icon(Icons.add_ic_call),
        url: '/appointment',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    setDrawerListArray(context);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.6),
                          offset: const Offset(2.0, 4.0),
                          blurRadius: 8),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: Image.asset('lib/assets/images/userImage.png'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 4),
                      child: Text(
                        '',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        position,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppTheme.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        'Skinologi',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppTheme.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: const Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  logOut(context);
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          changeRoute(context, listData.url);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.currentRoute == listData.url
                              ? Colors.blue
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: widget.currentRoute == listData.url
                          ? Colors.blue
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.currentRoute == listData.url
                ? Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  // void changeRoute(BuildContext context, String menuitem) {
  //   if (widget.currentRoute != menuitem) {
  //     Navigator.of(context).pushReplacementNamed(menuitem);
  //   } else {
  //     Navigator.of(context).pop();
  //   }
  //   // detect if same page
  // }

  void changeRoute(BuildContext context, String menuitem) {
    debugPrint('current route : ' + widget.currentRoute);
    debugPrint('menu item route : ' + menuitem);

    switch (menuitem) {
      case '/home':
        routeHelper.replace(context, const Home());
        // AutoRouter.of(context).navigate(const Home());
        // AutoRouter.of(context).popUntilRoot();
        break;
      case '/member':
        routeHelper.replace(context, const Member());
        // AutoRouter.of(context).navigate(const TaskMarketing());
        // AutoRouter.of(context).popUntilRoot();
        break;

      case '/inventory':
        routeHelper.replace(context, const Inventory());
        // AutoRouter.of(context).navigate(const DepositoMarketing());
        // AutoRouter.of(context).popUntilRoot();
        break;

      case '/inventory/tx':
        routeHelper.replace(context, const InventoryTx());
        // AutoRouter.of(context).navigate(const LoanMarketing());
        // AutoRouter.of(context).popUntilRoot();
        break;

      case '/treatment':
        routeHelper.replace(context, const Treatment());
        // AutoRouter.of(context).navigate(const TaskManager());
        // AutoRouter.of(context).popUntilRoot();
        break;

      case '/treatment/tx':
        routeHelper.replace(context, const TreatmentTx());
        // AutoRouter.of(context).navigate(const DepositoManager());
        // AutoRouter.of(context).popUntilRoot();
        break;

      case '/appointment':
        routeHelper.replace(context, const Appointment());
        // AutoRouter.of(context).navigate(const LoanManager());
        // AutoRouter.of(context).popUntilRoot();
        break;
      default:
    }

    // detect if same page
  }

  void logOut(BuildContext context) {
    // apiUser.logout(context);
    // SpSettings pref = SpSettings();
    // pref.setLoginState(false);
    // // if (Navigator.canPop(context)) {
    // //   debugPrint("can pop");
    // //   Navigator.pop(context);
    // // } else {
    // //   debugPrint("can't pop");
    // // }
    //   Navigator.of(context).pushReplacementNamed('/');
  }
}

enum DrawerIndex {
  beranda,
  taskMar,
  loanMar,
  depoMar,
  taskMan,
  loanMan,
  depoMan,
}

class DrawerList {
  DrawerList(
      {this.isAssetsImage = false,
      this.labelName = '',
      this.icon,
      this.index,
      this.imageName = '',
      required this.url});

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
  final String url;
}
