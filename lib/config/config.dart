import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(createToJson: false)
class Config {
  final String env;
  final bool production;
  final String baseURL;

  Config({this.env, this.production, this.baseURL});

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}