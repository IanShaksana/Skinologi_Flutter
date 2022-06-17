import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:replikasi_marketing_tracker/api/skinologi/api_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_appointment_patient.dart';
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
import 'package:simple_speed_dial/simple_speed_dial.dart';

class PageAppointment extends StatefulWidget {
  const PageAppointment({Key? key}) : super(key: key);

  @override
  _PageAppointmentState createState() => _PageAppointmentState();
}

class _PageAppointmentState extends State<PageAppointment> with AutoRouteAware {
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
        field: 'name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Tanggal',
        field: 'date',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Jam',
        field: 'time',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Description',
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
                      ModelAppointmentPatient item = rendererContext
                          .row.cells['id']!.value as ModelAppointmentPatient;
                      routeHelper.navigate(
                          context,
                          RouteAppointmentEdit(
                              id: item.appointment.idAppointment!, item: item));
                    },
                  ),
                  const Text('Detil')
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      ModelAppointmentPatient item = rendererContext
                          .row.cells['id']!.value as ModelAppointmentPatient;
                      await apiPatient.deleteAppointment(
                          item.appointment, context);
                      setState(() {});
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
      future: getAppointment(rows),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data as int;
          return Scaffold(
            appBar: CustomAppBar(
              text: 'Appointment',
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
                  label: 'Create Appointment',
                  onPressed: () {
                    routeHelper.navigate(
                        context, const RouteAppointmentCreate());
                  },
                  closeSpeedDialOnPressed: false,
                ),
              ],
            ),
            drawer: const CustomDrawer3(
              currentRoute: '/appointment',
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

  Future<int> getAppointment(List<PlutoRow> rows) async {
    List<ModelAppointmentPatient> listAppointment =
        await apiPatient.getAllAppointment(context);

    for (var i = 0; i < listAppointment.length; i++) {
      var item = listAppointment[i];
      rows.add(
        PlutoRow(
          cells: {
            'name': PlutoCell(value: item.patient.name),
            'date': PlutoCell(
                value: formatDateUtilString(item.appointment.date.toString())),
            'time':
                PlutoCell(value: formatClock(item.appointment.time.toString())),
            'description': PlutoCell(value: item.appointment.description),
            'id': PlutoCell(value: item),
          },
        ),
      );
    }

    return listAppointment.length;
  }
}

class PageAppointmentCreate extends StatefulWidget {
  const PageAppointmentCreate({Key? key}) : super(key: key);

  @override
  _PageAppointmentCreateState createState() => _PageAppointmentCreateState();
}

class _PageAppointmentCreateState extends State<PageAppointmentCreate> {
  TextEditingController controlName = TextEditingController();
  var controlTanggal =
      CustomDatePicker(valueReturn: '', labelText: 'Tanggal : ');
  var controlTime = CustomTimePicker(valueReturn: '', labelText: 'Waktu : ');
  TextEditingController controlDescription = TextEditingController();
  List<ModelPatient> listPatient = [];
  ModelPatient selectedPatient = ModelPatient();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPatient(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Create Appointment",
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
                    controlTanggal,
                    Row(children: const [Expanded(child: Divider())]),
                    controlTime,
                    Row(children: const [Expanded(child: Divider())]),
                    FilledTextField2(
                        controller: controlDescription,
                        lableText: 'Description'),
                    Row(children: const [Expanded(child: Divider())]),
                    ContainedButton(
                      text: 'Create',
                      isDisabled: false,
                      onClickAction: () {
                        apiPatient.createAppointment(
                          '',
                          selectedPatient.idPatient!,
                          controlTanggal,
                          controlTime,
                          controlDescription.text.toString(),
                          0,
                          context,
                        );
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

  Future<bool> getPatient() async {
    listPatient = await apiPatient.getAll(context);
    return true;
  }
}

class PageAppointmentEdit extends StatefulWidget {
  const PageAppointmentEdit(
      {Key? key, @PathParam('id') required this.id, required this.item})
      : super(key: key);
  final String id;
  final ModelAppointmentPatient item;

  @override
  _PageAppointmentEditState createState() => _PageAppointmentEditState();
}

class _PageAppointmentEditState extends State<PageAppointmentEdit> {
  TextEditingController controlName = TextEditingController();
  var controlTanggal =
      CustomDatePicker(valueReturn: '', labelText: 'Tanggal : ');
  var controlTime = CustomTimePicker(valueReturn: '', labelText: 'Waktu : ');
  TextEditingController controlDescription = TextEditingController();
  List<ModelPatient> listPatient = [];
  ModelPatient selectedPatient = ModelPatient();
  int version = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: CustomAppBar(
              text: "Edit Appointment",
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
                        selectedItem: selectedPatient,
                        items: listPatient,
                        label: "Patient",
                        onChanged: (value) {
                          selectedPatient = value!;
                        },
                      ),
                    ),
                    Row(children: const [Expanded(child: Divider())]),
                    controlTanggal,
                    Row(children: const [Expanded(child: Divider())]),
                    controlTime,
                    Row(children: const [Expanded(child: Divider())]),
                    FilledTextField2(
                        controller: controlDescription,
                        lableText: 'Description'),
                    Row(children: const [Expanded(child: Divider())]),
                    ContainedButton(
                      text: 'Edit',
                      isDisabled: false,
                      onClickAction: () => {
                        apiPatient.editAppointment(
                          widget.id,
                          selectedPatient.idPatient!,
                          controlTanggal,
                          controlTime,
                          controlDescription.text.toString(),
                          version,
                          context,
                        )
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
    controlName = TextEditingController(text: widget.item.patient.name);
    controlTanggal.setInitial2(widget.item.appointment.date!);
    controlTime.setInitial2(widget.item.appointment.time!);
    controlDescription =
        TextEditingController(text: widget.item.appointment.description);
    listPatient = await apiPatient.getAll(context);
    selectedPatient = widget.item.patient;
    version = widget.item.appointment.version!;
    return true;
  }
}
