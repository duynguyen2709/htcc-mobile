import 'package:intl/intl.dart';

class DateTimeUtil{
  static String format(DateTime original, String pattern){
    return DateFormat(pattern).format(original);
  }
}