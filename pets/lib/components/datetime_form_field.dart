import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends StatelessWidget {
  final TextEditingController controller;
  final InputDecoration decoration;
  final Function(DateTime?) onDateChanged;

  const DateTimeFormField({
    Key? key,
    required this.controller,
    required this.decoration,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime = DateTime.tryParse(controller.text);

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
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ).then((date) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((time) {
            var dateTime = date?.add(Duration(
              hours: time!.hour,
              minutes: time.minute,
              seconds: 0,
            ));

            if (dateTime != null) {
              controller.text = DateFormat().format(dateTime);
              onDateChanged(dateTime);
            }
          });
        });
      },
    );
  }
}
