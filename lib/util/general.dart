import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

String nullCheck({required String value}) {
  return value == 'null' ? '' : value;
}

String nullCheckZero({required String value}) {
  return value == 'null' ? '0' : value;
}

String formatDateUtil(DateTime initial) {
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(initial.toLocal());
  return formatted;
}

String formatDateTimeUtil(DateTime initial) {
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  final String formatted = formatter.format(initial.toLocal());
  return formatted;
}

String formatDateTimeUtil2(DateTime initial) {
  // final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
  final String formatted = formatter.format(initial);
  return formatted;
}

String formatDateUtilString(String initial) {
  // debugPrint("the date time "+initial);
  final parsedDate = DateTime.parse(initial).toLocal();
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final String formatted = formatter.format(parsedDate);
  return formatted;
}

String formatClock(String value) {
  final parsedDate = DateTime.parse(value).toLocal();
  final DateFormat formatter = DateFormat('HH:mm');
  final String formatted = formatter.format(parsedDate);
  return formatted;
}

String formatMoney(String value) {
  // String decimal = value.split('.')[1];
  // value = value.split('.')[0];
  // return toCurrencyString(value) + '.' + decimal;
  return toCurrencyString(value);
}

String formatUnMoney(String value) {
  value = value.replaceAll(',', '');
  return value;
}

Widget inkwellWrappingGeneral(
    {required BuildContext context,
    required Widget child,
    required VoidCallback ontap}) {
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
              onTap: () async {
                ontap();
              },
              child: child,
            ),
          ),
        ),
      )
    ],
  );
}

Widget containerWrappingGeneral(
    {required BuildContext context, required Widget child}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: child,
      )
    ],
  );
}


class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
