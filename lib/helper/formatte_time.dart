import 'package:flutter/material.dart';

class Formatte_time {
  static String getformattedtime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  static String getlastmassagetime(
      {required BuildContext context, required String time}) {
    final DateTime senttime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime nowtime = DateTime.now();

    if (nowtime.day == senttime.day &&
        nowtime.month == senttime.month &&
        nowtime.year == senttime.year) {
      return TimeOfDay.fromDateTime(senttime).format(context);
    }
    return '${senttime.day} ${_getmonth(senttime)}';
  }
  static _getmonth(DateTime data) {
    switch (data.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Fab';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Spet';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'Na';
  }
}
