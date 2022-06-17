import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:replikasi_marketing_tracker/widgets/salvaged/app_theme.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker(
      {Key? key, required this.valueReturn, required this.labelText})
      : super(key: key);
  String valueReturn;
  String labelText;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();

  String getChoosen() {
    return valueReturn;
  }

  void setInitial(DateTime initial) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(initial);
    valueReturn = formatted;
  }

  void setInitial2(String initial) {
    final parsedDate = DateTime.parse(initial).toLocal();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(parsedDate);
    valueReturn = formatted;
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = (DateTime.now());
  String dateValue = '';
  @override
  void initState() {
    if (widget.valueReturn == '') {
      widget.valueReturn = formatDate(selectedDate);
    } else {
      selectedDate = DateTime.parse(widget.valueReturn);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 16.0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.labelText),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: formatDate(selectedDate),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 10),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateValue = formatDate(selectedDate);
        widget.valueReturn = dateValue;
      });
    }
  }

  String formatDate(DateTime value) {
    final parsedDate = value;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }
}

class CustomTimePicker extends StatefulWidget {
  CustomTimePicker(
      {Key? key, required this.valueReturn, required this.labelText})
      : super(key: key);
  String valueReturn;
  String labelText;

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();

  String getChoosen() {
    return valueReturn;
  }

  void setInitial(DateTime initial) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(initial);
    valueReturn = formatted;
  }

  void setInitial2(String initial) {
    final parsedDate = DateTime.parse(initial).toLocal();
    final now = DateTime.now();
    final parsedDateModif = DateTime(
        now.year, now.month, now.day, parsedDate.hour, parsedDate.minute);
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formatted = formatter.format(parsedDateModif);
    valueReturn = formatted;
    // valueReturn = initial;
  }
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  DateTime selectedDate = (DateTime.now());
  String dateValue = '';
  @override
  void initState() {
    if (widget.valueReturn == '') {
      widget.valueReturn = formatTime2(TimeOfDay.fromDateTime(selectedDate));
    } else {
      selectedDate = DateTime.parse(widget.valueReturn);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 16.0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(widget.labelText),
          Expanded(
            child: GestureDetector(
              onTap: () => _selectTime(context),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  labelText: formatTime(TimeOfDay.fromDateTime(selectedDate)),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (newTime != null) {
      setState(() {
        final now = DateTime.now();
        selectedDate = DateTime(
            now.year, now.month, now.day, newTime.hour, newTime.minute);
        dateValue = formatTime2(newTime);
        widget.valueReturn = dateValue;
      });
    }
  }

  String formatTime(TimeOfDay value) {
    final now = DateTime.now();
    final parsedDate =
        DateTime(now.year, now.month, now.day, value.hour, value.minute);
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }

  String formatTime2(TimeOfDay value) {
    final now = DateTime.now();
    final parsedDate =
        DateTime(now.year, now.month, now.day, value.hour, value.minute);
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }
}
