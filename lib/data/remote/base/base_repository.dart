import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';

abstract class BaseRepository {
  Dio dio;

  BaseRepository() {
    dio = DioManager().dio;
  }
}
