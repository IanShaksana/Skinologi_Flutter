import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
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

class PageInventory extends StatefulWidget {
  const PageInventory({Key? key}) : super(key: key);

  @override
  _PageInventoryState createState() => _PageInventoryState();
}

class _PageInventoryState extends State<PageInventory> with AutoRouteAware {
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
        title: 'Deskripsi Barang',
        field: 'description',
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
                      ModelInventory item = rendererContext
                          .row.cells['id']!.value as ModelInventory;
                      routeHelper.navigate(
                          context,
                          RouteInventoryEdit(
                              id: item.idInventory!, item: item));
                    },
                  ),
                  const Text('Detil')
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.delete),
              //   onPressed: () {
              //     // String id = rendererContext.row.cells['id']!.value.toString();
              //   },
              // ),
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
              text: 'Inventory',
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
                  label: 'Create Inventory',
                  onPressed: () {
                    routeHelper.navigate(context, const RouteInventoryCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/inventory',
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
    List<ModelInventory> listInventory = await apiInventory.getAll(context);

    for (var i = 0; i < listInventory.length; i++) {
      var item = listInventory[i];
      rows.add(
        PlutoRow(
          cells: {
            'nama': PlutoCell(value: item.name),
            'quantity': PlutoCell(value: '${item.quantity} ${item.unit}'),
            'description': PlutoCell(value: item.description),
            'id': PlutoCell(value: item),
          },
        ),
      );
    }

    return listInventory.length;
  }
}

class PageInventoryCreate extends StatefulWidget {
  const PageInventoryCreate({Key? key}) : super(key: key);

  @override
  _PageInventoryCreateState createState() => _PageInventoryCreateState();
}

class _PageInventoryCreateState extends State<PageInventoryCreate> {
  TextEditingController controlName = TextEditingController();
  TextEditingController controlUnit = TextEditingController();
  TextEditingController controlDescription = TextEditingController();
  TextEditingController controlQuantity = TextEditingController();
  TextEditingController controlPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Create Inventory",
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
              FilledTextField2(controller: controlUnit, lableText: 'Unit'),
              FilledTextField2(
                  controller: controlDescription, lableText: 'Description'),
              FilledTextField2(
                  controller: controlQuantity, lableText: 'Initial Quantity'),
              FilledTextFieldMoney(
                  controller: controlPrice, lableText: 'Price'),
              ContainedButton(
                text: 'Create',
                isDisabled: false,
                onClickAction: () => {
                  apiInventory.create(
                      '',
                      controlName.text,
                      controlUnit.text,
                      controlDescription.text,
                      int.parse(controlQuantity.text),
                      double.parse(formatUnMoney(controlPrice.text)),
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
  }
}

class PageInventoryEdit extends StatefulWidget {
  const PageInventoryEdit(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelInventory item;

  @override
  _PageInventoryEditState createState() => _PageInventoryEditState();
}

class _PageInventoryEditState extends State<PageInventoryEdit> {
  TextEditingController controlName = TextEditingController();
  TextEditingController controlUnit = TextEditingController();
  TextEditingController controlDescription = TextEditingController();
  TextEditingController controlPrice = TextEditingController();

  int version = 0;

  @override
  Widget build(BuildContext context) {
    setup();
    return Scaffold(
      appBar: CustomAppBar(
        text: "Edit Inventory",
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
              FilledTextField2(controller: controlUnit, lableText: 'Unit'),
              FilledTextField2(
                  controller: controlDescription, lableText: 'Description'),
              FilledTextFieldMoney(
                  controller: controlPrice, lableText: 'Price'),
              ContainedButton(
                text: 'Edit',
                isDisabled: false,
                onClickAction: () => {
                  apiInventory.edit(
                      widget.id,
                      controlName.text,
                      controlUnit.text,
                      controlDescription.text,
                      0,
                      double.parse(formatUnMoney(controlPrice.text)),
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
    controlName = TextEditingController(text: widget.item.name);
    controlUnit = TextEditingController(text: widget.item.unit);
    controlDescription = TextEditingController(text: widget.item.description);
    controlPrice =
        TextEditingController(text: formatMoney(widget.item.price.toString()));
    version = widget.item.version!;
  }
}
