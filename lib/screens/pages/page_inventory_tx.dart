import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_inventory.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_inventory_tx.dart';
import 'package:replikasi_marketing_tracker/screens/drawer/drawer.dart';
import 'package:replikasi_marketing_tracker/screens/placeholder/placeholder.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route.dart';
import 'package:replikasi_marketing_tracker/screens/routes/route_helper.dart';
import 'package:replikasi_marketing_tracker/util/general.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_app_bar.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_button.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_text_field.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

class PageInventoryTx extends StatefulWidget {
  const PageInventoryTx({Key? key}) : super(key: key);

  @override
  _PageInventoryTxState createState() => _PageInventoryTxState();
}

class _PageInventoryTxState extends State<PageInventoryTx> with AutoRouteAware {
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
        title: 'Nama Barang',
        field: 'nama',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Quantity Barang',
        field: 'quantity',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Type Tx',
        field: 'type',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'From',
        field: 'from',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'To',
        field: 'to',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Description',
        field: 'description',
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
                      var item = rendererContext.row.cells['id']!.value
                          as ModelInventoryTx;

                      routeHelper.navigate(
                          context,
                          RouteInventoryTxEdit(
                              id: item.idInventoryTx!, item: item));
                    },
                  ),
                  const Text('Edit')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () async {
                      var item = rendererContext.row.cells['id']!.value
                          as ModelInventoryTx;

                      if (item.status! == 'DRAFT') {
                        await apiInventory.verifTx(
                            item.idInventoryTx!,
                            item.idInventory!,
                            item.quantity!,
                            item.type!,
                            item.source!,
                            item.destination!,
                            item.date!,
                            item.description!,
                            item.status!,
                            item.version!,
                            context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be DRAFT'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  ),
                  const Text('Inv Verif')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      var item = rendererContext.row.cells['id']!.value
                          as ModelInventoryTx;

                      if (item.status! == 'DRAFT') {
                        await apiInventory.deleteTx(
                            item.idInventoryTx!, item.version!, context);
                        setState(() {});
                      } else {
                        const snackBar = SnackBar(
                          content: Text('Must Be DRAFT'),
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
      future: getInventory(rows),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as int;
          return Scaffold(
            appBar: CustomAppBar(
              text: 'Inventory Tx',
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
                  label: 'Create Inventory Tx',
                  onPressed: () {
                    routeHelper.navigate(
                        context, const RouteInventoryTxCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/inventory/tx',
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

  Future<int> getInventory(List<PlutoRow> rows) async {
    List<ModelInventoryTxCustom> listInventory =
        await apiInventory.getAllTx(context);

    for (var i = 0; i < listInventory.length; i++) {
      var item = listInventory[i];
      String type = '';
      String source = '';
      String destination = '';
      switch (item.inventoryTx.type!) {
        case 1:
          type = 'Add from Distributor';
          source = '-';
          destination = '-';
          break;

        case 2:
          type = 'Add from Bag';
          source = item.patient.name!;
          destination = 'Inventory';
          break;

        case 3:
          type = 'Loss to Bag';
          source = 'Inventory';
          destination = item.patient.name!;
          break;

        case 4:
          type = 'Gone';
          source = '-';
          destination = '-';
          break;

        case 5:
          type = 'Treatment add to bag';
          source =
              'Treatement ${item.patient.name} tanggal ${item.inventoryTx.date} ';
          destination = item.patient.name!;
          break;

        case 6:
          type = 'Treatment use';
          source = item.patient.name!;
          destination =
              'Treatement ${item.patient.name} tanggal ${item.inventoryTx.date} ';
          break;

        default:
          break;
      }
      if (item.inventoryTx.type != 5 || item.inventoryTx.type != 6) {
        rows.add(
          PlutoRow(
            cells: {
              'nama': PlutoCell(value: item.inventory.name),
              'quantity': PlutoCell(
                  value: '${item.inventoryTx.quantity} ${item.inventory.unit}'),
              'type': PlutoCell(value: type),
              'from': PlutoCell(value: source),
              'to': PlutoCell(value: destination),
              'description': PlutoCell(value: item.inventoryTx.description),
              'date': PlutoCell(value: formatDateUtil(item.inventoryTx.date!)),
              'status': PlutoCell(value: item.inventoryTx.status),
              'id': PlutoCell(value: item.inventoryTx),
            },
          ),
        );
      }
    }

    return listInventory.length;
  }
}

class PageInventoryTxCreate extends StatefulWidget {
  const PageInventoryTxCreate({Key? key}) : super(key: key);

  @override
  _PageInventoryTxCreateState createState() => _PageInventoryTxCreateState();
}

class _PageInventoryTxCreateState extends State<PageInventoryTxCreate> {
  String selectedInventory = '';
  TextEditingController controlQuantity = TextEditingController();
  String selectedType = '';
  String selectedSource = '';
  String selectedDestination = '';
  TextEditingController controlDescription = TextEditingController();

  List<String> txType = [
    'Add from Distributor',
    'Add from Bag',
    'Loss to Bag',
    'Gone'
  ];

  List<ModelPatient> listSource = [];
  List<ModelPatient> listDestination = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourceAndDestination(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Create Inventory Tx",
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
                      child: DropdownSearch<ModelInventory>(
                        mode: Mode.MENU,
                        itemAsString: (item) => nullCheck(
                            value:
                                '${item!.name!} qty: ${item.quantity!} ${item.unit!}'),
                        onFind: (text) {
                          return apiInventory.getAll(context);
                        },
                        label: "Inventory",
                        onChanged: (value) {
                          selectedInventory = value!.idInventory!;
                        },
                      ),
                    ),
                    FilledTextField2(
                        controller: controlQuantity, lableText: 'Quantity'),
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
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        itemAsString: (item) => nullCheck(value: item!),
                        items: txType,
                        label: "Tx Type",
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ),
                    selectedType ==
                            'Add from Bag' /*&& selectedType == 'Loss to Bag'*/
                        ? Container(
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
                              itemAsString: (item) =>
                                  nullCheck(value: item!.name!),
                              items: listSource,
                              label: "From",
                              onChanged: (value) {
                                selectedSource = value!.idPatient!;
                              },
                            ),
                          )
                        : Container(),
                    /*selectedType == 'Add from Bag' &&*/ selectedType ==
                            'Loss to Bag'
                        ? Container(
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
                              itemAsString: (item) =>
                                  nullCheck(value: item!.name!),
                              items: listDestination,
                              label: "To",
                              onChanged: (value) {
                                selectedDestination = value!.idPatient!;
                              },
                            ),
                          )
                        : Container(),
                    FilledTextField2(
                        controller: controlDescription,
                        lableText: 'Description'),
                    ContainedButton(
                      text: 'Create',
                      isDisabled: false,
                      onClickAction: () => {
                        apiInventory.createTx(
                            '',
                            selectedInventory,
                            int.parse(controlQuantity.text),
                            selectedType,
                            selectedSource,
                            selectedDestination,
                            DateTime.now(),
                            controlDescription.text,
                            '',
                            0,
                            context)
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

  Future<bool> getSourceAndDestination() async {
    listSource = await apiPatient.getAll(context);
    // listSource.add(ModelPatient(idPatient: 'DISTRIBUTOR', name: 'DISTRIBUTOR'));
    listDestination = await apiPatient.getAll(context);
    // listSource.add(ModelPatient(idPatient: 'Gone', name: 'Gone'));
    return true;
  }
}

class PageInventoryTxEdit extends StatefulWidget {
  const PageInventoryTxEdit(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelInventoryTx item;

  @override
  _PageInventoryTxEditState createState() => _PageInventoryTxEditState();
}

class _PageInventoryTxEditState extends State<PageInventoryTxEdit> {
  String selectedInventory = '';
  late ModelInventory selectedItemInventory;
  TextEditingController controlQuantity = TextEditingController();
  String selectedType = '';
  String selectedSource = '';
  late ModelPatient selectedItemSource;
  String selectedDestination = '';
  late ModelPatient selectedItemDestination;
  TextEditingController controlDescription = TextEditingController();

  List<String> txType = [
    'Add from Distributor',
    "Add from Bag",
    'Loss to Bag',
    'Gone'
  ];

  List<ModelPatient> listSource = [];
  List<ModelPatient> listDestination = [];

  int version = 0;
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future(edit),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                        onFind: (text) {
                          return apiInventory.getAll(context);
                        },
                        selectedItem: selectedItemInventory,
                        label: "Inventory",
                        onChanged: (value) {
                          selectedInventory = value!.idInventory!;
                        },
                      ),
                    ),
                    FilledTextField2(
                        controller: controlQuantity, lableText: 'Quantity'),
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
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        itemAsString: (item) => nullCheck(value: item!),
                        items: txType,
                        selectedItem: selectedType,
                        label: "Tx Type",
                        onChanged: (value) {
                          setState(() {
                            selectedType = value!;
                            edit = true;
                          });
                        },
                      ),
                    ),
                    selectedType ==
                            'Add from Bag' /*&& selectedType == 'Loss to Bag'*/
                        ? Container(
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
                              itemAsString: (item) =>
                                  nullCheck(value: item!.name!),
                              items: listSource,
                              selectedItem: selectedItemSource,
                              label: "From",
                              onChanged: (value) {
                                selectedSource = value!.idPatient!;
                              },
                            ),
                          )
                        : Container(),
                    /*selectedType == 'Add from Bag' &&*/ selectedType ==
                            'Loss to Bag'
                        ? Container(
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
                              itemAsString: (item) =>
                                  nullCheck(value: item!.name!),
                              selectedItem: selectedItemDestination,
                              items: listDestination,
                              label: "To",
                              onChanged: (value) {
                                selectedDestination = value!.idPatient!;
                              },
                            ),
                          )
                        : Container(),
                    FilledTextField2(
                        controller: controlDescription,
                        lableText: 'Description'),
                    ContainedButton(
                      text: 'Edit',
                      isDisabled: false,
                      onClickAction: () {
                        // need snack
                        apiInventory.editTx(
                            widget.id,
                            selectedInventory,
                            int.parse(controlQuantity.text),
                            selectedType,
                            selectedSource,
                            selectedDestination,
                            DateTime.now(),
                            controlDescription.text,
                            '',
                            version,
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

  Future<bool> future(bool edit) async {
    if (!edit) {
      await getSourceAndDestination();
      await setup();
    }
    return true;
  }

  Future<void> getSourceAndDestination() async {
    listSource = await apiPatient.getAll(context);
    // listSource.add(ModelPatient(idPatient: 'DISTRIBUTOR', name: 'DISTRIBUTOR'));
    listDestination = await apiPatient.getAll(context);
    // listSource.add(ModelPatient(idPatient: 'Gone', name: 'Gone'));
  }

  Future<void> setup() async {
    controlQuantity =
        TextEditingController(text: widget.item.quantity.toString());
    controlDescription = TextEditingController(text: widget.item.description);
    selectedItemInventory =
        await apiInventory.getDetail(widget.item.idInventory!, context);
    selectedInventory = selectedItemInventory.idInventory!;
    if (widget.item.type! == 2 || widget.item.type! == 3) {
      if (widget.item.type == 2) {
        selectedItemSource =
            await apiPatient.getDetail(widget.item.source!, context);
        selectedSource = selectedItemSource.idPatient!;

        //
        selectedItemDestination = ModelPatient(name: '');
        selectedDestination = '';
      }
      if (widget.item.type == 3) {
        selectedItemDestination =
            await apiPatient.getDetail(widget.item.destination!, context);
        selectedDestination = selectedItemDestination.idPatient!;

        //
        selectedItemSource = ModelPatient(name: '');
        selectedSource = '';
      }
    } else {
      selectedItemSource = ModelPatient(name: '');
      selectedItemDestination = ModelPatient(name: '');
    }

    switch (widget.item.type!) {
      case 1:
        selectedType = 'Add from Distributor';
        break;

      case 2:
        selectedType = 'Add from Bag';
        break;

      case 3:
        selectedType = 'Loss to Bag';
        break;

      case 4:
        selectedType = 'Gone';
        break;

      default:
        break;
    }
    version = widget.item.version!;
  }
}
