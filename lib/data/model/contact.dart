import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class Contact extends BaseModel {
  String address;
  String avatar;
  String birthDate;
  String companyId;
  String department;
  String email;
  String employeeId;
  String fullName;
  String identityCardNo;
  String officeId;
  String phoneNumber;
  String title;
  String username;

  Contact(
      {this.address,
        this.avatar,
        this.birthDate,
        this.companyId,
        this.department,
        this.email,
        this.employeeId,
        this.fullName,
        this.identityCardNo,
        this.officeId,
        this.phoneNumber,
        this.title,
        this.username});

  Contact.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    avatar = json['avatar'];
    birthDate = json['birthDate'];
    companyId = json['companyId'];
    department = json['department'];
    email = json['email'];
    employeeId = json['employeeId'];
    fullName = json['fullName'];
    identityCardNo = json['identityCardNo'];
    officeId = json['officeId'];
    phoneNumber = json['phoneNumber'];
    title = json['title'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    data['birthDate'] = this.birthDate;
    data['companyId'] = this.companyId;
    data['department'] = this.department;
    data['email'] = this.email;
    data['employeeId'] = this.employeeId;
    data['fullName'] = this.fullName;
    data['identityCardNo'] = this.identityCardNo;
    data['officeId'] = this.officeId;
    data['phoneNumber'] = this.phoneNumber;
    data['title'] = this.title;
    data['username'] = this.username;
    return data;
  }
}
