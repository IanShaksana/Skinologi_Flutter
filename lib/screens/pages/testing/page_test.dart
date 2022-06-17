import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/api/testing/apt_test.dart';
import 'package:replikasi_marketing_tracker/model/model_received.dart';
import 'package:replikasi_marketing_tracker/model/testing/model_test.dart';
import 'package:replikasi_marketing_tracker/screens/drawer/drawer.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_app_bar.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_card.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_title.dart';

class PageTest extends StatefulWidget {
  const PageTest({Key? key}) : super(key: key);

  @override
  _PageTestState createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  List<Widget> listShortAppointment = [];
  List<Widget> listShortInventory = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getHome2(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var check = snapshot.data as bool;
          if (check) {
            return Scaffold(
              appBar: CustomAppBar(
                text: 'Beranda',
                hasDrawer: false,
                hasRefresh: true,
                refresh: () {
                  setState(() {
                    debugPrint('yuhuuu');
                  });
                },
              ),
              drawer: const CustomDrawer3(
                currentRoute: '/home',
              ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      STitleHome(
                        titleTxt: 'Stock',
                        subTxt: 'Detil',
                        onTapped: () {
                          routeHelper.navigate(context, const Inventory());
                        },
                      ),
                      shortCard(listShortWidget: listShortInventory),
                      STitleHome(
                        titleTxt: 'Appointment',
                        subTxt: 'Detil',
                        onTapped: () {
                          routeHelper.navigate(context, const Appointment());
                        },
                      ),
                      shortCard(listShortWidget: listShortAppointment),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return loading();
          }
        } else {
          return loading();
        }
      },
    );
  }

  Future<bool> getHome2(BuildContext context) async {
    listShortAppointment = [];
    listShortInventory = [];

    ModelReceived model = await apiTest.getAll(context);

    if (model.status == 1) {
      List<ModelTest> listTest =
          model.data.map((e) => ModelTest.fromJson(e)).toList();
      for (var i = 0; i < listTest.length; i++) {
        var item = listTest[i];

        DateTime date1 = item.date1;
        DateTime date2 = item.date2;
        DateTime date3 = item.date3;
        DateTime date4 = item.date4;

        String date1S = formatDateUtil(date1);
        String date2S = formatDateUtil(date2);
        String date3S = formatDateUtil(date3);
        String date4S = formatDateUtil(date4);
        
        String dateTime1S = formatDateTimeUtil(date1);
        String dateTime2S = formatDateTimeUtil(date2);
        String dateTime3S = formatDateTimeUtil(date3);
        String dateTime4S = formatDateTimeUtil(date4);

        String dateTime1SS = formatDateTimeUtil2(date1);
        String dateTime2SS = formatDateTimeUtil2(date2);
        String dateTime3SS = formatDateTimeUtil2(date3);
        String dateTime4SS = formatDateTimeUtil2(date4);


        listShortAppointment.add(
          itemVeryLow(
            '',
            '',
            '$date1, $date2, $date3, $date4',
          ),
        );

        listShortAppointment.add(
          itemLow(
            '',
            '',
            '$date1S, $date2S, $date3S, $date4S',
          ),
        );

        listShortAppointment.add(
          itemVeryLow(
            '',
            '',
            '$dateTime1S, $dateTime2S, $dateTime3S, $dateTime4S',
          ),
        );

        listShortAppointment.add(
          itemLow(
            '',
            '',
            '$dateTime1SS, $dateTime2SS, $dateTime3SS, $dateTime4SS',
          ),
        );
      }
    } else {
      debugPrint('message : ${model.message}');
    }

    return true;
  }
}
