import 'package:dio/dio.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_model.dart';
import 'package:hethongchamcong_mobile/data/remote/base/base_repository.dart';

class LoginRepository extends BaseRepository {
  LoginRepository() : super();

  Future<BaseModel> login() async {
    try {
      await Future.delayed(Duration(seconds: 5), () {});
      return SuccessModel("asdas", "dasdas");
    } on DioError catch (error) {
      return ErrorModel("das", "dasd");
    }
  }
}
