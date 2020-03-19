
import 'base_model.dart';

class ApiResponse<T extends BaseModel> {
  int returnCode;
  T data;
  String returnMessage;

  ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) func) {
    returnMessage = json["returnMessage"] ?? "";
    data = func(json["data"]);
    returnCode = json["returnCode"];
  }
}

abstract class BaseResponse<T> {
  int returnCode;
  T data;
  String returnMessage;

  BaseResponse(Map<String, dynamic> json) {
    fromJson(json);
  }

  /// Abstract json to data
  T jsonToData(Map<String, dynamic> fullJson);

  ///Abstract data to json
  dynamic dataToJson(T data);

  ///Parsing data to object
  fromJson(Map<String, dynamic> json) {
    returnMessage = json["returnMessage"] ?? "";
    data = jsonToData(json["data"]);
    returnCode = json["returnCode"];
  }

  ///Data to json
  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "data": dataToJson(data),
        "returnMessage": returnMessage,
      };
}
