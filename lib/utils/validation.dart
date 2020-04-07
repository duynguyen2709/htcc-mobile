class Validation{
  static bool validateEmpty(String text) => text.isNotEmpty;

  static bool validateEmail(String text) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(text))
      return false;
    else
      return true;
  }

  static bool validateCMND(String text) => text.length >= 9;

  static bool validatePhone(String text) => text.length >= 10;
}