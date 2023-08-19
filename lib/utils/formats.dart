import 'package:cloud_firestore/cloud_firestore.dart';

class Formats {
  static String rentTime({
    required bool isRentDuration,
    Timestamp? rentStartDate,
    Timestamp? rentEndDate,
    int? rentDuration,
  }) {
    return isRentDuration
        ? 'for $rentDuration days'
        : formatTimeRange(rentStartDate!, rentEndDate!);
  }

  static String rentTimeShort({
    required bool isRentDuration,
    Timestamp? rentStartDate,
    Timestamp? rentEndDate,
    int? rentDuration,
  }) {
    return rentTime(
      isRentDuration: isRentDuration,
      rentStartDate: rentStartDate,
      rentEndDate: rentEndDate,
      rentDuration: rentDuration,
    ).split(' ').skip(1).join(' ');
  }

  static String formatTimeRange(Timestamp startTime, Timestamp endTime) {
    DateTime start = startTime.toDate();
    DateTime end = endTime.toDate();
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
