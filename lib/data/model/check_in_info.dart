import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class CheckInInfo extends BaseModel {
  String date;
  List<DetailCheckInTime> detailCheckIn;
  List<OfficeDetail> officeList;

  CheckInInfo({this.date, this.detailCheckIn, this.officeList});

  CheckInInfo.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    date = json['date'];
    detailCheckIn = List<DetailCheckInTime>.from(json['detailCheckinTimes']
        .map((child) => DetailCheckInTime.fromJson(child)));
    officeList = List<OfficeDetail>.from(
        json['officeList'].map((child) => OfficeDetail.fromJson(child)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['detailCheckinTimes'] =
        List<String>.from(detailCheckIn.map((child) => child.toJson()).toList())
            .toString();
    data['officeList'] =
        List<String>.from(officeList.map((child) => child.toJson()).toList())
            .toString();
  }
}

class OfficeDetail {
  String allowWifiIP;
  bool canCheckIn;
  bool forceUseWifi;
  bool hasCheckedIn;
  bool hasCheckedOut;
  int maxAllowDistance;
  double validLatitude;
  double validLongitude;
  String officeId;

  OfficeDetail(
      {this.allowWifiIP,
      this.canCheckIn,
      this.forceUseWifi,
      this.hasCheckedIn,
      this.hasCheckedOut,
      this.maxAllowDistance,
      this.validLatitude,
      this.validLongitude,
      this.officeId});

  OfficeDetail.fromJson(Map<String, dynamic> json) {
    allowWifiIP = json['allowWifiIP'];
    canCheckIn= json['canCheckin'];
    forceUseWifi = json['forceUseWifi'];
    hasCheckedIn = json['hasCheckedIn'];
    hasCheckedOut = json['hasCheckedOut'];
    maxAllowDistance = json['maxAllowDistance'];
    validLatitude = json['validLatitude'];
    validLongitude = json['validLongitude'];
    officeId = json['officeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowWifiIP'] = this.allowWifiIP;
    data['forceUseWifi'] = this.forceUseWifi;
    data['hasCheckedIn'] = this.hasCheckedIn;
    data['hasCheckedOut'] = this.hasCheckedOut;
    data['maxAllowDistance'] = this.maxAllowDistance;
    data['validLatitude'] = this.validLatitude;
    data['validLongitude'] = this.validLongitude;
    data['canCheckin'] = this.canCheckIn;
    data['officeId']=this.officeId;
    return data;
  }
}

class DetailCheckInTime {
  bool isOnTime;
  String time;
  int type;

  DetailCheckInTime({this.time, this.isOnTime, this.type});

  DetailCheckInTime.fromJson(Map<String, dynamic> json) {
    isOnTime = json['isOnTime'];
    time = json['time'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnTime'] = this.isOnTime;
    data['time'] = this.time;
    data['type'] = this.type;
    return data;
  }
}
