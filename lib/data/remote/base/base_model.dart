abstract class BaseModel {
  dynamic data;
  dynamic message;

  BaseModel(this.data, dynamic message);
}

class SuccessModel extends BaseModel {
  SuccessModel(data, message) : super(data, message);
}

class ErrorModel extends BaseModel {
  ErrorModel(data, message) : super(data, message);
}
