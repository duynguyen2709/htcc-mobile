import 'package:intl/intl.dart';

class Convert {
  static int convertDateToInt(DateTime dateTime) {
    return int.parse(DateFormat("yyyyMMdd").format(dateTime));
  }

  static DateTime convertIntToDate(int dateTime) {
    return DateFormat("yyyyMMdd").parse(dateTime.toString());
  }

  static String convertDateToString(DateTime dateTime){
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }
}
