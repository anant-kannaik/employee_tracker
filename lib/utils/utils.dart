import 'package:employee_tracker/models/employee.dart';
import 'package:employee_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

String getFormattedDateTime(DateTime dateTime) {
  return DateFormat(dateFormat).format(dateTime);
}

DateTime getDateForSelectedEnum(DateSelection selectedDate) {
  if (selectedDate == DateSelection.nextMonday) {
    return DateTime.now().next(DateTime.monday);
  } else if (selectedDate == DateSelection.nextTuesday) {
    return DateTime.now().next(DateTime.tuesday);
  } else if (selectedDate == DateSelection.after1Week) {
    return DateTime.now().next(DateTime.now().weekday);
  } else {
    return DateTime.now();
  }
}

DateSelection getEnumForSelectedDate(String selectedDate) {
  if (selectedDate == getFormattedDateTime(DateTime.now())) {
    return DateSelection.today;
  } else if (selectedDate ==
      getFormattedDateTime(DateTime.now().next(DateTime.monday))) {
    return DateSelection.nextMonday;
  } else if (selectedDate ==
      getFormattedDateTime(DateTime.now().next(DateTime.tuesday))) {
    return DateSelection.nextTuesday;
  } else if (selectedDate ==
      getFormattedDateTime(DateTime.now().next(DateTime.now().weekday))) {
    return DateSelection.after1Week;
  } else {
    return DateSelection.empty;
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}

String getDateForEmployee(Employee employee) {
  if (employee.toDate == noDateHintText) {
    return 'From ${employee.fromDate}';
  }
  return '${employee.fromDate} - ${employee.toDate}';
}

bool checkIfDatesValid(String fromDate, String toDate) {
  if (getDateFromString(fromDate).isAfter(getDateFromString(toDate))) {
    return false;
  }
  return true;
}

DateTime getDateFromString(String date) {
  return DateFormat(dateFormat).parse(date);
}
