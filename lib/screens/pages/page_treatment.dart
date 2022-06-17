import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
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

class PageTreatment extends StatefulWidget {
  const PageTreatment({Key? key}) : super(key: key);

  @override
  _PageTreatmentState createState() => _PageTreatmentState();
}

class _PageTreatmentState extends State<PageTreatment> with AutoRouteAware {
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
        title: 'Nama Treatment',
        field: 'nama',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Harga Treatment',
        field: 'price',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Deskripsi Treatment',
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
                      ModelTreatment item = rendererContext
                          .row.cells['id']!.value as ModelTreatment;
                      routeHelper.navigate(
                          context,
                          RouteTreatmentEdit(
                              id: item.idTreatment!, item: item));
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
      future: getTreatment(rows),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as int;
          return Scaffold(
            appBar: CustomAppBar(
              text: 'Treatment',
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
                  label: 'Create Treatment',
                  onPressed: () {
                    routeHelper.navigate(context, const RouteTreatmentCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/treatment',
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

  Future<int> getTreatment(List<PlutoRow> rows) async {
    List<ModelTreatment> listInventory = await apiTreatment.getAll(context);

    for (var i = 0; i < listInventory.length; i++) {
      var item = listInventory[i];
      rows.add(
        PlutoRow(
          cells: {
            'nama': PlutoCell(value: item.name),
            'price': PlutoCell(value: formatMoney(item.price.toString())),
            'description': PlutoCell(value: item.description),
            'id': PlutoCell(value: item),
          },
        ),
      );
    }

    return listInventory.length;
  }
}

class PageTreatmentCreate extends StatefulWidget {
  const PageTreatmentCreate({Key? key}) : super(key: key);

  @override
  _PageTreatmentCreateState createState() => _PageTreatmentCreateState();
}

class _PageTreatmentCreateState extends State<PageTreatmentCreate> {
  TextEditingController controlName = TextEditingController();
  TextEditingController controlDescription = TextEditingController();
  TextEditingController controlPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Create Treatment",
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
              FilledTextField2(
                  controller: controlDescription, lableText: 'Description'),
              FilledTextFieldMoney(
                  controller: controlPrice, lableText: 'Price'),
              ContainedButton(
                text: 'Create',
                isDisabled: false,
                onClickAction: () => {
                  apiTreatment.create(
                      '',
                      controlName.text,
                      controlDescription.text,
                      double.parse(formatUnMoney(controlPrice.text)),
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

class PageTreatmentEdit extends StatefulWidget {
  const PageTreatmentEdit(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelTreatment item;

  @override
  _PageTreatmentEditState createState() => _PageTreatmentEditState();
}

class _PageTreatmentEditState extends State<PageTreatmentEdit> {
  TextEditingController controlName = TextEditingController();
  TextEditingController controlDescription = TextEditingController();
  TextEditingController controlPrice = TextEditingController();

  int version = 0;

  @override
  Widget build(BuildContext context) {
    setup();
    return Scaffold(
      appBar: CustomAppBar(
        text: "Edit Treatment",
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
              FilledTextField2(
                  controller: controlDescription, lableText: 'Description'),
              FilledTextFieldMoney(
                  controller: controlPrice, lableText: 'Price'),
              ContainedButton(
                text: 'Edit',
                isDisabled: false,
                onClickAction: () => {
                  apiTreatment.edit(
                      widget.id,
                      controlName.text,
                      controlDescription.text,
                      double.parse(formatUnMoney(controlPrice.text)),
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
    controlPrice =
        TextEditingController(text: formatMoney(widget.item.price.toString()));
    controlDescription = TextEditingController(text: widget.item.description);
    version = widget.item.version!;
  }
}
