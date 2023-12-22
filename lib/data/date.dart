//return today date in format yyyyMMdd
String todayDateYMD() {
  var dateTimeObject = DateTime.now();
  String year = dateTimeObject.year.toString();
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String yymmdd = year + month + day;
  return yymmdd;
}

//convert string to date time object
DateTime createDateTimeObject(String yyyyMMdd) {
  int year = int.parse(yyyyMMdd.substring(0, 4));
  int month = int.parse(yyyyMMdd.substring(4, 6));
  int day = int.parse(yyyyMMdd.substring(6, 8));
  DateTime dateTimeObject = DateTime(
    year,
    month,
    day,
  );
  return dateTimeObject;
}

//convert date time object to string yyyyMMdd
String convertDateTimetoYYYYMMDD(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = "0$month";
  }
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = "0$day";
  }
  String yymmdd = year + month + day;
  return yymmdd;
}
