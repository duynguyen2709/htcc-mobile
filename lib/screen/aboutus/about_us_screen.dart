import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/password/password_screen_store.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

enum PasswordError { EMPTY, SHORT, INVALID, VALID, NOT_EQUAL }

const Map<PasswordError, String> errorMessage = {
  PasswordError.EMPTY: "Vui lòng nhập mật khẩu.",
  PasswordError.SHORT: "Mật khẩu phải có ít nhất 8 kí tự.",
  PasswordError.INVALID:
      "Mật khẩu không hợp lệ. Mật khẩu phải có ít nhất 1 kí tự a-z, A-Z, 0-9.",
  PasswordError.NOT_EQUAL: "Mật khẩu nhập lại không khớp.",
  PasswordError.VALID: "",
};

class _AboutUsState extends State<AboutUs> {
  TextEditingController _oldPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _repeatController;
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _repeatVisible = true;
  PasswordError errorMsgOldPass, errorMsgNewPass, errorMsgRetypePass;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatController = TextEditingController();
    errorMsgNewPass = PasswordError.VALID;
    errorMsgOldPass = PasswordError.VALID;
    errorMsgRetypePass = PasswordError.VALID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Về ứng dụng"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.blueAccent,
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.lightBlueAccent
                        ]),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/about_us.png",
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                          "Phần mềm nhân sự đa nền tảng được phát triển bới team SCTT với các chức năng hỗ trợ quản lý nhân sự:\n",
                          style: TextStyle(
                              height: 2,
                              fontSize: 15,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic)),
                      Text("CHẤM CÔNG TRỰC TUYẾN THÔNG MINH:\n",
                          style: TextStyle(
                              height: 1,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "- Chấm công điện thoại bằng GPS, QR code, Wifi hoặc hình ảnh thực tế.\n" +
                            "- Thay thế Sổ chấm công bằng chấm công hộ.\n",
                        style: TextStyle(height: 2, fontSize: 15),
                      ),
                      Text("QUẢN LÝ CA LÀM VÀ LỊCH CÔNG VIỆC:\n",
                          style: TextStyle(
                              height: 1,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "- Tạo ca làm và lịch công việc.\n" +
                            "- Sắp xếp Lịch công việc cho nhân viên.\n" +
                            "- Nhân viên có thể chọn ca làm để check in hoặc đăng ký ca làm trước 1 tuần.\n",
                        style: TextStyle(height: 2, fontSize: 15),
                      ),
                      Text("TIỀN LƯƠNG CHUYÊN NGHIỆP:\n",
                          style: TextStyle(
                              height: 1,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "- Nhân viên coi phiếu lương trên điện thoại và xác nhận cũng như khiếu nại (nếu cần thiết).\n",
                        style: TextStyle(height: 2, fontSize: 15),
                      ),
                      Text("TRUYỀN THÔNG NỘI BỘ DỄ DÀNG:\n",
                          style: TextStyle(
                              height: 1,
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      Text(
                        "- Gửi thông báo đến nhân viên tức thời, hiệu quả.",
                        style: TextStyle(
                          height: 2,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 24, bottom: 24),
                          child: Image.asset(
                            "assets/web_icon.png",
                            width: 40,
                            height: 40,
                          )),
                      InkWell(
                        child: Text("https://home.1612145.online",
                            style: TextStyle(
                                height: 1,
                                fontSize: 18,
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold)),
                        onTap: () {
                          launch('https://home.1612145.online/');
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 24, bottom: 24),
                          child: Image.asset(
                            "assets/phone_icon.png",
                            width: 40,
                            height: 40,
                          )),
                      Text("+11-225-888-888-66",style: TextStyle(
                          height: 1,
                          fontSize: 18,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validatePasswordStructure(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool _validate() {
    PasswordError err1, err2, err3;
    err1 = PasswordError.VALID;
    err2 = PasswordError.VALID;
    err3 = PasswordError.VALID;
    if (_oldPasswordController.text == "") {
      err1 = PasswordError.EMPTY;
    }
//    } else if (_oldPasswordController.text.length < 8) {
//      err1 = PasswordError.SHORT;
//    } else if (!validatePasswordStructure(_oldPasswordController.text)) {
//      err1 = PasswordError.INVALID;
//    }
    if (_newPasswordController.text == "") {
      err2 = PasswordError.EMPTY;
    }
//    } else if (_newPasswordController.text.length < 8) {
//      err2 = PasswordError.SHORT;
//    } else if (!validatePasswordStructure(_newPasswordController.text)) {
//      err2 = PasswordError.INVALID;
//    }
    if (_repeatController.text == "") {
      err3 = PasswordError.EMPTY;
    }
//    } else if (_repeatController.text.length < 8) {
//      err3 = PasswordError.SHORT;
//    } else if (!validatePasswordStructure(_repeatController.text)) {
//      err3 = PasswordError.INVALID;
//    }
    if (_repeatController.text.compareTo(_newPasswordController.text) != 0) {
      err3 = PasswordError.NOT_EQUAL;
    }
    setState(() {
      errorMsgOldPass = err1;
      errorMsgNewPass = err2;
      errorMsgRetypePass = err3;
    });
    if (err1 != PasswordError.VALID ||
        err2 != PasswordError.VALID ||
        err3 != PasswordError.VALID) {
      return false;
    } else
      return true;
  }
}
