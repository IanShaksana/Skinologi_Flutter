import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/printing/pdf_invoice_api.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_inventory.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_patient.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_usage_inventory.dart';
import 'package:replikasi_marketing_tracker/screens/drawer/drawer.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_app_bar.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_button.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_text_field.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_card_detail.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_title.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class PageTreatmentTx extends StatefulWidget {
  const PageTreatmentTx({Key? key}) : super(key: key);

  @override
  _PageTreatmentTxState createState() => _PageTreatmentTxState();
}

class _PageTreatmentTxState extends State<PageTreatmentTx> with AutoRouteAware {
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
    PlutoGridStateManager? stateManager;
    List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Treatment',
        field: 'treatment',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Patient',
        field: 'patient',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Date',
        field: 'date',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        width: 600,
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;
                      routeHelper.navigate(
                        context,
                        TreatmentTxDetail(
                            id: item.treatmentTx!.idTreatmentTx!, item: item),
                      );
                    },
                  ),
                  const Text('Detil')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.more_horiz),
              //   onPressed: () {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;
              //     routeHelper.navigate(
              //       context,
              //       TreatmentTxDetail(
              //           id: item.treatmentTx!.idTreatmentTx!, item: item),
              //     );
              //   },
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;
                      routeHelper.navigate(
                        context,
                        RouteTreatmentTxUsage(
                            id: item.treatmentTx!.idTreatmentTx!,
                            item: item.treatmentTx!),
                      );
                    },
                  ),
                  const Text('Usage')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.search),
              //   onPressed: () {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;
              //     routeHelper.navigate(
              //       context,
              //       RouteTreatmentTxUsage(
              //           id: item.treatmentTx!.idTreatmentTx!,
              //           item: item.treatmentTx!),
              //     );
              //   },
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status! == 'VERIF1') {
                        await apiTreatment.verif2UsageTx(
                            item.treatmentTx!, context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be Verif 1'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Usage Verif')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.check),
              //   onPressed: () async {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;

              //     if (item.treatmentTx!.status! == 'VERIF1') {
              //       await apiTreatment.verif2UsageTx(
              //           item.treatmentTx!, context);
              //       setState(() {});
              //     } else {
              //       const snackBar = SnackBar(
              //         content: Text('Must Be Verif 1'),
              //       );
              //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //     }
              //   },
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status! == 'VERIF2') {
                        await apiTreatment.verifTx(item.treatmentTx!, context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be Verif 2'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Inv Verif')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.check_circle_outline),
              //   onPressed: () async {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;

              //     if (item.treatmentTx!.status! == 'VERIF2') {
              //       await apiTreatment.verifTx(item.treatmentTx!, context);
              //       setState(() {});
              //     } else {
              //       const snackBar = SnackBar(
              //         content: Text('Must Be Verif 2'),
              //       );
              //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //     }
              //   },
              // ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calculate),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status! == 'FINISH' ||
                          item.treatmentTx!.status! == 'CALCULATED') {
                        routeHelper.navigate(
                          context,
                          RouteTreatmentTxCalculation(
                              id: item.treatmentTx!.idTreatmentTx!, item: item),
                        );
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be FINISH / CALCULATED'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Calculate')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.calculate),
              //   onPressed: () async {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;

              //     if (item.treatmentTx!.status! == 'FINISH' ||
              //         item.treatmentTx!.status! == 'CALCULATED') {
              //       routeHelper.navigate(
              //         context,
              //         RouteTreatmentTxCalculation(
              //             id: item.treatmentTx!.idTreatmentTx!, item: item),
              //       );
              //     } else {
              //       const snackBar = SnackBar(
              //         content: Text('Must Be FINISH / CALCULATED'),
              //       );
              //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //     }
              //   },
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.lock),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status! == 'CALCULATED') {
                        await apiTreatment.completeTx(
                            item.treatmentTx!, context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be CALCULATED'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Calculate Verif')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.lock),
              //   onPressed: () async {
              //     var item = rendererContext.row.cells['action']!.value
              //         as ModelTreatmentTxTreatmentDetail;

              //     if (item.treatmentTx!.status! == 'CALCULATED') {
              //       await apiTreatment.completeTx(item.treatmentTx!, context);
              //       setState(() {});
              //     } else {
              //       const snackBar = SnackBar(
              //         content: Text('Must Be CALCULATED'),
              //       );
              //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //     }
              //   },
              // ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.print),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status! == 'COMPLETE') {
                        // need make invoice
                        List<ModelInventory> lInventory = [];
                        for (var i = 0; i < item.treatmentUsage!.length; i++) {
                          var usage = item.treatmentUsage![i];
                          var data = await apiInventory.getDetail(
                              usage.idInventory!, context);
                          lInventory.add(data);
                        }
                        await PdfInvoiceApi().generate(item, lInventory);
                        const snackBar = SnackBar(
                          content: Text('Done'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be COMPLETE'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Print')
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      var item = rendererContext.row.cells['action']!.value
                          as ModelTreatmentTxTreatmentDetail;

                      if (item.treatmentTx!.status != 'FINISH' &&
                          item.treatmentTx!.status != 'CALCULATED' &&
                          item.treatmentTx!.status != 'COMPLETE') {
                        await apiTreatment.deleteTx(item.treatmentTx!, context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content:
                              Text('Already Finish, Calculated or Complete'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Delete')
                ],
              ),
            ],
          );
        },
      ),
    ];
    List<PlutoRow> rows = [];

    return FutureBuilder(
      future: getTreatmentTx(rows),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as int;
          return Scaffold(
            appBar: CustomAppBar(
              text: 'Treatment Tx',
              hasDrawer: true,
              hasRefresh: true,
              refresh: () {
                setState(() {});
              },
            ),
            floatingActionButton: SpeedDial(
              child: const Icon(Icons.add),
              closedForegroundColor: FitnessAppTheme.nearlyDarkBlue,
              openForegroundColor: Colors.white,
              closedBackgroundColor: Colors.white,
              openBackgroundColor: FitnessAppTheme.nearlyBlue,
              speedDialChildren: [
                SpeedDialChild(
                  child: const Icon(Icons.person_add_alt),
                  backgroundColor: FitnessAppTheme.nearlyBlue,
                  label: 'Create Treatment Tx',
                  onPressed: () {
                    routeHelper.navigate(
                        context, const RouteTreatmentTxCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/treatment/tx',
            ),
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: PlutoGrid(
                    key: UniqueKey(),
                    columns: columns,
                    rows: rows,
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      stateManager = event.stateManager;
                      stateManager!.setShowColumnFilter(true);
                    },
                    mode: PlutoGridMode.normal,
                    configuration: const PlutoGridConfiguration(
                      enableColumnBorder: true,
                      rowHeight: 100,
                    ),
                  ),
                ),
                noItem(items == 0),
              ],
            ),
          );
        } else {
          return loading();
        }
      },
    );
  }

  Future<int> getTreatmentTx(List<PlutoRow> rows) async {
    List<ModelTreatmentTxTreatmentDetail> listTreatmentTx =
        await apiTreatment.getAllTx(context);
    for (var i = 0; i < listTreatmentTx.length; i++) {
      var item = listTreatmentTx[i];
      String listOfTreatment = '';
      for (var x = 0; x < item.treatment!.length; x++) {
        var treatment = item.treatment![x];
        if (x == 0) {
          listOfTreatment = treatment.name!;
        } else {
          listOfTreatment = listOfTreatment + ',' + treatment.name!;
        }
      }

      rows.add(
        PlutoRow(
          cells: {
            'id': PlutoCell(value: item.treatmentTx!.idTreatmentTx),
            'treatment': PlutoCell(value: listOfTreatment),
            'patient': PlutoCell(value: item.patient!.name),
            'date': PlutoCell(value: formatDateTimeUtil(item.treatmentTx!.createdAt!)),
            'status': PlutoCell(value: item.treatmentTx!.status),
            'action': PlutoCell(value: item),
          },
        ),
      );
    }

    return listTreatmentTx.length;
  }
}

class PageTreatmenTxDetail extends StatefulWidget {
  const PageTreatmenTxDetail(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelTreatmentTxTreatmentDetail item;

  @override
  State<PageTreatmenTxDetail> createState() => _PageTreatmenTxDetailState();
}

class _PageTreatmenTxDetailState extends State<PageTreatmenTxDetail> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var value = snapshot.data as bool;
          if (value) {
            return Scaffold(
              appBar: CustomAppBar(
                text: "Detil Treatment Tx",
                hasDrawer: false,
                hasRefresh: true,
                refresh: () {
                  setState(() {});
                },
              ),
              body: RefreshIndicator(
                onRefresh: () {
                  setState(() {});
                  return Future.delayed(const Duration(seconds: 3));
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: children(widget.item)),
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

  Future<bool> setup() async {
    return true;
  }

  List<Widget> children(ModelTreatmentTxTreatmentDetail model) {
    return [ScardTreatmentTx(item: model)];
  }
}

class PageTreatmentTxCreate extends StatefulWidget {
  const PageTreatmentTxCreate({Key? key}) : super(key: key);

  @override
  _PageTreatmentTxCreateState createState() => _PageTreatmentTxCreateState();
}

class _PageTreatmentTxCreateState extends State<PageTreatmentTxCreate> {
  TextEditingController controlAmnesis = TextEditingController();
  TextEditingController controlQuantity = TextEditingController();

  List<ModelPatient> listPatient = [];
  List<ModelTreatment> listTreatment = [];
  List<ModelInventory> listInventory = [];

  ModelPatient selectedPatient = ModelPatient();
  ModelTreatment selectedTreatment = ModelTreatment();
  ModelInventory selectedInventory = ModelInventory();

  bool emptySelectTreatment = true;
  bool emptySelectInventory = true;

  List<ModelTreatment> selectedListTreatment = List.empty(growable: true);
  List<Widget> listTextTreatment = [];

  List<ModelInventoryTx> selectedListInventoryTx = List.empty(growable: true);
  List<Widget> listTextInventory = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatientTreatmentInventory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Create Treatment Tx",
              hasDrawer: false,
              hasRefresh: false,
              refresh: () {
                setState(() {});
              },
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              offset: const Offset(4, 4),
                              blurRadius: 8),
                        ],
                      ),
                      child: DropdownSearch<ModelPatient>(
                        mode: Mode.MENU,
                        itemAsString: (item) => nullCheck(value: item!.name!),
                        items: listPatient,
                        label: "Patient",
                        onChanged: (value) {
                          selectedPatient = value!;
                        },
                      ),
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    theTreatment(),
                    Row(children: const [Expanded(child: Divider())]),
                    theInventory(),
                    Row(children: const [Expanded(child: Divider())]),
                    FilledTextField2(
                        controller: controlAmnesis, lableText: 'Amnesis'),
                    Row(children: const [Expanded(child: Divider())]),
                    ContainedButton(
                      text: 'Create',
                      isDisabled: false,
                      onClickAction: () {
                        apiTreatment.createTx(
                            ModelTreatmentTx(
                              idPatient: selectedPatient.idPatient,
                              anamnesis: controlAmnesis.text.toString(),
                            ),
                            selectedPatient,
                            selectedListTreatment,
                            selectedListInventoryTx,
                            context);
                      },
                      // onClickAction: () => {null},
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return loading();
        }
      },
    );
  }

  Future<bool> getPatientTreatmentInventory() async {
    listPatient = await apiPatient.getAll(context);
    listTreatment = await apiTreatment.getAll(context);
    listInventory = await apiInventory.getAll(context);
    return true;
  }

  Widget theInventory() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            offset: const Offset(4, 4),
                            blurRadius: 8),
                      ],
                    ),
                    child: DropdownSearch<ModelInventory>(
                      mode: Mode.MENU,
                      itemAsString: (item) => nullCheck(
                          value:
                              '${item!.name!} qty: ${item.quantity!} ${item.unit!}'),
                      items: listInventory,
                      label: "Inventory",
                      onChanged: (value) {
                        // setState(() {
                        selectedInventory = value!;
                        emptySelectInventory = false;
                        // });
                      },
                      key: GlobalKey<DropdownSearchState<String>>(),
                    ),
                  ),
                  FilledTextFieldNum(
                      controller: controlQuantity, lableText: 'Quantity'),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listTextInventory),
            ),
          ],
        ),
        ContainedButton(
          text: 'Add Inventory',
          isDisabled: false,
          onClickAction: () {
            if (!emptySelectInventory && controlQuantity.text.isNotEmpty) {
              // need check if number and not 0

              // add invent
              setState(() {
                ModelInventory modelInventory = selectedInventory;
                ModelInventoryTx modelInventoryTx = ModelInventoryTx(
                  idInventory: selectedInventory.idInventory,
                  quantity: int.parse(controlQuantity.text),
                );

                listTextInventory
                    .add(itemTextInventory(modelInventory, modelInventoryTx));
                selectedListInventoryTx.add(modelInventoryTx);

                emptySelectInventory = true;
                selectedInventory = ModelInventory();
                controlQuantity = TextEditingController();
              });
            }
          },
        ),
        ContainedButton(
          text: 'Clear',
          isDisabled: false,
          onClickAction: () {
            setState(() {
              listTextInventory = [];
              selectedListInventoryTx = List.empty(growable: true);
            });
          },
        ),
      ],
    );
  }

  Widget theTreatment() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              margin:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      offset: const Offset(4, 4),
                      blurRadius: 8),
                ],
              ),
              child: DropdownSearch<ModelTreatment>(
                mode: Mode.MENU,
                itemAsString: (item) => nullCheck(
                    value:
                        '${item!.name!} price: ${formatMoney(item.price!.toString())} '),
                items: listTreatment,
                label: "Treatment",
                onChanged: (value) {
                  selectedTreatment = value!;
                  emptySelectTreatment = false;
                },
                key: GlobalKey<DropdownSearchState<String>>(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2.2,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: listTextTreatment),
            ),
          ],
        ),
        ContainedButton(
          text: 'Add Treatment',
          isDisabled: false,
          onClickAction: () {
            if (!emptySelectTreatment) {
              // add invent
              setState(() {
                selectedListTreatment.add(selectedTreatment);
                listTextTreatment.add(itemTextTreatment(selectedTreatment));

                emptySelectTreatment = true;
                selectedTreatment = ModelTreatment();
              });
            }
          },
        ),
        ContainedButton(
          text: 'Clear',
          isDisabled: false,
          onClickAction: () {
            setState(() {
              listTextTreatment = [];
              selectedListTreatment = List.empty(growable: true);
            });
          },
        ),
      ],
    );
  }

  Widget itemTextInventory(
      ModelInventory modelInventory, ModelInventoryTx modelInventoryTx) {
    return Text(
      '${modelInventory.name} ${modelInventoryTx.quantity} ${modelInventory.unit}',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: FitnessAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: FitnessAppTheme.darkerText,
      ),
    );
  }

  Widget itemTextTreatment(ModelTreatment modelTreatment) {
    return Text(
      '${modelTreatment.name} ${formatMoney(modelTreatment.price.toString())} ',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: FitnessAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: FitnessAppTheme.darkerText,
      ),
    );
  }
}

// usage
class PageTreatmentTxUsage extends StatefulWidget {
  const PageTreatmentTxUsage(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelTreatmentTx item;

  @override
  _PageTreatmentTxUsageState createState() => _PageTreatmentTxUsageState();
}

class _PageTreatmentTxUsageState extends State<PageTreatmentTxUsage> {
  List<Widget> listUsage = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Treatment Tx Usage",
              hasDrawer: false,
              hasRefresh: false,
              refresh: () {
                setState(() {});
              },
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (var item in listUsage) item,
                    ContainedButton(
                      text: 'Verif',
                      isDisabled: widget.item.status! == 'FINISH' ||
                              widget.item.status! == 'CALCULATED' ||
                              widget.item.status! == 'COMPLETE'
                          ? true
                          : false,
                      onClickAction: () {
                        List<ModelTreatmentUsage> itemForApi = [];
                        bool clear = true;
                        for (var i = 0; i < listUsage.length; i++) {
                          var item = listUsage[i] as AddItemUsage;
                          ModelTreatmentUsage theRealItem =
                              item.model.treatmentUsage!;
                          theRealItem.useQuantity =
                              int.parse(item.controller.text);
                          itemForApi.add(theRealItem);
                          if (item.model.treatmentUsage!.totalQuantity! <
                              int.parse(item.controller.text)) {
                            clear = false;
                          }
                        }

                        if (clear) {
                          apiTreatment.verif1UsageTx(
                              widget.item, itemForApi, context);
                        } else {
                          // snack
                          const snackBar = SnackBar(
                            content: Text('Item Over Quantity'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      // onClickAction: () => {null},
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return loading();
        }
      },
    );
  }

  Future<bool> future() async {
    List<ModelTreatmentTxUsageInventory> list =
        await apiTreatment.getUsageTx(widget.item, context);

    for (var i = 0; i < list.length; i++) {
      var item = list[i];
      TextEditingController controller = TextEditingController(
          text: item.treatmentUsage!.useQuantity.toString());
      listUsage.add(AddItemUsage(controller: controller, model: item));
    }

    return true;
  }
}

class AddItemUsage extends StatefulWidget {
  const AddItemUsage({Key? key, required this.controller, required this.model})
      : super(key: key);
  final TextEditingController controller;
  final ModelTreatmentTxUsageInventory model;

  @override
  State<AddItemUsage> createState() => _AddItemUsageState();
}

class _AddItemUsageState extends State<AddItemUsage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                '${widget.model.inventory!.name} Required for Treatment : ${widget.model.treatmentUsage!.totalQuantity} ${widget.model.inventory!.unit}',
                style: const TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: FitnessAppTheme.darkerText,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FilledTextFieldNum(
                  controller: widget.controller, lableText: 'Quantity'),
            ),
          ],
        ),
        Row(children: const [Expanded(child: Divider())]),
      ],
    );
  }
}
// usage

class PageTreatmentTxCalculation extends StatefulWidget {
  const PageTreatmentTxCalculation(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelTreatmentTxTreatmentDetail item;

  @override
  State<PageTreatmentTxCalculation> createState() =>
      _PageTreatmentTxCalculationState();
}

class _PageTreatmentTxCalculationState
    extends State<PageTreatmentTxCalculation> {
  TextEditingController controlDiscount = TextEditingController();
  List<Widget> listWidgetTreatment = [];
  List<Widget> listWidgetInventory = [];

  double totalTreatment = 0.0;
  double totalInventory = 0.0;
  double totalBeforeDiscount = 0.0;
  double discount = 0.0;
  double totalAfterDiscount = 0.0;
  late ModelTreatmentTx realItem;

  @override
  Widget build(BuildContext context) {
    listWidgetTreatment = [];
    listWidgetInventory = [];

    totalTreatment = 0.0;
    totalInventory = 0.0;
    totalBeforeDiscount = 0.0;
    discount = 0.0;
    totalAfterDiscount = 0.0;
    return FutureBuilder(
      future: setup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Treatment Tx Calculation",
              hasDrawer: false,
              hasRefresh: false,
              refresh: () {
                setState(() {});
              },
            ),
            body: Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const STitle(
                      titleTxt: 'List Of Treatment',
                    ),
                    Column(
                      children: listWidgetTreatment,
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    const STitle(
                      titleTxt: 'List Of Inventory',
                    ),
                    Column(
                      children: listWidgetInventory,
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    const STitle(
                      titleTxt: 'Total Before Discount',
                    ),
                    SText(
                      txt: formatMoney(totalBeforeDiscount.toString()),
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    const STitle(
                      titleTxt: 'Discount',
                    ),
                    FilledTextFieldMoney(
                        controller: controlDiscount, lableText: 'Discount'),
                    Row(children: const [Expanded(child: Divider())]),
                    const STitle(
                      titleTxt: 'Total After Discount',
                    ),
                    SText(
                      txt: formatMoney(totalAfterDiscount.toString()),
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    ContainedButton(
                      text: 'Verif',
                      isDisabled: widget.item.treatmentTx!.status == 'FINISH' ||
                              widget.item.treatmentTx!.status == 'CALCULATED'
                          ? false
                          : true,
                      onClickAction: () async {
                        var send = widget.item.treatmentTx!;
                        send.discount = double.parse(
                            formatUnMoney(controlDiscount.text.toString()));
                        await calculate(send);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return loading();
        }
      },
    );
  }

  Future<bool> setup() async {
    await apiTreatment.calculateTx(widget.item.treatmentTx!, false, context);
    var x = await apiTreatment.getDetailTx(
        widget.item.treatmentTx!.idTreatmentTx!, context);
    realItem = x.treatmentTx!;

    // populate treatment
    for (var i = 0; i < x.treatment!.length; i++) {
      var modelTreatment = x.treatment![i];
      listWidgetTreatment.add(itemTextTreatment(modelTreatment));
    }
    totalTreatment = realItem.treatmentPrice!;

    // populate inventory
    for (var i = 0; i < x.treatmentUsage!.length; i++) {
      var modelTreatmentUsage = x.treatmentUsage![i];
      var modelInventory = await apiInventory.getDetail(
          modelTreatmentUsage.idInventory!, context);
      listWidgetInventory
          .add(itemTextInventory(modelInventory, modelTreatmentUsage));
    }
    totalInventory = realItem.inventoryPrice!;

    totalBeforeDiscount = realItem.totalPrice!;
    discount = realItem.discount!;
    controlDiscount =
        TextEditingController(text: formatMoney(discount.toString()));
    totalAfterDiscount = realItem.realPrice!;

    return true;
  }

  Future<bool> calculate(ModelTreatmentTx send) async {
    await apiTreatment.calculateTx(widget.item.treatmentTx!, false, context);
    var x = await apiTreatment.getDetailTx(
        widget.item.treatmentTx!.idTreatmentTx!, context);
    realItem = x.treatmentTx!;

    // populate treatment
    for (var i = 0; i < x.treatment!.length; i++) {
      var modelTreatment = x.treatment![i];
      listWidgetTreatment.add(itemTextTreatment(modelTreatment));
    }
    totalTreatment = realItem.treatmentPrice!;

    // populate inventory
    for (var i = 0; i < x.treatmentUsage!.length; i++) {
      var modelTreatmentUsage = x.treatmentUsage![i];
      var modelInventory = await apiInventory.getDetail(
          modelTreatmentUsage.idInventory!, context);
      listWidgetInventory
          .add(itemTextInventory(modelInventory, modelTreatmentUsage));
    }
    totalInventory = realItem.inventoryPrice!;

    totalBeforeDiscount = realItem.totalPrice!;
    discount = realItem.discount!;
    controlDiscount =
        TextEditingController(text: formatMoney(discount.toString()));
    totalAfterDiscount = realItem.realPrice!;

    return true;
  }

  Widget itemTextInventory(
      ModelInventory modelInventory, ModelTreatmentUsage modelTreatmentUsage) {
    double thePrice = modelTreatmentUsage.realQuantity! * modelInventory.price!;
    return Text(
      '${modelInventory.name} ${modelTreatmentUsage.realQuantity} ${modelInventory.unit} ${formatMoney(thePrice.toString())}',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: FitnessAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: FitnessAppTheme.darkerText,
      ),
    );
  }

  Widget itemTextTreatment(ModelTreatment modelTreatment) {
    return Text(
      '${modelTreatment.name} ${formatMoney(modelTreatment.price.toString())} ',
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: FitnessAppTheme.fontName,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: FitnessAppTheme.darkerText,
      ),
    );
  }
}
