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

  static String formatDateTimeToDDMMYYYYHHMMSS(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
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
  static String getWeekdayName(int weekday,String langCode) {
    if (weekday < 1 || weekday > 7) {
      return weekdayNames[langCode]![0];
    }

    return weekdayNames[langCode]![weekday];
  }
  static String getLocalizedDate(DateTime date,String locale) {
    if (locale == 'vi') {
      final month = date.month;
      final year = date.year;
      return 'Tháng $month năm $year';
    } else {
      final formatter = DateFormat("MMMM yyyy",locale);
      return formatter.format(date);
    }
  }

  static String formatDate(DateTime date, String locale) {
    if (locale == 'vi') {
      return 'Ngày ${DateFormat('dd/MM/yyyy', 'vi').format(date)}';
    } else if (locale == 'en') {
      return DateFormat('MMMM d, yyyy', 'en').format(date);
    } else {
      return date.toString();
    }
  }
  static Map<String, List<String>> weekdayNames = {
    'vi': [
      'Không hợp lệ', // index 0
      'Thứ 2',        // index 1
      'Thứ 3',        // index 2
      'Thứ 4',        // index 3
      'Thứ 5',        // index 4
      'Thứ 6',        // index 5
      'Thứ 7',        // index 6
      'Chủ Nhật',     // index 7
    ],
    'en': [
      'Invalid',      // index 0
      'Monday',       // index 1
      'Tuesday',      // index 2
      'Wednesday',    // index 3
      'Thursday',     // index 4
      'Friday',       // index 5
      'Saturday',     // index 6
      'Sunday',       // index 7
    ],
  };

}