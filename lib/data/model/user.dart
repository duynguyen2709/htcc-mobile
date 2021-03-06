import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class User extends BaseModel {
  String companyId;
  String username;
  String employeeId;
  String officeId;
  int gender;
  String department;
  String title;
  String fullName;
  String birthDate;
  String email;
  String identityCardNo;
  String phoneNumber;
  String address;
  String avatar;

  @override
  User.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    companyId = json['companyId'];
    username = json['username'];
    employeeId = json['employeeId'];
    officeId = json['officeId'];
    gender = json['gender'];
    department = json['department'];
    title = json['title'];
    fullName = json['fullName'];
    birthDate = json['birthDate'];
    email = json['email'];
    identityCardNo = json['identityCardNo'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    avatar = json['avatar'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['username'] = this.username;
    data['employeeId'] = this.employeeId;
    data['officeId'] = this.officeId;
    data['gender'] = this.gender;
    data['department'] = this.department;
    data['title'] = this.title;
    data['fullName'] = this.fullName;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['identityCardNo'] = this.identityCardNo;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    data['avatar'] = this.avatar;
    return data;
  }
}
