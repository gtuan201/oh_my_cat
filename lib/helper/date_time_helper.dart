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
}