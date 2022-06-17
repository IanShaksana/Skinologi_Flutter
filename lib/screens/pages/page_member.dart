import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_patient.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_bag_detail_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/screens/drawer/drawer.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_app_bar.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_button.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_date_picker.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_text_field.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/s_card_detail.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class PageMember extends StatefulWidget {
  const PageMember({Key? key}) : super(key: key);

  @override
  _PageMemberState createState() => _PageMemberState();
}

class _PageMemberState extends State<PageMember> with AutoRouteAware {
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
        title: 'Nama',
        field: 'nama',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Alamat',
        field: 'alamat',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'DOB',
        field: 'DOB',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Created At',
        field: 'createdat',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'Action',
        field: 'id',
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
                      String id =
                          rendererContext.row.cells['id']!.value.toString();
                      routeHelper.navigate(context,
                          MemberDetail(children: [RouteMemberDetail(id: id)]));
                    },
                  ),
                  const Text('Detil')
                ],
              ),

              // IconButton(
              //   icon: const Icon(Icons.delete),
              //   onPressed: () {
              //     String id = rendererContext.row.cells['id']!.value.toString();
              //   },
              // ),
            ],
          );
        },
      ),
    ];
    List<PlutoRow> rows = [];

    return FutureBuilder(
      future: getMember(rows),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as int;
          return Scaffold(
            appBar: CustomAppBar(
              text: 'Member',
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
                  label: 'Create Member',
                  onPressed: () {
                    routeHelper.navigate(context, const RouteMemberCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/member',
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

  Future<int> getMember(List<PlutoRow> rows) async {
    List<ModelPatient> listPatient = await apiPatient.getAll(context);

    for (var i = 0; i < listPatient.length; i++) {
      var item = listPatient[i];
      rows.add(
        PlutoRow(
          cells: {
            'id': PlutoCell(value: item.idPatient),
            'nama': PlutoCell(value: item.name),
            'alamat': PlutoCell(value: item.address),
            'DOB': PlutoCell(value: item.dob),
            'status': PlutoCell(value: item.status),
            'createdat': PlutoCell(value: item.createdAt),
          },
        ),
      );
    }

    return listPatient.length;
  }
}

class PageMemberDetail extends StatefulWidget {
  const PageMemberDetail({Key? key, @PathParam('id') required this.id})
      : super(key: key);
  final String id;

  @override
  _PageMemberDetailState createState() => _PageMemberDetailState();
}

class _PageMemberDetailState extends State<PageMemberDetail>
    with AutoRouteAware {
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

  bool showDetail = true;
  bool showTreatment = false;
  bool showTreatmentDetail = false;
  bool showBag = false;

  TextEditingController conNote = TextEditingController();

  late ModelPatient modelPatient;
  late List<ModelTreatmentTxTreatmentDetail> modelTreatmentTxTreatmentDetail;
  late List<ModelBagDetailInventory> modelBagDetailInventory;

  @override
  Widget build(BuildContext context) {
    PlutoGridStateManager? stateManagerTreatment;
    PlutoGridStateManager? stateManagerBag;

    return FutureBuilder(
      future: setup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var value = snapshot.data as bool;
          if (value) {
            return Scaffold(
              appBar: CustomAppBar(
                text: "Detil Member",
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
                    child: Column(
                      children: [
                        // nav
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: ContainedButton(
                                  text: 'Detail',
                                  onClickAction: () {
                                    setState(() {
                                      showDetail = true;
                                      showTreatment = !showDetail;
                                      showBag = !showDetail;
                                    });
                                  },
                                  isDisabled: false),
                            ),
                            Expanded(
                              child: ContainedButton(
                                  text: 'Treatment',
                                  onClickAction: () {
                                    setState(() {
                                      showTreatment = true;
                                      showDetail = !showTreatment;
                                      showBag = !showTreatment;
                                    });
                                  },
                                  isDisabled: false),
                            ),
                            Expanded(
                              child: ContainedButton(
                                  text: 'Bag',
                                  onClickAction: () {
                                    setState(() {
                                      showBag = true;
                                      showDetail = !showBag;
                                      showTreatment = !showBag;
                                    });
                                  },
                                  isDisabled: false),
                            )
                          ],
                        ),
                        // detail
                        getViewDetail(),
                        getViewTreatment(stateManagerTreatment,
                            modelTreatmentTxTreatmentDetail),
                        getViewBag(stateManagerBag, modelBagDetailInventory),
                      ],
                    ),
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
    try {
      modelPatient = await apiPatient.getDetail(widget.id, context);
      modelTreatmentTxTreatmentDetail =
          await apiTreatment.getAllTxByPerson(modelPatient.idPatient!, context);
      modelBagDetailInventory = await apiPatient.getBag(widget.id, context);
      return true;
    } catch (e) {
      return false;
    }
  }

  Widget getViewDetail() {
    if (showDetail) {
      return Column(
        children: [
          ScardMember(item: modelPatient),
          Row(
            children: [
              Expanded(
                child: ContainedButton(
                    text: 'Edit',
                    onClickAction: () {
                      routeHelper.navigate(
                        context,
                        RouteMemberEdit(id: widget.id, item: modelPatient),
                      );
                    },
                    isDisabled: false),
              ),
            ],
          )
        ],
      );
    } else {
      return Container();
    }
  }

  Widget getViewTreatment(PlutoGridStateManager? stateManager,
      List<ModelTreatmentTxTreatmentDetail> modelTreatmentTxTreatmentDetail) {
    List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Id Treatment',
        field: 'id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Tanggal Treatment',
        field: 'tanggal',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  String id = rendererContext.row.cells['id']!.value.toString();

                  ModelTreatmentTxTreatmentDetail item = rendererContext
                      .row
                      .cells['action']!
                      .value as ModelTreatmentTxTreatmentDetail;
                  debugPrint(id);
                  routeHelper.navigate(
                      context, TreatmentTxDetailMember(id: id, item: item));
                },
              ),
            ],
          );
        },
      ),
    ];
    List<PlutoRow> rows = [];

    for (var i = 0; i < modelTreatmentTxTreatmentDetail.length; i++) {
      var item = modelTreatmentTxTreatmentDetail[i];
      rows.add(
        PlutoRow(
          cells: {
            'id': PlutoCell(value: item.treatmentTx!.idTreatmentTx),
            'tanggal':
                PlutoCell(value: '${formatDateUtil(item.treatmentTx!.date!)} '),
            'action': PlutoCell(value: item),
          },
        ),
      );
    }

    if (showTreatment) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 1.5,
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
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.all(10),
              child: noItem(modelBagDetailInventory.isEmpty)),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget getViewBag(PlutoGridStateManager? stateManager,
      List<ModelBagDetailInventory> modelBagDetailInventory) {
    List<PlutoColumn> columns = <PlutoColumn>[
      PlutoColumn(
        title: 'Nama Barang',
        field: 'nama',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Quantity Barang',
        field: 'quantity',
        type: PlutoColumnType.text(),
      ),
    ];
    List<PlutoRow> rows = [];

    for (var i = 0; i < modelBagDetailInventory.length; i++) {
      var item = modelBagDetailInventory[i];
      rows.add(
        PlutoRow(
          cells: {
            'nama': PlutoCell(value: item.inventory.name),
            'quantity': PlutoCell(
                value: '${item.bagDetail.quantity} ${item.inventory.unit}'),
          },
        ),
      );
    }

    if (showBag) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 1.5,
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
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 1.5,
              padding: const EdgeInsets.all(10),
              child: noItem(modelBagDetailInventory.isEmpty)),
        ],
      );
    } else {
      return Container();
    }
  }
}

class PageMemberCreate extends StatefulWidget {
  const PageMemberCreate({Key? key}) : super(key: key);

  @override
  _PageMemberCreateState createState() => _PageMemberCreateState();
}

class _PageMemberCreateState extends State<PageMemberCreate> {
  TextEditingController controlName = TextEditingController();
  var controlDob = CustomDatePicker(valueReturn: '', labelText: 'DOB : ');
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlAddress = TextEditingController();
  TextEditingController controlContact = TextEditingController();
  String controlBlood = '';

  List<String> bloodType = ['O', "AB", 'A', 'B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Create Member",
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
              FilledTextField2(controller: controlName, lableText: 'Name'),
              controlDob,
              FilledTextField2(controller: controlEmail, lableText: 'Email'),
              FilledTextField2(
                  controller: controlAddress, lableText: 'Address'),
              FilledTextField2(
                  controller: controlContact, lableText: 'Contact'),
              Container(
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
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  itemAsString: (item) => nullCheck(value: item!),
                  items: bloodType,
                  label: "Blood Type",
                  onChanged: (value) {
                    controlBlood = value!;
                  },
                ),
              ),
              ContainedButton(
                text: 'Create',
                isDisabled: false,
                onClickAction: () => {
                  apiPatient.create(
                      '',
                      controlName.text,
                      controlDob,
                      controlEmail.text,
                      controlAddress.text,
                      controlContact.text,
                      controlBlood,
                      '',
                      '',
                      context)
                },
                // onClickAction: () => {null},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageMemberEdit extends StatefulWidget {
  const PageMemberEdit(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelPatient item;

  @override
  _PageMemberEditState createState() => _PageMemberEditState();
}

class _PageMemberEditState extends State<PageMemberEdit> {
  TextEditingController controlName = TextEditingController();
  var controlDob = CustomDatePicker(valueReturn: '', labelText: 'DOB : ');
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlAddress = TextEditingController();
  TextEditingController controlContact = TextEditingController();
  String controlBlood = '';
  int version = 0;

  List<String> bloodType = ['O', 'AB', 'A', 'B'];

  @override
  Widget build(BuildContext context) {
    setup();
    return Scaffold(
      appBar: CustomAppBar(
        text: "Edit Member",
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
              FilledTextField2(controller: controlName, lableText: 'Name'),
              controlDob,
              FilledTextField2(controller: controlEmail, lableText: 'Email'),
              FilledTextField2(
                  controller: controlAddress, lableText: 'Address'),
              FilledTextField2(
                  controller: controlContact, lableText: 'Contact'),
              Container(
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
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  itemAsString: (item) => nullCheck(value: item!),
                  onFind: (text) {
                    return getBloodType();
                  },
                  selectedItem: controlBlood,
                  // items: bloodType,
                  label: "Blood Type",
                  onChanged: (value) {
                    controlBlood = value!;
                  },
                ),
              ),
              ContainedButton(
                text: 'Edit',
                isDisabled: false,
                onClickAction: () => {
                  apiPatient.edit(
                      widget.id,
                      controlName.text,
                      controlDob,
                      controlEmail.text,
                      controlAddress.text,
                      controlContact.text,
                      controlBlood,
                      '',
                      '',
                      version,
                      context)
                },
                // onClickAction: () => {null},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setup() {
    debugPrint('CONT ${widget.item.blood}');
    controlName = TextEditingController(text: widget.item.name);
    controlDob.setInitial2(widget.item.dob!);
    controlEmail = TextEditingController(text: widget.item.email);
    controlAddress = TextEditingController(text: widget.item.address);
    controlContact = TextEditingController(text: widget.item.contact);
    controlBlood = widget.item.blood!;
    version = widget.item.version!;
  }

  Future<List<String>> getBloodType() async {
    return bloodType;
  }
}
