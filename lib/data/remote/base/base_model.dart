abstract class BaseModel {
  dynamic data;
  dynamic message;

  BaseModel(this.data, this.message);
}

class SuccessModel extends BaseModel {
  SuccessModel(data, message) : super(data, message);
}

class ErrorModel extends BaseModel {
  ErrorModel(data, message) : super(data, message);
}

enum Status {
  LOGIN_FAIL,
  ERROR_NETWORK,
}
