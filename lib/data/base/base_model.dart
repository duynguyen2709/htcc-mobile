abstract class BaseModel {
  BaseModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

enum Status {
  COMPLETE,
  LOGIN_FAIL,
  ERROR_NETWORK,
  FAIL,
  ERROR_AUTHENTICATE
}
