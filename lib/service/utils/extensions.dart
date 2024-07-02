import 'package:flutter/material.dart';

extension MyTimeOfDay on TimeOfDay {
  DateTime get formatDateTime => _toDateTime(this);

  DateTime _toDateTime(TimeOfDay timeOfDay) {
    DateTime now = DateTime.now();

    return DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  }
}
