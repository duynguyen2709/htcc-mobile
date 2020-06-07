import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/user.dart';
import 'package:hethongchamcong_mobile/screen/account/account_screen_store.dart';
import 'package:hethongchamcong_mobile/screen/dialog/app_dialog.dart';
import 'package:hethongchamcong_mobile/screen/widget/circle_icon_button.dart';
import 'package:hethongchamcong_mobile/screen/widget/empty_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:hethongchamcong_mobile/utils/file.dart';
import 'package:hethongchamcong_mobile/utils/validation.dart';
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

  TextEditingController _controllerGender;

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

    _controllerGender = TextEditingController();

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
    AppDialog.showDialogNotify(context, accountScreenStore.message, () {});
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
                  return buildSuccess(accountScreenStore.account, () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (BuildContext context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await getAvatar(ImageSource.camera);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 25),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.camera_enhance,
                                                  size: 40,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Camera",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  color: Colors.grey,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(vertical: 20),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await getAvatar(ImageSource.gallery);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 25),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.photo_album,
                                                  size: 40,
                                                  color: Colors.purple,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Kho ảnh",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  });
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

  Widget buildSuccess(User account, Function showBottomSheet) {
    _controllerId.text = account.employeeId;

    _controllerFullName.text = account.fullName;

    _controllerTitle.text = account.title;

    _controllerBirthDay.text = account.birthDate;

    _controllerPhone.text = account.phoneNumber;

    _controllerCMND.text = account.identityCardNo;

    _controllerOfficeId.text = account.officeId;

    _controllerGender.text = (account.gender == 1) ? 'Nam' : 'Nữ';

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
                            : Image.file(
                                accountScreenStore.image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleIconButton(
                      iconData: Icons.camera_alt,
                      callBack: showBottomSheet,
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
                      validateCallBack: Validation.validateEmpty,
                      controller: _controllerFullName,
                      labelText: "Họ và tên",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.fullName = text;
                      },
                      errorText: "Họ và tên không được rỗng",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomSuffixTextField(
                      validateCallBack: Validation.validateEmpty,
                      controller: _controllerGender,
                      labelText: "Giới tính",
                      textStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
                      callbackUpdateStore: (String text) {
                        accountScreenStore.isConfig = true;
                        accountScreenStore.account.gender = (text == '1') ? 1 : 0;
                      },
                      isGender: true,
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
                      validateCallBack: Validation.validateCMND,
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
                      validateCallBack: Validation.validatePhone,
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
                      validateCallBack: Validation.validateEmail,
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
                      validateCallBack: Validation.validateEmpty,
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

  getAvatar(ImageSource imageSource) async {
    try {
      accountScreenStore.isLoading = true;
      var image = await ImagePicker.pickImage(source: imageSource);

      if (image != null) image = await FileUtil.crop(image);

      if (image != null) image = await FileUtil.compress(image, 80);

      if (image != null)
        setState(() {
          accountScreenStore.image = image;
          accountScreenStore.isConfig = true;
        });
      accountScreenStore.isLoading = false;
    } catch (error) {
      accountScreenStore.isLoading = false;
    }
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
      this.isGender = false,
      this.callbackUpdateStore,
      this.boxDecoration})
      : super(key: key);

  final bool isGender;

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
                    : ((!widget.isGender)
                        ? IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  child: AppDialog(
                                    FormOneTextField(
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
                        : IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  child: AppDialog(
                                    FormRadio(
                                      controller: widget.controller,
                                      textInputType: widget.textInputType,
                                      callbackUpdateStore: widget.callbackUpdateStore,
                                    ),
                                  ));
                            },
                          ))
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.labelText,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            style: widget.textStyle,
            controller: textController,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
                errorText: _validate ? null : widget.errorText,
                contentPadding: EdgeInsets.only(top: 5),
                labelStyle: TextStyle(color: Colors.black45, fontSize: 15),
                disabledBorder: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.black,
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hủy",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            Container(
              color: Colors.grey,
              height: 30,
              width: 0.5,
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Đồng ý",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
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
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class FormRadio extends StatefulWidget {
  FormRadio({this.controller, this.textStyle, this.textInputType, this.callbackUpdateStore});

  final TextEditingController controller;

  final TextStyle textStyle;

  final TextInputType textInputType;

  final Function callbackUpdateStore;

  @override
  _FormRadioState createState() => _FormRadioState();
}

class _FormRadioState extends State<FormRadio> {
  int gender;

  @override
  void initState() {
    super.initState();
    gender = (widget.controller.text == "Nam") ? 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Chỉnh sửa",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  title: Text('Nam'),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  groupValue: gender,
                  value: 1,
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text('Nữ'),
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  },
                  groupValue: gender,
                  value: 0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.black,
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hủy",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ),
            Container(
              color: Colors.grey,
              height: 30,
              width: 0.5,
            ),
            Expanded(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Đồng ý",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: () {
                  widget.callbackUpdateStore(gender.toString());
                  widget.controller.text = (gender == 1) ? 'Nam' : 'Nữ';
                  Navigator.pop(context);
                },
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            )
          ],
        ),
      ],
    );
  }
}
