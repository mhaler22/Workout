// return todays date as yyymmdd e.g. 20240706
String todaysDateYYYYMMDD() {
  //today
  var dateTimeObject = DateTime.now();

  //year in the format yyyy
  String year = dateTimeObject.year.toString();

  //month in the format dd
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //day is the format dd
  String day = dateTimeObject.day.toString();
  if(day.length == 2) {
    day = '0$day';
  }
  
  //final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;

}


// cnonvert string yyyymmddd to DateTime object
DateTime createDateTimeObject(String yyymmdd) {
  int yyyy = int.parse(yyymmdd.substring(0,4));
  int mm = int.parse(yyymmdd.substring(4,6));
  int dd = int.parse(yyymmdd.substring(6,8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}


// convert DateTime object is string yyymmddd
String convertDateTimeToYYYYMMDD(DateTime dateTime) {
  // year in the format yyyy
  String year = dateTime.year.toString();

  //month in the format mnm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';

  }

  //day in the format
  String day = dateTime.day.toString();
  if (day.length == 2) {
    day = '0$day';
  }

  //final format
  String yyyymmdd = year + month + day;
  return yyyymmdd;
}
void displayDatesUpToLastDayOfMonth() {
  // Get today's date
  DateTime today = DateTime.now();

  // Get the first day of the next month
  DateTime firstDayOfNextMonth = DateTime(today.year, today.month + 1, 1);

  // Loop through all days up to the last day (excluding)
  for (DateTime date = today; date.isBefore(firstDayOfNextMonth); date = date.add(Duration(days: 1))) {
    String dateString = convertDateTimeToYYYYMMDD(date);
    print(dateString);
  }
}

void main() {
  // Display dates up to the last day of the current month
  displayDatesUpToLastDayOfMonth();
}
List<DateTime> getAllDatesInMonth(String startDateYYYYMMDD) {
  // Get DateTime object from startDateYYYYMMDD
  DateTime startDate = createDateTimeObject(startDateYYYYMMDD);

  // Get year and month from startDate
  int year = startDate.year;
  int month = startDate.month;

  // Create a DateTime object for the first day of the next month
  DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);

  // List to store all dates
  List<DateTime> allDates = [];

  // Loop through all days up to the last day (excluding)
  for (DateTime date = startDate; date.isBefore(firstDayOfNextMonth); date = date.add(Duration(days: 1))) {
    allDates.add(date);
  }

  return allDates;
}