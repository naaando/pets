import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final Function(DateTime?) onDateChanged;
  final DateTime firstDate;
  final DateTime lastDate;

  const DateTimeFormField({
    Key? key,
    required this.controller,
    required this.decoration,
    required this.onDateChanged,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = DateTime.tryParse(controller.text)?.toLocal();

    if (dateTime is DateTime) {
      controller.text = DateFormat().format(dateTime);
    }

    return TextFormField(
      controller: controller,
      decoration: decoration,
      readOnly: true,
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: dateTime ?? DateTime.now(),
          firstDate: firstDate,
          lastDate: lastDate,
        ).then((date) {
          if (date == null) {
            return;
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

            controller.text = dateTime.toIso8601String();
            onDateChanged(dateTime.toUtc());
          });
        });
      },
    );
  }
}
