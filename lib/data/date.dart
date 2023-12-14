String todayDate() {
  var dateTime = DateTime.now();
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String dateForamt = "$day/$month/$year";
  return dateForamt;
}

DateTime createDateTime(String dateFormat) {
  int y = int.parse(dateFormat.substring(0, 4));
  int m = int.parse(dateFormat.substring(4, 6));
  int d = int.parse(dateFormat.substring(6, 8));
  DateTime dateTime = DateTime(y, m, d);
  return dateTime;
}

String convertDateTime(DateTime dateTime) {
  String year = dateTime.year.toString();
  String month = dateTime.month.toString();
  String day = dateTime.day.toString();
  String dateForamt = "$day/$month/$year";
  return dateForamt;
}
