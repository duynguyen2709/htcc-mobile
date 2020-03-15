class FormDate {
  DateTime dateTime;

  int flag;

  bool isCheck;

  FormDate({this.dateTime, this.flag, this.isCheck = true});

  factory FormDate.convert(DateTime time) {
    DateTime dateTime = DateTime(time.year, time.month, time.day);

    FormDate formDate = FormDate(dateTime: dateTime, flag: 0);

    return formDate;
  }
}
