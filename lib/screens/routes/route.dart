import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_treatment_tx_treatment_detail.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_appointment.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_home.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_inventory.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_inventory_tx.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_login.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_member.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_patient.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_inventory.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/model_treatment.dart';
import 'package:replikasi_marketing_tracker/model/skinologi/response/model_appointment_patient.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_treatment.dart';
import 'package:replikasi_marketing_tracker/screens/pages/page_treatment_tx.dart';
import 'package:replikasi_marketing_tracker/screens/pages/testing/page_test.dart';

part 'route.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: PageLogin,
      path: '/login',
      initial: true,
    ),

    AutoRoute(
      page: EmptyRouterPage,
      name: 'Home',
      path: '/home',
      // initial: true,
      children: [
        AutoRoute(
          page: PageHome,
          path: '',
        ),
        AutoRoute(
          page: PageTest,
          path: 'test',
        ),
        // AutoRoute(
        //   page: EmptyRouterPage,
        //   name: 'Absen',
        //   path: 'absen',
        //   children: [
        //     AutoRoute(
        //       page: PageAbsen,
        //       path: '',
        //     ),
        //     AutoRoute(
        //       page: PageAbsenDetail,
        //       name: 'AbsenDetail',
        //       path: 'detail',
        //     ),
        //   ],
        // )
      ],
    ),

    // Member
    AutoRoute(
      page: EmptyRouterPage,
      name: 'Member',
      path: '/member',
      children: [
        AutoRoute(
          page: PageMember,
          path: '',
        ),
        AutoRoute(
          page: PageMemberCreate,
          path: 'create',
        ),
        AutoRoute(
          page: EmptyRouterPage,
          name: 'MemberDetail',
          path: 'detail',
          children: [
            AutoRoute(
              page: PageMemberDetail,
              path: ':id',
            ),
            AutoRoute(
              page: PageMemberEdit,
              path: ':id/edit',
            ),
            AutoRoute(
              page: PageTreatmenTxDetail,
              name: 'TreatmentTxDetailMember',
              path: ':id/treatment/tx',
            ),
          ],
        ),
      ],
    ),

    // Inventory
    AutoRoute(
      page: EmptyRouterPage,
      name: 'Inventory',
      path: '/inventory',
      children: [
        AutoRoute(
          page: PageInventory,
          path: '',
        ),
        AutoRoute(
          page: PageInventoryCreate,
          path: 'create',
        ),
        AutoRoute(
          page: PageInventoryEdit,
          path: ':id/edit',
        ),
      ],
    ),

    // Inventory tx
    AutoRoute(
      page: EmptyRouterPage,
      name: 'InventoryTx',
      path: '/inventory/tx',
      children: [
        AutoRoute(
          page: PageInventoryTx,
          path: '',
        ),
        AutoRoute(
          page: PageInventoryTxCreate,
          path: 'create',
        ),
        AutoRoute(
          page: PageInventoryTxEdit,
          path: ':id/edit',
        ),
      ],
    ),

    AutoRoute(
      page: EmptyRouterPage,
      name: 'Treatment',
      path: '/treatment',
      children: [
        AutoRoute(
          page: PageTreatment,
          path: '',
        ),
        AutoRoute(
          page: PageTreatmentCreate,
          path: 'create',
        ),
        AutoRoute(
          page: PageTreatmentEdit,
          path: ':id/edit',
        ),
      ],
    ),

    AutoRoute(
      page: EmptyRouterPage,
      name: 'TreatmentTx',
      path: '/treatment/tx',
      children: [
        AutoRoute(
          page: PageTreatmentTx,
          path: '',
        ),
        AutoRoute(
          page: PageTreatmentTxCreate,
          path: 'create',
        ),
        AutoRoute(
          page: PageTreatmentTxUsage,
          path: ':id/usage',
        ),
        AutoRoute(
          page: PageTreatmentTxCalculation,
          path: ':id/usage',
        ),
        AutoRoute(
          page: PageTreatmenTxDetail,
          name: 'TreatmentTxDetail',
          path: ':id/detail',
        ),
      ],
    ),

    AutoRoute(
      page: EmptyRouterPage,
      name: 'Appointment',
      path: '/appointment',
      children: [
        AutoRoute(
          page: PageAppointment,
          path: '',
        ),
        AutoRoute(
          page: PageAppointmentCreate,
          path: 'create',
        ),
        AutoRoute(
          page: PageAppointmentEdit,
          path: ':id/edit',
        ),
      ],
    ),

    // // Task Manager
    // AutoRoute(
    //   page: EmptyRouterPage,
    //   name: 'TaskManager',
    //   path: '/task/manager',
    //   children: [
    //     AutoRoute(
    //       page: PageTaskManager,
    //       path: '',
    //     ),
    //     AutoRoute(
    //       page: PageTaskPersonalCreate,
    //       path: 'create/personal',
    //     ),
    //     AutoRoute(
    //       page: PageTaskCollectionCreate,
    //       path: 'create/collection',
    //     ),
    //     AutoRoute(
    //       page: EmptyRouterPage,
    //       path: 'detail/personal',
    //       name: 'TaskManagerPersonal',
    //       children: [
    //         AutoRoute(
    //           page: PageTaskManagerPersonal,
    //           path: ':id',
    //         ),
    //         AutoRoute(
    //           page: PageTaskPersonalEdit,
    //           path: 'edit/:id',
    //         ),
    //       ],
    //     ),
    //     AutoRoute(
    //       page: EmptyRouterPage,
    //       path: 'detail/collection',
    //       name: 'TaskManagerCollection',
    //       children: [
    //         AutoRoute(
    //           page: PageTaskManagerCollection,
    //           path: '',
    //         ),
    //         AutoRoute(
    //           page: PageTaskCollectionEdit,
    //           path: 'edit',
    //         ),
    //       ],
    //     ),
    //   ],
    // ),

    // // Loan Marketing
    // AutoRoute(
    //   page: EmptyRouterPage,
    //   name: 'LoanMarketing',
    //   path: '/loan/marketing',
    //   children: [
    //     AutoRoute(
    //       page: PageSubMarketingLoan,
    //       path: '',
    //     ),
    //     AutoRoute(
    //       page: PageSubMarketingLoanCreate,
    //       path: 'create',
    //     ),
    //     AutoRoute(
    //       page: EmptyRouterPage,
    //       name: 'LoanMarketingDetail',
    //       path: 'detail',
    //       children: [
    //         AutoRoute(
    //           page: PageSubMarketingLoanDetail,
    //           path: ':id',
    //         ),
    //         AutoRoute(
    //           page: PageSubMarketingLoanEdit,
    //           path: 'edit',
    //         ),
    //       ],
    //     ),
    //   ],
    // ),

    // // Deposito Marketing
    // AutoRoute(
    //   page: EmptyRouterPage,
    //   name: 'DepositoMarketing',
    //   path: '/deposito/marketing',
    //   children: [
    //     AutoRoute(
    //       page: PageSubMarketingDeposito,
    //       path: '',
    //     ),
    //     AutoRoute(
    //       page: PageSubMarketingDepositoCreate,
    //       path: 'create',
    //     ),
    //     AutoRoute(
    //       page: EmptyRouterPage,
    //       name: 'DepositoMarketingDetail',
    //       path: 'detail',
    //       children: [
    //         AutoRoute(
    //           page: PageSubMarketingDepositoDetail,
    //           path: ':id',
    //         ),
    //         AutoRoute(
    //           page: PageSubMarketingDepositoEdit,
    //           path: 'edit',
    //         ),
    //       ],
    //     ),
    //   ],
    // ),

    // // loan Manager
    // AutoRoute(
    //   page: EmptyRouterPage,
    //   name: 'LoanManager',
    //   path: '/loan/manager',
    //   children: [
    //     AutoRoute(
    //       page: PageSubManagerLoan,
    //       path: '',
    //     ),
    //     AutoRoute(
    //       page: PageSubManagerLoanDetail,
    //       path: 'detail/:id',
    //     ),
    //   ],
    // ),

    // // Deposito Manager
    // AutoRoute(
    //   page: EmptyRouterPage,
    //   name: 'DepositoManager',
    //   path: '/deposito/manager',
    //   children: [
    //     AutoRoute(
    //       page: PageSubManagerDeposito,
    //       path: '',
    //     ),
    //     AutoRoute(
    //       page: PageSubManagerDepositoDetail,
    //       path: 'detail/:id',
    //     ),
    //   ],
    // ),
  ],
)
class Route extends _$Route {}
