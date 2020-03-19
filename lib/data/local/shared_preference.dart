import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static SharedPreferences _instance;

  static Future<SharedPreferences> getInstance() async {
    if (_instance == null) {
      _instance = await SharedPreferences.getInstance();
    }
    return _instance;
  }
}
