import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:replikasi_marketing_tracker/widgets/custom_text.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class CustomTextFields extends StatelessWidget {
  final String hintText, hintInsideText, labelText, message, alertMessage;
  final String? date, time;
  final bool obscureText, enabled, isFullDate, autoFocus, useIcon, useBorder;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final IconButton? prefixIcon, suffixIcon;
  final int maxLines, type;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Icon? icon;
  final TextAlign? textAlign;
  final double? width;

  // type 3
  final List<String>? suggestionList;
  final int? suggestionsAmount;

  const CustomTextFields({
    Key? key,
    this.type = 1,
    required this.controller,
    this.hintText = '',
    this.hintInsideText = '',
    this.labelText = '',
    this.obscureText = false,
    required this.keyboardType,
    required this.message,
    this.prefixIcon,
    this.suffixIcon,
    required this.maxLines,
    this.validator,
    this.onSubmitted,
    this.alertMessage = '',
    this.enabled = true,
    this.focusNode,
    this.textInputAction,
    this.width,
    this.date,
    this.time,
    this.icon,
    this.isFullDate = false,
    this.autoFocus = false,
    this.useIcon = false,
    this.useBorder = true,
    this.textAlign = TextAlign.start,

    // type 3
    this.suggestionList,
    this.suggestionsAmount = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: useIcon ? 20 : 0,
                ),
                Container(
                  margin: EdgeInsets.only(left: useIcon ? 15 : 0),
                  child: CustomText(hintText, 1, 25),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: useIcon ? 20 : 0,
                  child: useIcon ? prefixIcon : null,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: useIcon ? 15 : 0),
                    child: TextField(
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                      autofocus: autoFocus,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      maxLines: maxLines,
                      textAlign: textAlign ?? TextAlign.start,
                      decoration: InputDecoration(
                        suffixIcon: suffixIcon,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: useBorder ? Colors.grey : Colors.transparent,
                          width: 1,
                        )),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: useBorder ? Colors.grey : Colors.transparent,
                          width: 1,
                        )),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: useBorder ? Colors.grey : Colors.transparent,
                          width: 1,
                        )),
                        // contentPadding: EdgeInsets.only(top: 5, bottom: 5),
                        hintText: hintInsideText,
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w200,
                            fontSize: 14),
                      ),
                      controller: controller,
                      onSubmitted: onSubmitted,
                      enabled: enabled,
                      focusNode: focusNode,
                      textInputAction: textInputAction,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (type == 2) {
      return SizedBox(
        width: width,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: useIcon ? 20 : 0,
                ),
                Container(
                  margin: EdgeInsets.only(left: useIcon ? 15 : 0),
                  child: CustomText(hintText, 2, 2),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: useIcon ? 20 : 0,
                  child: useIcon ? prefixIcon : null,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: ShapeDecoration(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                      color: useBorder ? Colors.grey : Colors.transparent,
                      width: 1,
                    ))),
                    margin: EdgeInsets.only(left: useIcon ? 15 : 0),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5, top: 0),
                      child: CustomText(date ?? '', 2, 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (type == 3) {
      return Column(children: [
        Row(
          children: <Widget>[
            Container(
              width: useIcon ? 20 : 0,
            ),
            Container(
              margin: EdgeInsets.only(left: useIcon ? 15 : 0),
              child: CustomText(hintText, 2, 2),
            ),
          ],
        ),
        Container(
            width: width,
            margin: const EdgeInsets.only(bottom: 15),
            child: SimpleAutoCompleteTextField(
              controller: controller,
              suggestions: suggestionList!,
              suggestionsAmount: suggestionsAmount!,
              // textChanged: (text) => print(text),
              clearOnSubmit: false,
              textSubmitted: (text) {
                controller.text = text;
                focusNode!.unfocus();
              },
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                suffixIcon: suffixIcon,
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1,
                )),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1),
                ),
                // contentPadding: EdgeInsets.only(top: 5, bottom: 5),
              ),
              focusNode: focusNode,
              textInputAction: textInputAction?? TextInputAction.done, key: GlobalKey(),
            ))
      ]);
    } else {
      return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: TextFormField(
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              contentPadding: const EdgeInsets.all(20),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0)),
              border: const OutlineInputBorder(),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black26),
              labelText: labelText,
            ),
            controller: controller,
            validator: validator,
            enabled: enabled,
            focusNode: focusNode,
            textInputAction: textInputAction,
          ));
    }
  }
}




class FilledTextField extends StatelessWidget {
  const FilledTextField({Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: lableText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class FilledTextField2 extends StatelessWidget {
  const FilledTextField2({Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        controller: controller,
        maxLength: 100,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: lableText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

// class FilledTextFieldNum extends StatefulWidget {
//   FilledTextFieldNum(
//       {Key? key, required this.controller, required this.lableText})
//       : super(key: key);
//   final TextEditingController controller;
//   final String lableText;
//   @override
//   _FilledTextFieldNumState createState() => _FilledTextFieldNumState();
// }

// class _FilledTextFieldNumState extends State<FilledTextFieldNum> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
//       child: TextFormField(
//         controller: widget.controller,
//         keyboardType: TextInputType.number,
//         decoration: InputDecoration(
//           labelText: widget.lableText,
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
// }

class FilledTextFieldNum extends StatelessWidget {
  const FilledTextFieldNum(
      {Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: lableText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class FilledTextFieldMoney extends StatelessWidget {
  const FilledTextFieldMoney(
      {Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [ThousandsFormatter(allowFraction: true)],
        decoration: InputDecoration(
          labelText: lableText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class FilledTextFieldUrl extends StatelessWidget {
  const FilledTextFieldUrl(
      {Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.url,
        decoration: InputDecoration(
          labelText: lableText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class FilledTextFieldPass extends StatefulWidget {
  const FilledTextFieldPass(
      {Key? key, required this.controller, required this.lableText})
      : super(key: key);
  final TextEditingController controller;
  final String lableText;

  @override
  _FilledTextFieldPassState createState() => _FilledTextFieldPassState();
}

class _FilledTextFieldPassState extends State<FilledTextFieldPass> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16.0),
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
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller,
        obscureText: _passwordVisible, //This will obscure text dynamically
        decoration: InputDecoration(
          labelText: widget.lableText,
          hintText: 'Enter your password',
          border: const OutlineInputBorder(),
          // Here is key idea
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}
