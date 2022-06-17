import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_inventory.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_patient.dart';
import 'package:replikasi_marketing_tracker/model/model_received.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_appointment_patient.dart';
import 'package:replikasi_marketing_tracker/screens/drawer/drawer.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_app_bar.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_card.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_title.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
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
                hasDrawer: true,
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

  Future<bool> getHome(BuildContext context) async {
    listShortAppointment = [];
    listShortInventory = [];

    List<ModelInventory> listInventory = await apiInventory.getShort(context);
    List<ModelAppointmentPatient> listPatient =
        await apiPatient.getShortAppointment(context);

    for (var i = 0; i < listInventory.length; i++) {
      var item = listInventory[i];
      if (item.quantity! < 10 && item.quantity! > 5) {
        listShortInventory
            .add(itemLow(item.name!, item.quantity!.toString(), item.unit!));
      }

      if (item.quantity! <= 5) {
        listShortInventory.add(
            itemVeryLow(item.name!, item.quantity!.toString(), item.unit!));
      }
    }
    for (var i = 0; i < listPatient.length; i++) {
      var item = listPatient[i];
      if (i < 5) {
        listShortAppointment.add(itemVeryLow(
            'Nama : ${item.patient.name!}',
            'Contact : ${item.patient.contact!}',
            'Tanggal : ${formatDateUtilString(item.appointment.date!)}, Waktu : ${formatClock(item.appointment.time!)}'));
      } else {
        listShortAppointment.add(itemLow(
            'Nama : ${item.patient.name!}',
            'Contact : ${item.patient.contact!}',
            'Tanggal : ${formatDateUtilString(item.appointment.date!)}, Waktu : ${formatClock(item.appointment.time!)}'));
      }
    }
    return true;
  }

  Future<bool> getHome2(BuildContext context) async {
    listShortAppointment = [];
    listShortInventory = [];

    List<ModelInventory> listInventory = await apiInventory.getShort(context);

    for (var i = 0; i < listInventory.length; i++) {
      var item = listInventory[i];
      if (item.quantity! < 10 && item.quantity! > 5) {
        listShortInventory
            .add(itemLow(item.name!, item.quantity!.toString(), item.unit!));
      }

      if (item.quantity! <= 5) {
        listShortInventory.add(
            itemVeryLow(item.name!, item.quantity!.toString(), item.unit!));
      }
    }

    ModelReceived model = await apiPatient.getShortAppointment2(context);

    // var snackBar = SnackBar(
    //   content: Text(model.message),
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (model.status == 1) {
      List<ModelAppointmentPatient> listPatient =
          model.data.map((e) => ModelAppointmentPatient.fromJson(e)).toList();
      for (var i = 0; i < listPatient.length; i++) {
        var item = listPatient[i];
        if (i < 5) {
          listShortAppointment.add(itemVeryLow(
              'Nama : ${item.patient.name!}',
              'Contact : ${item.patient.contact!}',
              'Tanggal : ${formatDateUtilString(item.appointment.date!)}, Waktu : ${formatClock(item.appointment.time!)}'));
        } else {
          listShortAppointment.add(itemLow(
              'Nama : ${item.patient.name!}',
              'Contact : ${item.patient.contact!}',
              'Tanggal : ${formatDateUtilString(item.appointment.date!)}, Waktu : ${formatClock(item.appointment.time!)}'));
        }
      }
    } else {
      debugPrint('message : ${model.message}');
    }

    return true;
  }
}
