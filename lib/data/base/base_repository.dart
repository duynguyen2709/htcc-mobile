import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/base/exception/custom_exception.dart';
import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/remote/dio.dart';

abstract class BaseRepository {
  Dio dio;

  BaseRepository() {
    dio = DioManager().dio;
  }

  Error handleError(dynamic error) {
    Error errorResult = Error();
    switch (error.runtimeType) {
      case DioError:
        {
          errorResult.status = Status.ERROR_NETWORK;
          errorResult.msg = "Lỗi kết nối";
          break;
        }
      case UnValidResponseException:
        {
          if (error.response.statusCode == 401 || error.response.statusCode == -8) {
            errorResult.status = Status.ERROR_AUTHENTICATE;
          } else {
            errorResult.status = Status.FAIL;
          }
          errorResult.msg = (error as UnValidResponseException).response.returnMessage;
          break;
        }
      default:
        {
          errorResult.status = Status.FAIL;
          errorResult.msg = "Đã có lỗi trong quá trình xử lý";
          break;
        }
    }
    return errorResult;
  }
}
