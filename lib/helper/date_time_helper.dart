class DateTimeHelper{
  static bool checkIsToday(DateTime? date){
    return date?.day == DateTime.now().day &&
        date?.month == DateTime.now().month &&
        date?.year == DateTime.now().year;
  }
}