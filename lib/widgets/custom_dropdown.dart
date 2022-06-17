// import 'dart:core';

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:replikasi_marketing_tracker/util/general.dart';
// import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

// class CustomDropDown extends StatefulWidget {
//   CustomDropDown(
//       {Key? key,
//       required this.dropdownValue,
//       required this.stringArray,
//       required this.choosen,
//       required this.initialValue})
//       : super(key: key);
//   String dropdownValue;
//   final List<String> stringArray;
//   String choosen;
//   String initialValue;

//   @override
//   _CustomDropDownState createState() => _CustomDropDownState();

//   String getChoosen() {
//     return choosen;
//   }

//   void setInitial(String initial) {
//     dropdownValue = initial;
//     choosen = initial;
//   }
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     // return Row(
//     //   mainAxisAlignment: MainAxisAlignment.start,
//     //   children: [
//     //     Text(widget.initialValue),
//     //     Expanded(
//     //         child: DropdownButton<String>(
//     //       value: widget.dropdownValue,
//     //       style: const TextStyle(color: Colors.deepPurple),
//     //       underline: Container(
//     //         height: 2,
//     //         color: Colors.deepPurpleAccent,
//     //       ),
//     //       onChanged: (String? newValue) {
//     //         setState(() {
//     //           widget.dropdownValue = newValue!;
//     //           widget.choosen = newValue;
//     //         });
//     //       },
//     //       items:
//     //           widget.stringArray.map<DropdownMenuItem<String>>((String value) {
//     //         return DropdownMenuItem<String>(
//     //           value: value,
//     //           child: Text(value),
//     //         );
//     //       }).toList(),
//     //     )),
//     //   ],
//     // );

//     return customRow();
//   }

//   Widget customRow() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 16.0),
//       decoration: BoxDecoration(
//         color: AppTheme.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//               color: Colors.grey.withOpacity(0.8),
//               offset: const Offset(4, 4),
//               blurRadius: 8),
//         ],
//       ),
//       child: DropdownSearch<String>(
//         mode: Mode.MENU,
//         itemAsString: (item) => nullCheck(value: item!),
//         selectedItem: widget.getChoosen(),
//         items: widget.stringArray,
//         label: widget.initialValue,
//         onChanged: (value) {
//           setState(() {
//             widget.dropdownValue = value!;
//             widget.choosen = value;
//           });
//         },
//       ),
//     );
//   }
// }
