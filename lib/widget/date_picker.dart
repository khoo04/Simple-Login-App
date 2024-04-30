import 'package:flutter/material.dart';

Future<TimeOfDay> myDatePicker(
    {required BuildContext context,
    required TimeOfDay initialTime,
    required TimePickerEntryMode timePickerEntryMode}) async {
  final TimeOfDay? timeOfDay = await showTimePicker(
    context: context,
    initialTime: initialTime,
    initialEntryMode: timePickerEntryMode,
  );
  if (timeOfDay == null) {
    return TimeOfDay.now();
  } else {
    return timeOfDay;
  }
}
