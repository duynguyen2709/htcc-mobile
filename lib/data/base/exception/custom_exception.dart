import 'package:hethongchamcong_mobile/data/base/api_response.dart';

class UnValidResponseException implements Exception {
  final ApiResponse response;

  UnValidResponseException({this.response});
}
