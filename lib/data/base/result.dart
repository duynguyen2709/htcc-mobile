import 'package:hethongchamcong_mobile/data/base/base_model.dart';

abstract class Result {}

class Success extends Result {
  BaseModel data;
  String msg;

  Success({this.data, this.msg});
}

class Error extends Result {
  Status status;
  String msg;
  Error({this.status, this.msg});
}
