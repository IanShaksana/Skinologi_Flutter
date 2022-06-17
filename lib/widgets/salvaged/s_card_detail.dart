import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class ScardMember extends StatefulWidget {
  const ScardMember({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ModelPatient item;
  @override
  _ScardMemberState createState() => _ScardMemberState();
}

class _ScardMemberState extends State<ScardMember> {
  List<Widget> detil = List.empty(growable: true);
  List<Widget> catatan = List.empty(growable: true);

  void populate() {
    detil = List.empty(growable: true);
    catatan = List.empty(growable: true);
    detil.add(items3('Name', widget.item.name!, Colors.red));
    detil
        .add(items3('DOB', formatDateUtilString(widget.item.dob!), Colors.red));
    detil.add(items3('Blood Type ', widget.item.blood!, Colors.amber));
    detil.add(items3('Address', widget.item.address!, Colors.amberAccent));
    detil.add(items3('Contact', widget.item.contact!, Colors.yellow));
    detil.add(items3(
        'Email', nullCheck(value: widget.item.email!), Colors.yellowAccent));
    detil.add(
        items3('Status', nullCheck(value: widget.item.status!), Colors.green));
    detil.add(items3(
        'Rank', nullCheck(value: widget.item.rank!), Colors.greenAccent));

    // catatan.add(items3(
    //     'Catatan Marketing',
    //     nullCheck(value: widget.item.noteMarketing.toString()),
    //     Colors.redAccent));
    // catatan.add(items3('Review',
    //     nullCheck(value: widget.item.review.toString()), Colors.amberAccent));
  }

  @override
  Widget build(BuildContext context) {
    populate();
    return Column(
      children: [
        Hero(
          tag: 'card-${widget.item.idPatient!}',
          child: Material(
              child: items2('Detail', detil, "lib/assets/iconcard/detil.png")),
        ),
        // items2(
        //     'Catatan', catatan, "lib/assets/iconcard/notes.png"), // jadi satu
      ],
    );
  }

  Widget items(String title, List<Widget> list) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FitnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: FitnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: FitnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   // children: list,
              // ),
              child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: list,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget items2(String title, List<Widget> list, String assets) {
    return Stack(
      children: [
        items(title, list),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(assets),
          ),
        )
      ],
    );
  }

  Widget items3(String title, String data, Color color) {
    return Row(
      children: <Widget>[
        Container(
          height: 48,
          width: 2,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    letterSpacing: -0.1,
                    color: FitnessAppTheme.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset("lib/assets/fitness_app/eaten.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: SizedBox(
                      width: 210,
                      child: Text(
                        data,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: FitnessAppTheme.darkerText,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  

  Widget inkwellWrapping(Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                onTap: () async {},
                child: child,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ScardTreatmentTx extends StatefulWidget {
  const ScardTreatmentTx({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ModelTreatmentTxTreatmentDetail item;
  @override
  _ScardTreatmentTxState createState() => _ScardTreatmentTxState();
}

class _ScardTreatmentTxState extends State<ScardTreatmentTx> {
  List<Widget> detil = List.empty(growable: true);
  List<Widget> catatan = List.empty(growable: true);
  List<Widget> treatment = List.empty(growable: true);
  List<Widget> inventory = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: populate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              items2('Detail', detil, "lib/assets/iconcard/detil.png"),
              items2Single(
                  'Amnesis', catatan, "lib/assets/iconcard/notes.png"), //
              items2('Treatment List', treatment,
                  "lib/assets/iconcard/notes.png"), // jadi satu

              items2('Inventory Usage', inventory,
                  "lib/assets/iconcard/notes.png"), // jadi satu
            ],
          );
        } else {
          return loading2();
        }
      },
    );
  }

  Future<bool> populate() async {
    detil = List.empty(growable: true);
    treatment = List.empty(growable: true);
    inventory = List.empty(growable: true);
    detil.add(items3('Name', widget.item.patient!.name!, Colors.red));
    detil.add(items3('Id Treatment', widget.item.treatmentTx!.idTreatmentTx!,
        Colors.redAccent));
    detil.add(items3('Tanggal ', formatDateUtil(widget.item.treatmentTx!.date!),
        Colors.amber));
    // catatan.add(items3Single(
    //     'Amnesis',
    //     'In 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as n 2008, Smith was reported to be developing a film entitled The Last Pharaoh, in which he would be starring as',
    //     Colors.amberAccent));
        
    catatan.add(items3Single(
        'Amnesis',
        widget.item.treatmentTx!.anamnesis?? '',
        Colors.amberAccent));
        

    for (var i = 0; i < widget.item.treatmentUsage!.length; i++) {
      var modelTreatmentUsage = widget.item.treatmentUsage![i];
      var modelInventory =
          await apiInventory.getDetail(modelTreatmentUsage.idInventory!,context);

      double thePrice =
          modelTreatmentUsage.realQuantity! * modelInventory.price!;

      inventory.add(
        items3(
            'Item ${i + 1}',
            '${modelInventory.name} ${modelTreatmentUsage.realQuantity} ${modelInventory.unit} ${formatMoney(thePrice.toString())}',
            Colors.blue),
      );
    }

    for (var i = 0; i < widget.item.treatment!.length; i++) {
      var modelTreatment = widget.item.treatment![i];
      treatment.add(
        items3(
            'Treatment ${i + 1}',
            '${modelTreatment.name} ${formatMoney(modelTreatment.price.toString())}',
            Colors.green),
      );
    }

    return true;
  }

  Widget items(String title, List<Widget> list) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FitnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: FitnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: FitnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   // children: list,
              // ),
              child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StaggeredGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: list,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemsSingle(String title, Widget item) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          color: FitnessAppTheme.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: FitnessAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 3),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: 28,
                                color: FitnessAppTheme.nearlyDarkBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: FitnessAppTheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 16),
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   // children: list,
                // ),
                child: item)
          ],
        ),
      ),
    );
  }

  Widget items2(String title, List<Widget> list, String assets) {
    return Stack(
      children: [
        items(title, list),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(assets),
          ),
        )
      ],
    );
  }

  Widget items2Single(String title, List<Widget> list, String assets) {
    return Stack(
      children: [
        itemsSingle(title, list[0]),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(assets),
          ),
        )
      ],
    );
  }

  Widget items3(String title, String data, Color color) {
    return Row(
      children: <Widget>[
        Container(
          height: 48,
          width: 2,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    letterSpacing: -0.1,
                    color: FitnessAppTheme.grey.withOpacity(0.5),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Image.asset("lib/assets/fitness_app/eaten.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 3),
                    child: SizedBox(
                      width: 210,
                      child: Text(
                        data,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: FitnessAppTheme.darkerText,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget items3Single(String title, String data, Color color) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: FitnessAppTheme.darkerText,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget inkwellWrapping(Widget child) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: FitnessAppTheme.nearlyWhite,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                  bottomRight: Radius.circular(4.0),
                  topRight: Radius.circular(4.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    offset: const Offset(4.0, 4.0),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                onTap: () async {},
                child: child,
              ),
            ),
          ),
        )
      ],
    );
  }
}
