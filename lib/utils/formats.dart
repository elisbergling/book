import 'package:flutter/material.dart';

class Formats {
  static String leaseTime({
    required bool isLeaseDuration,
    DateTimeRange? leaseTimeRange,
    int? leaseDuration,
  }) {
    return isLeaseDuration
        ? 'for $leaseDuration days'
        : formatTimeRange(leaseTimeRange!);
  }

  static String leaseTimeShort({
    required bool isLeaseDuration,
    DateTimeRange? leaseTimeRange,
    int? leaseDuration,
  }) {
    return leaseTime(
            isLeaseDuration: isLeaseDuration,
            leaseTimeRange: leaseTimeRange,
            leaseDuration: leaseDuration)
        .split(' ')
        .skip(1)
        .join(' ');
  }

  static String formatTimeRange(DateTimeRange leaseTimeRange) {
    DateTime start = leaseTimeRange.start;
    DateTime end = leaseTimeRange.end;
    return 'from ${start.day} ${monthInText(start.month)} to ${end.day} ${monthInText(end.month)}';
  }

  static String monthInText(int month) {
    String text = 'boob';
    switch (month) {
      case 1:
        text = 'Januari';
        break;
      case 2:
        text = 'Februray';
        break;
      case 3:
        text = 'March';
        break;
      case 4:
        text = 'April';
        break;
      case 5:
        text = 'Maj';
        break;
      case 6:
        text = 'Juni';
        break;
      case 7:
        text = 'July';
        break;
      case 8:
        text = 'August';
        break;
      case 9:
        text = 'September';
        break;
      case 10:
        text = 'October';
        break;
      case 11:
        text = 'November';
        break;
      case 12:
        text = 'December';
        break;
    }
    return text;
  }
}
