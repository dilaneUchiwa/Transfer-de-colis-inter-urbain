import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyConverter {
  static DateTime convertTimestampToDateTime(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(
        timestamp.seconds * 1000 + (timestamp.nanoseconds / 1000000).round());
  }

  static DateTime convertDateTimeToTimestamp(Timestamp timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(
        timestamp.seconds * 1000 + (timestamp.nanoseconds / 1000000).round());
  }

  static DateTime convertStringToDateTime(String dateString) {
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  static String convertDateTimeToString(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day-$month-$year';
  }

  static convertDateTimeToHumanString(DateTime date) {
    DateTime now = DateTime.now();
    int differenceInDays = date.difference(now).inDays;
    DateFormat formatter = DateFormat('dd-MM-yyyy');

    if (differenceInDays == 0) {
      return 'Aujourd\'hui (${formatter.format(date)})';
    } else if (differenceInDays == 1) {
      return 'Demain (${formatter.format(date)})';
    } else if (differenceInDays == 2) {
      return 'Après-demain (${formatter.format(date)})';
    } else {
      return 'le (${formatter.format(date)})';
    }
  }
}
