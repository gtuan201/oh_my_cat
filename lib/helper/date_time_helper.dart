import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper{
  static bool checkIsToday(DateTime? date){
    return date?.day == DateTime.now().day &&
        date?.month == DateTime.now().month &&
        date?.year == DateTime.now().year;
  }
  static String dateTimeToString(DateTime? date){
    if(date == null){
      return '--/--/----';
    }
    else{
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String dateTimeToStringWithMinute(DateTime? date){
    if(date == null){
      return '--/--/----';
    }
    else{
      return DateFormat('ddMMyyyy_HHmm').format(date);
    }
  }

  static String formatTimeHHMM(DateTime dateTime) {
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }
  static bool areDatesEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
  static String getWeekdayName(int weekday) {
    if (weekday < 1 || weekday > 7) {
      return "Không hợp lệ";
    }

    switch (weekday) {
      case 1:
        return "Thứ 2";
      case 2:
        return "Thứ 3";
      case 3:
        return "Thứ 4";
      case 4:
        return "Thứ 5";
      case 5:
        return "Thứ 6";
      case 6:
        return "Thứ 7";
      case 7:
        return "Chủ Nhật";
      default:
        return "Không hợp lệ";
    }
  }
}