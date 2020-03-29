import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/circle_icon_button.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountScreenState();
  }
}

class _AccountScreenState extends State<AccountScreen> {
  AccountScreenStore accountScreenStore;

  TextEditingController _controllerId;

  TextEditingController _controllerFullName;

  TextEditingController _controllerTitle;

  TextEditingController _controllerBirthDay;

  TextEditingController _controllerPhone;

  TextEditingController _controllerCMND;

  TextEditingController _controllerOfficeId;

  TextEditingController _controllerDepartment;

  TextEditingController _controllerEmail;

  TextEditingController _controllerAddress;

  @override
  void initState() {
    super.initState();
    accountScreenStore = AccountScreenStore();

    _controllerId = TextEditingController();

    _controllerFullName = TextEditingController();

    _controllerTitle = TextEditingController();

    _controllerBirthDay = TextEditingController();

    _controllerPhone = TextEditingController();

    _controllerCMND = TextEditingController();

    _controllerOfficeId = TextEditingController();

    _controllerDepartment = TextEditingController();

    _controllerEmail = TextEditingController();

    _controllerAddress = TextEditingController();

    accountScreenStore.getAccount();

    reaction((_) => accountScreenStore.errorUpdate, (bool error) {
      if (error == null) return;
      if (error) {
        _showErrorDialog();
        accountScreenStore.errorUpdate = null;
      } else {
        _showErrorDialog();
        accountScreenStore.errorUpdate = null;
      }
    });

    reaction((_) => accountScreenStore.errorAuthenticate, (bool errorAuthenticate) {
      if (errorAuthenticate) {
        _showErrorDialog();
        Navigator.pushReplacementNamed(context, Constants.login_screen);
      }
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(Constants.titleErrorDialog),
          content: new Text(accountScreenStore.message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(Constants.buttonErrorDialog),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang cá nhân"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            Observer(
              builder: (BuildContext context) {
                if (accountScreenStore.isConfig && accountScreenStore.isLoading == false)
                  return IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      accountScreenStore.updateAccount();
                    },
                  );
                else
                  return Center();
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            Observer(
              builder: (_) {
                if (accountScreenStore.errorNetwork)
                  return RetryScreen(
                    refresh: _refresh,
                  );
                if (accountScreenStore.account == null)
                  return EmptyScreen(
                    refresh: _refresh,
                  );
                else
                  return buildSuccess(accountScreenStore.account);
              },
            ),
            Observer(
              builder: (_) {
                if (accountScreenStore.isLoading)
                  return LoadingScreen();
                else
                  return Center();
              },
            )
          ],
        ));
  }

  Widget buildSuccess(User account) {
    _controllerId.text = account.employeeId;

    _controllerFullName.text = account.fullName;

    _controllerTitle.text = account.title;

    _controllerBirthDay.text = account.birthDate;

    _controllerPhone.text = account.phoneNumber;

    _controllerCMND.text = account.identityCardNo;

    _controllerOfficeId.text = account.officeId;

    _controllerDepartment.text = account.department;

    _controllerEmail.text = account.email;

    _controllerAddress.text = account.address;

    return RefreshIndicator(
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 15, left: 8, right: 8),
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[200],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(52.0),
                        child: accountScreenStore.image == null
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/gif/loading.gif',
                                image: accountScreenStore.account.avatar,
                                fit: BoxFit.cover,
                              )
                            : Image.file(accountScreenStore.image),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleIconButton(
                      iconData: Icons.camera_alt,
                      callBack: choiceAvatar,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              child: Text(
                "Thông tin cá nhân",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              padding: const EdgeInsets.only(top: 8, bottom: 15, left: 8, right: 8),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Colors.white),
                      controller: _controllerId,
                      labelText: "Mã số nhân viên",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      controller: _controllerFullName,
                      labelText: "Họ và tên",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.fullName = text;
                      },
                      validateCallBack: (String text) => text.isNotEmpty,
                      errorText: "Họ và tên không được rỗng",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      validateCallBack: (String text) => true,
                      controller: _controllerBirthDay,
                      labelText: "Ngày sinh",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.birthDate = text;
                      },
                      isDate: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      validateCallBack: (String text) => text.length >= 9,
                      errorText: "Tối thiểu 9 chữ số",
                      textInputType: TextInputType.number,
                      controller: _controllerCMND,
                      labelText: "CMND",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.identityCardNo = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      validateCallBack: (String text) => text.length >= 10,
                      textInputType: TextInputType.number,
                      controller: _controllerPhone,
                      labelText: "Số điện thoại",
                      errorText: "Tối thiểu 9 chữ số",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.phoneNumber = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      errorText: "Email không hợp lệ",
                      textInputType: TextInputType.emailAddress,
                      validateCallBack: (String text) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(text))
                          return false;
                        else
                          return true;
                      },
                      controller: _controllerEmail,
                      labelText: "Email",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.email = text;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      validateCallBack: (String text) => text.isNotEmpty,
                      controller: _controllerAddress,
                      labelText: "Địa chỉ",
                      errorText: "Địa chỉ không được rỗng",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.address = text;
                      },
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      child: Text(
                        "Nơi làm việc",
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.only(top: 8, bottom: 15, left: 8, right: 8),
                    ),
                    CustomTextField(
                      boxDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        border: Border.all(color: Colors.black45),
                      ),
                      controller: _controllerOfficeId,
                      labelText: "Chi nhánh",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      boxDecoration: BoxDecoration(border: Border.all(color: Colors.black45), color: Colors.white),
                      controller: _controllerDepartment,
                      labelText: "Phòng ban",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      boxDecoration: BoxDecoration(
                          border: Border.all(color: Colors.black45),
                          borderRadius:
                              BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: Colors.white),
                      controller: _controllerTitle,
                      labelText: "Chức danh",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onRefresh: _refresh,
    );
  }

  Future<void> _refresh() async {
    accountScreenStore.refresh();
  }

  choiceAvatar() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      accountScreenStore.image = image;
      accountScreenStore.isConfig = true;
    });
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key key,
      @required this.controller,
      @required this.labelText,
      @required this.textStyle,
      @required this.boxDecoration})
      : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextStyle textStyle;
  final BoxDecoration boxDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          enabled: false,
          style: textStyle,
          controller: controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 5),
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black45, fontSize: 16),
              disabledBorder: InputBorder.none),
        ),
      ),
    );
  }
}

class CustomSuffixTextField extends StatefulWidget {
  CustomSuffixTextField(
      {Key key,
      @required this.controller,
      @required this.labelText,
      @required this.textStyle,
      @required this.validateCallBack,
      this.textInputType = TextInputType.text,
      this.isDate = false,
      this.errorText = "",
      this.callbackUpdateStore,
      this.boxDecoration})
      : super(key: key);

  final TextEditingController controller;

  final String labelText;

  final String errorText;

  final TextStyle textStyle;

  final Function validateCallBack;

  final TextInputType textInputType;

  final bool isDate;

  final Function callbackUpdateStore;

  final BoxDecoration boxDecoration;

  @override
  State<StatefulWidget> createState() {
    return _CustomSuffixTextFieldState();
  }
}

class _CustomSuffixTextFieldState extends State<CustomSuffixTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: (widget.boxDecoration != null)
            ? widget.boxDecoration
            : BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black45),
              ),
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    enabled: false,
                    style: widget.textStyle,
                    controller: widget.controller,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5),
                        labelText: widget.labelText,
                        labelStyle: TextStyle(color: Colors.black45, fontSize: 16),
                        disabledBorder: InputBorder.none),
                  ),
                ),
                widget.isDate
                    ? IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.date_range),
                        onPressed: () {
                          DatePicker.showDatePicker(context, showTitleActions: true, onChanged: (date) {},
                              onConfirm: (date) {
                            widget.controller.text = DateFormat('yyyy-MM-dd').format(date);
                            widget.callbackUpdateStore(widget.controller.text);
                          },
                              currentTime: DateFormat('yyyy-MM-dd').parse(widget.controller.text),
                              locale: LocaleType.vi);
                        })
                    : IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              child: Dialog(
                                child: FormOneTextField(
                                  validateCallBack: widget.validateCallBack,
                                  errorText: widget.errorText,
                                  labelText: widget.labelText,
                                  controller: widget.controller,
                                  textInputType: widget.textInputType,
                                  callbackUpdateStore: widget.callbackUpdateStore,
                                ),
                              ));
                        },
                      )
              ],
            ),
          ),
        ));
  }
}

class FormOneTextField extends StatefulWidget {
  FormOneTextField(
      {this.validateCallBack,
      this.errorText,
      this.labelText,
      this.controller,
      this.textStyle,
      this.textInputType,
      this.callbackUpdateStore});

  final TextEditingController controller;

  final String labelText;

  final String errorText;

  final TextStyle textStyle;

  final Function validateCallBack;

  final TextInputType textInputType;

  final Function callbackUpdateStore;

  @override
  _FormOneTextFieldState createState() => _FormOneTextFieldState();
}

class _FormOneTextFieldState extends State<FormOneTextField> {
  bool _validate = true;

  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3 + 20,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Chỉnh sửa"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: widget.textStyle,
                    controller: textController,
                    keyboardType: widget.textInputType,
                    decoration: InputDecoration(
                        errorText: _validate ? null : widget.errorText,
                        contentPadding: EdgeInsets.only(top: 5),
                        labelText: widget.labelText,
                        labelStyle: TextStyle(color: Colors.black45, fontSize: 15),
                        disabledBorder: InputBorder.none),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Hủy bỏ"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          child: Text("Đồng ý"),
                          onPressed: () {
                            if (widget.validateCallBack(textController.text)) {
                              _validate = true;
                              widget.callbackUpdateStore(textController.text);
                              widget.controller.text = textController.text;
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                _validate = false;
                              });
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
