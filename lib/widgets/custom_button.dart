import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

// class CustomButton extends StatelessWidget {
//   final Widget child;
//   final Color backgroundColor, splashColor;
//   final bool fill, rounded, border, loading;
//   final VoidCallback onTap;
//   final double borderRadius;
//   final double? width, height;

//   const CustomButton(
//       {Key? key,
//       required this.child,
//       this.backgroundColor = Colors.blue,
//       required this.onTap,
//       this.splashColor = Colors.white,
//       this.fill = true,
//       this.rounded = false,
//       this.border = true,
//       this.loading = false,
//       this.borderRadius = 50.0,
//       this.width,
//       this.height})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (loading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return fill
//         ? SizedBox(
//             width: width,
//             height: height,
//             child: RaisedButton(
//               padding: const EdgeInsets.all(0),
//               key: key,
//               color: backgroundColor,
//               child: child,
//               splashColor: splashColor,
//               onPressed: onTap,
//               shape: rounded
//                   ? RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(borderRadius))
//                   : null,
//             ))
//         : border
//             ? SizedBox(
//                 width: width,
//                 height: height,
//                 child: OutlineButton(
//                   padding: const EdgeInsets.all(0),
//                   key: key,
//                   child: child,
//                   color: Colors.white,
//                   splashColor: splashColor,
//                   onPressed: onTap,
//                   shape: rounded
//                       ? RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(borderRadius))
//                       : null,
//                   borderSide: BorderSide(
//                     color: backgroundColor, //Color of the border
//                     style: BorderStyle.solid, //Style of the border
//                     width: 2.0, //width of the border
//                   ),
//                   highlightedBorderColor: backgroundColor,
//                 ))
//             : SizedBox(
//                 width: width,
//                 height: height,
//                 child: FlatButton(
//                   key: key,
//                   child: child,
//                   splashColor: splashColor,
//                   onPressed: onTap,
//                 ));
//   }
// }

class ContainedButton extends StatelessWidget {
  const ContainedButton(
      {Key? key,
      required this.text,
      required this.onClickAction,
      required this.isDisabled})
      : super(key: key);
  final String text;
  final VoidCallback onClickAction;
  final bool isDisabled;
  @override
  Widget build(BuildContext context) {
    // if (!isDisabled) {
    //   return Container(
    //     margin: const EdgeInsets.all(6.0),
    //     child: ElevatedButton(
    //       onPressed: () {
    //         onClickAction();
    //       },
    //       child: Text(text),
    //     ),
    //   );
    // } else {
    //   return Container(
    //     margin: const EdgeInsets.all(6.0),
    //     child: ElevatedButton(
    //       onPressed: null,
    //       child: Text(text),
    //     ),
    //   );
    // }

    return item();
  }

  Widget item() {
    return Sbtn(
      text: text,
      onPressed: () {
        if (!isDisabled) {
          onClickAction();
        }
      },
      state: !isDisabled,
      snack: false,
    );
  }
}

class Sbtn extends StatefulWidget {
  const Sbtn(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.state,
      required this.snack})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final bool state;
  final bool snack;
  @override
  _SbtnState createState() => _SbtnState();
}

class _SbtnState extends State<Sbtn> {
  @override
  Widget build(BuildContext context) {
    return item();
  }

  Widget item() {
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //     Expanded(
    //       child: Container(
    //         margin: const EdgeInsets.all(10.0),
    //         decoration: BoxDecoration(
    //           color: widget.state ? AppTheme.white : Colors.grey[350],
    //           borderRadius: BorderRadius.circular(8),
    //           boxShadow: <BoxShadow>[
    //             BoxShadow(
    //                 color: Colors.grey.withOpacity(0.8),
    //                 offset: const Offset(4, 4),
    //                 blurRadius: 8),
    //           ],
    //         ),
    //         child: Material(
    //           color: Colors.transparent,
    //           child: InkWell(
    //             focusColor: Colors.transparent,
    //             highlightColor: Colors.transparent,
    //             hoverColor: Colors.transparent,
    //             borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    //             splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
    //             onTap: () {
    //               widget.onPressed();
    //               if (widget.snack) {
    //                 var snackbar = const SnackBar(
    //                   content: Text('Sukses'),
    //                   duration: Duration(seconds: 2),
    //                 );
    //                 ScaffoldMessenger.of(context).showSnackBar(snackbar);
    //               }
    //             },
    //             child: Padding(
    //               padding: const EdgeInsets.all(10.0),
    //               child: Text(
    //                 widget.text,
    //                 textAlign: TextAlign.center,
    //                 style: TextStyle(
    //                   fontFamily: FitnessAppTheme.fontName,
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: 16,
    //                   letterSpacing: 0.0,
    //                   color: widget.state
    //                       ? FitnessAppTheme.nearlyDarkBlue
    //                       : Colors.grey,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: widget.state ? AppTheme.white : Colors.grey[350],
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(4, 4),
              blurRadius: 8),
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
          onTap: () {
            widget.onPressed();
            if (widget.snack) {
              var snackbar = const SnackBar(
                content: Text('Sukses'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 24,
                letterSpacing: 0.0,
                color:
                    widget.state ? FitnessAppTheme.nearlyDarkBlue : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
