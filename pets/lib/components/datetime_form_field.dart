import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends HookWidget {
  final InputDecoration decoration;
  final Function(DateTime?) onDateChanged;
  final String? initialValue;
  final DateTime firstDate;
  final DateTime lastDate;

  final String? Function(dynamic value)? validator;

  const DateTimeFormField({
    Key? key,
    required this.initialValue,
    required this.decoration,
    required this.onDateChanged,
    required this.firstDate,
    required this.lastDate,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = initialValue != null
        ? DateTime.tryParse(initialValue!)?.toLocal()
        : null;

    final value = dateTime != null ? DateFormat().format(dateTime) : null;

    return TextFormField(
      controller: TextEditingController(text: value),
      decoration: decoration,
      readOnly: true,
      validator: validator,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        ).then((date) {
          if (date == null) {
            return onDateChanged(null);
          }

          showTimePicker(
            context: context,
            initialTime: dateTime is DateTime
                ? TimeOfDay.fromDateTime(dateTime)
                : TimeOfDay.now(),
          ).then((time) {
            if (time == null) {
              return;
            }

            var dateTime = date.add(Duration(
              hours: time.hour,
              minutes: time.minute,
              seconds: 0,
            ));

            onDateChanged(dateTime.toUtc());
          });
        });
      },
    );
  }
}
