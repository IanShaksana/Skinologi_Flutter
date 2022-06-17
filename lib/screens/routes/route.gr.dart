// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'route.dart';

class _$Route extends RootStackRouter {
  _$Route([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    RouteLogin.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageLogin());
    },
    Home.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Member.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Inventory.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    InventoryTx.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Treatment.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    TreatmentTx.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    Appointment.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    RouteHome.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageHome());
    },
    RouteTest.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageTest());
    },
    RouteMember.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageMember());
    },
    RouteMemberCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageMemberCreate());
    },
    MemberDetail.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmptyRouterPage());
    },
    RouteMemberDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<RouteMemberDetailArgs>(
          orElse: () => RouteMemberDetailArgs(id: pathParams.getString('id')));
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageMemberDetail(key: args.key, id: args.id));
    },
    RouteMemberEdit.name: (routeData) {
      final args = routeData.argsAs<RouteMemberEditArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageMemberEdit(key: args.key, id: args.id, item: args.item));
    },
    TreatmentTxDetailMember.name: (routeData) {
      final args = routeData.argsAs<TreatmentTxDetailMemberArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageTreatmenTxDetail(
              key: args.key, id: args.id, item: args.item));
    },
    RouteInventory.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageInventory());
    },
    RouteInventoryCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageInventoryCreate());
    },
    RouteInventoryEdit.name: (routeData) {
      final args = routeData.argsAs<RouteInventoryEditArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PageInventoryEdit(key: args.key, id: args.id, item: args.item));
    },
    RouteInventoryTx.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageInventoryTx());
    },
    RouteInventoryTxCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageInventoryTxCreate());
    },
    RouteInventoryTxEdit.name: (routeData) {
      final args = routeData.argsAs<RouteInventoryTxEditArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PageInventoryTxEdit(key: args.key, id: args.id, item: args.item));
    },
    RouteTreatment.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageTreatment());
    },
    RouteTreatmentCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageTreatmentCreate());
    },
    RouteTreatmentEdit.name: (routeData) {
      final args = routeData.argsAs<RouteTreatmentEditArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PageTreatmentEdit(key: args.key, id: args.id, item: args.item));
    },
    RouteTreatmentTx.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageTreatmentTx());
    },
    RouteTreatmentTxCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageTreatmentTxCreate());
    },
    RouteTreatmentTxUsage.name: (routeData) {
      final args = routeData.argsAs<RouteTreatmentTxUsageArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageTreatmentTxUsage(
              key: args.key, id: args.id, item: args.item));
    },
    RouteTreatmentTxCalculation.name: (routeData) {
      final args = routeData.argsAs<RouteTreatmentTxCalculationArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageTreatmentTxCalculation(
              key: args.key, id: args.id, item: args.item));
    },
    TreatmentTxDetail.name: (routeData) {
      final args = routeData.argsAs<TreatmentTxDetailArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PageTreatmenTxDetail(
              key: args.key, id: args.id, item: args.item));
    },
    RouteAppointment.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageAppointment());
    },
    RouteAppointmentCreate.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PageAppointmentCreate());
    },
    RouteAppointmentEdit.name: (routeData) {
      final args = routeData.argsAs<RouteAppointmentEditArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PageAppointmentEdit(key: args.key, id: args.id, item: args.item));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/login', fullMatch: true),
        RouteConfig(RouteLogin.name, path: '/login'),
        RouteConfig(Home.name, path: '/home', children: [
          RouteConfig(RouteHome.name, path: '', parent: Home.name),
          RouteConfig(RouteTest.name, path: 'test', parent: Home.name)
        ]),
        RouteConfig(Member.name, path: '/member', children: [
          RouteConfig(RouteMember.name, path: '', parent: Member.name),
          RouteConfig(RouteMemberCreate.name,
              path: 'create', parent: Member.name),
          RouteConfig(MemberDetail.name,
              path: 'detail',
              parent: Member.name,
              children: [
                RouteConfig(RouteMemberDetail.name,
                    path: ':id', parent: MemberDetail.name),
                RouteConfig(RouteMemberEdit.name,
                    path: ':id/edit', parent: MemberDetail.name),
                RouteConfig(TreatmentTxDetailMember.name,
                    path: ':id/treatment/tx', parent: MemberDetail.name)
              ])
        ]),
        RouteConfig(Inventory.name, path: '/inventory', children: [
          RouteConfig(RouteInventory.name, path: '', parent: Inventory.name),
          RouteConfig(RouteInventoryCreate.name,
              path: 'create', parent: Inventory.name),
          RouteConfig(RouteInventoryEdit.name,
              path: ':id/edit', parent: Inventory.name)
        ]),
        RouteConfig(InventoryTx.name, path: '/inventory/tx', children: [
          RouteConfig(RouteInventoryTx.name,
              path: '', parent: InventoryTx.name),
          RouteConfig(RouteInventoryTxCreate.name,
              path: 'create', parent: InventoryTx.name),
          RouteConfig(RouteInventoryTxEdit.name,
              path: ':id/edit', parent: InventoryTx.name)
        ]),
        RouteConfig(Treatment.name, path: '/treatment', children: [
          RouteConfig(RouteTreatment.name, path: '', parent: Treatment.name),
          RouteConfig(RouteTreatmentCreate.name,
              path: 'create', parent: Treatment.name),
          RouteConfig(RouteTreatmentEdit.name,
              path: ':id/edit', parent: Treatment.name)
        ]),
        RouteConfig(TreatmentTx.name, path: '/treatment/tx', children: [
          RouteConfig(RouteTreatmentTx.name,
              path: '', parent: TreatmentTx.name),
          RouteConfig(RouteTreatmentTxCreate.name,
              path: 'create', parent: TreatmentTx.name),
          RouteConfig(RouteTreatmentTxUsage.name,
              path: ':id/usage', parent: TreatmentTx.name),
          RouteConfig(RouteTreatmentTxCalculation.name,
              path: ':id/usage', parent: TreatmentTx.name),
          RouteConfig(TreatmentTxDetail.name,
              path: ':id/detail', parent: TreatmentTx.name)
        ]),
        RouteConfig(Appointment.name, path: '/appointment', children: [
          RouteConfig(RouteAppointment.name,
              path: '', parent: Appointment.name),
          RouteConfig(RouteAppointmentCreate.name,
              path: 'create', parent: Appointment.name),
          RouteConfig(RouteAppointmentEdit.name,
              path: ':id/edit', parent: Appointment.name)
        ])
      ];
}

/// generated route for
/// [PageLogin]
class RouteLogin extends PageRouteInfo<void> {
  const RouteLogin() : super(RouteLogin.name, path: '/login');

  static const String name = 'RouteLogin';
}

/// generated route for
/// [EmptyRouterPage]
class Home extends PageRouteInfo<void> {
  const Home({List<PageRouteInfo>? children})
      : super(Home.name, path: '/home', initialChildren: children);

  static const String name = 'Home';
}

/// generated route for
/// [EmptyRouterPage]
class Member extends PageRouteInfo<void> {
  const Member({List<PageRouteInfo>? children})
      : super(Member.name, path: '/member', initialChildren: children);

  static const String name = 'Member';
}

/// generated route for
/// [EmptyRouterPage]
class Inventory extends PageRouteInfo<void> {
  const Inventory({List<PageRouteInfo>? children})
      : super(Inventory.name, path: '/inventory', initialChildren: children);

  static const String name = 'Inventory';
}

/// generated route for
/// [EmptyRouterPage]
class InventoryTx extends PageRouteInfo<void> {
  const InventoryTx({List<PageRouteInfo>? children})
      : super(InventoryTx.name,
            path: '/inventory/tx', initialChildren: children);

  static const String name = 'InventoryTx';
}

/// generated route for
/// [EmptyRouterPage]
class Treatment extends PageRouteInfo<void> {
  const Treatment({List<PageRouteInfo>? children})
      : super(Treatment.name, path: '/treatment', initialChildren: children);

  static const String name = 'Treatment';
}

/// generated route for
/// [EmptyRouterPage]
class TreatmentTx extends PageRouteInfo<void> {
  const TreatmentTx({List<PageRouteInfo>? children})
      : super(TreatmentTx.name,
            path: '/treatment/tx', initialChildren: children);

  static const String name = 'TreatmentTx';
}

/// generated route for
/// [EmptyRouterPage]
class Appointment extends PageRouteInfo<void> {
  const Appointment({List<PageRouteInfo>? children})
      : super(Appointment.name,
            path: '/appointment', initialChildren: children);

  static const String name = 'Appointment';
}

/// generated route for
/// [PageHome]
class RouteHome extends PageRouteInfo<void> {
  const RouteHome() : super(RouteHome.name, path: '');

  static const String name = 'RouteHome';
}

/// generated route for
/// [PageTest]
class RouteTest extends PageRouteInfo<void> {
  const RouteTest() : super(RouteTest.name, path: 'test');

  static const String name = 'RouteTest';
}

/// generated route for
/// [PageMember]
class RouteMember extends PageRouteInfo<void> {
  const RouteMember() : super(RouteMember.name, path: '');

  static const String name = 'RouteMember';
}

/// generated route for
/// [PageMemberCreate]
class RouteMemberCreate extends PageRouteInfo<void> {
  const RouteMemberCreate() : super(RouteMemberCreate.name, path: 'create');

  static const String name = 'RouteMemberCreate';
}

/// generated route for
/// [EmptyRouterPage]
class MemberDetail extends PageRouteInfo<void> {
  const MemberDetail({List<PageRouteInfo>? children})
      : super(MemberDetail.name, path: 'detail', initialChildren: children);

  static const String name = 'MemberDetail';
}

/// generated route for
/// [PageMemberDetail]
class RouteMemberDetail extends PageRouteInfo<RouteMemberDetailArgs> {
  RouteMemberDetail({Key? key, required String id})
      : super(RouteMemberDetail.name,
            path: ':id',
            args: RouteMemberDetailArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'RouteMemberDetail';
}

class RouteMemberDetailArgs {
  const RouteMemberDetailArgs({this.key, required this.id});

  final Key? key;

  final String id;

  @override
  String toString() {
    return 'RouteMemberDetailArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [PageMemberEdit]
class RouteMemberEdit extends PageRouteInfo<RouteMemberEditArgs> {
  RouteMemberEdit({Key? key, required String id, required ModelPatient item})
      : super(RouteMemberEdit.name,
            path: ':id/edit',
            args: RouteMemberEditArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteMemberEdit';
}

class RouteMemberEditArgs {
  const RouteMemberEditArgs({this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelPatient item;

  @override
  String toString() {
    return 'RouteMemberEditArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageTreatmenTxDetail]
class TreatmentTxDetailMember
    extends PageRouteInfo<TreatmentTxDetailMemberArgs> {
  TreatmentTxDetailMember(
      {Key? key,
      required String id,
      required ModelTreatmentTxTreatmentDetail item})
      : super(TreatmentTxDetailMember.name,
            path: ':id/treatment/tx',
            args: TreatmentTxDetailMemberArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'TreatmentTxDetailMember';
}

class TreatmentTxDetailMemberArgs {
  const TreatmentTxDetailMemberArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelTreatmentTxTreatmentDetail item;

  @override
  String toString() {
    return 'TreatmentTxDetailMemberArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageInventory]
class RouteInventory extends PageRouteInfo<void> {
  const RouteInventory() : super(RouteInventory.name, path: '');

  static const String name = 'RouteInventory';
}

/// generated route for
/// [PageInventoryCreate]
class RouteInventoryCreate extends PageRouteInfo<void> {
  const RouteInventoryCreate()
      : super(RouteInventoryCreate.name, path: 'create');

  static const String name = 'RouteInventoryCreate';
}

/// generated route for
/// [PageInventoryEdit]
class RouteInventoryEdit extends PageRouteInfo<RouteInventoryEditArgs> {
  RouteInventoryEdit(
      {Key? key, required String id, required ModelInventory item})
      : super(RouteInventoryEdit.name,
            path: ':id/edit',
            args: RouteInventoryEditArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteInventoryEdit';
}

class RouteInventoryEditArgs {
  const RouteInventoryEditArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelInventory item;

  @override
  String toString() {
    return 'RouteInventoryEditArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageInventoryTx]
class RouteInventoryTx extends PageRouteInfo<void> {
  const RouteInventoryTx() : super(RouteInventoryTx.name, path: '');

  static const String name = 'RouteInventoryTx';
}

/// generated route for
/// [PageInventoryTxCreate]
class RouteInventoryTxCreate extends PageRouteInfo<void> {
  const RouteInventoryTxCreate()
      : super(RouteInventoryTxCreate.name, path: 'create');

  static const String name = 'RouteInventoryTxCreate';
}

/// generated route for
/// [PageInventoryTxEdit]
class RouteInventoryTxEdit extends PageRouteInfo<RouteInventoryTxEditArgs> {
  RouteInventoryTxEdit(
      {Key? key, required String id, required ModelInventoryTx item})
      : super(RouteInventoryTxEdit.name,
            path: ':id/edit',
            args: RouteInventoryTxEditArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteInventoryTxEdit';
}

class RouteInventoryTxEditArgs {
  const RouteInventoryTxEditArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelInventoryTx item;

  @override
  String toString() {
    return 'RouteInventoryTxEditArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageTreatment]
class RouteTreatment extends PageRouteInfo<void> {
  const RouteTreatment() : super(RouteTreatment.name, path: '');

  static const String name = 'RouteTreatment';
}

/// generated route for
/// [PageTreatmentCreate]
class RouteTreatmentCreate extends PageRouteInfo<void> {
  const RouteTreatmentCreate()
      : super(RouteTreatmentCreate.name, path: 'create');

  static const String name = 'RouteTreatmentCreate';
}

/// generated route for
/// [PageTreatmentEdit]
class RouteTreatmentEdit extends PageRouteInfo<RouteTreatmentEditArgs> {
  RouteTreatmentEdit(
      {Key? key, required String id, required ModelTreatment item})
      : super(RouteTreatmentEdit.name,
            path: ':id/edit',
            args: RouteTreatmentEditArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteTreatmentEdit';
}

class RouteTreatmentEditArgs {
  const RouteTreatmentEditArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelTreatment item;

  @override
  String toString() {
    return 'RouteTreatmentEditArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageTreatmentTx]
class RouteTreatmentTx extends PageRouteInfo<void> {
  const RouteTreatmentTx() : super(RouteTreatmentTx.name, path: '');

  static const String name = 'RouteTreatmentTx';
}

/// generated route for
/// [PageTreatmentTxCreate]
class RouteTreatmentTxCreate extends PageRouteInfo<void> {
  const RouteTreatmentTxCreate()
      : super(RouteTreatmentTxCreate.name, path: 'create');

  static const String name = 'RouteTreatmentTxCreate';
}

/// generated route for
/// [PageTreatmentTxUsage]
class RouteTreatmentTxUsage extends PageRouteInfo<RouteTreatmentTxUsageArgs> {
  RouteTreatmentTxUsage(
      {Key? key, required String id, required ModelTreatmentTx item})
      : super(RouteTreatmentTxUsage.name,
            path: ':id/usage',
            args: RouteTreatmentTxUsageArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteTreatmentTxUsage';
}

class RouteTreatmentTxUsageArgs {
  const RouteTreatmentTxUsageArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelTreatmentTx item;

  @override
  String toString() {
    return 'RouteTreatmentTxUsageArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageTreatmentTxCalculation]
class RouteTreatmentTxCalculation
    extends PageRouteInfo<RouteTreatmentTxCalculationArgs> {
  RouteTreatmentTxCalculation(
      {Key? key,
      required String id,
      required ModelTreatmentTxTreatmentDetail item})
      : super(RouteTreatmentTxCalculation.name,
            path: ':id/usage',
            args: RouteTreatmentTxCalculationArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteTreatmentTxCalculation';
}

class RouteTreatmentTxCalculationArgs {
  const RouteTreatmentTxCalculationArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelTreatmentTxTreatmentDetail item;

  @override
  String toString() {
    return 'RouteTreatmentTxCalculationArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageTreatmenTxDetail]
class TreatmentTxDetail extends PageRouteInfo<TreatmentTxDetailArgs> {
  TreatmentTxDetail(
      {Key? key,
      required String id,
      required ModelTreatmentTxTreatmentDetail item})
      : super(TreatmentTxDetail.name,
            path: ':id/detail',
            args: TreatmentTxDetailArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'TreatmentTxDetail';
}

class TreatmentTxDetailArgs {
  const TreatmentTxDetailArgs({this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelTreatmentTxTreatmentDetail item;

  @override
  String toString() {
    return 'TreatmentTxDetailArgs{key: $key, id: $id, item: $item}';
  }
}

/// generated route for
/// [PageAppointment]
class RouteAppointment extends PageRouteInfo<void> {
  const RouteAppointment() : super(RouteAppointment.name, path: '');

  static const String name = 'RouteAppointment';
}

/// generated route for
/// [PageAppointmentCreate]
class RouteAppointmentCreate extends PageRouteInfo<void> {
  const RouteAppointmentCreate()
      : super(RouteAppointmentCreate.name, path: 'create');

  static const String name = 'RouteAppointmentCreate';
}

/// generated route for
/// [PageAppointmentEdit]
class RouteAppointmentEdit extends PageRouteInfo<RouteAppointmentEditArgs> {
  RouteAppointmentEdit(
      {Key? key, required String id, required ModelAppointmentPatient item})
      : super(RouteAppointmentEdit.name,
            path: ':id/edit',
            args: RouteAppointmentEditArgs(key: key, id: id, item: item),
            rawPathParams: {'id': id});

  static const String name = 'RouteAppointmentEdit';
}

class RouteAppointmentEditArgs {
  const RouteAppointmentEditArgs(
      {this.key, required this.id, required this.item});

  final Key? key;

  final String id;

  final ModelAppointmentPatient item;

  @override
  String toString() {
    return 'RouteAppointmentEditArgs{key: $key, id: $id, item: $item}';
  }
}
