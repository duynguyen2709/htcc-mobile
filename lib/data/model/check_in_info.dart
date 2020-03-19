
import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class CheckInInfo  extends BaseModel{
  String allowWifiIP;
  bool canCheckin;
  String checkinTime;
  String checkoutTime;
  bool forceUseWifi;
  bool hasCheckedIn;
  bool hasCheckedOut;
  int maxAllowDistance;
  String validCheckinTime;
  String validCheckoutTime;
  double validLatitude;
  double validLongitude;

  CheckInInfo(
      {this.allowWifiIP,
        this.canCheckin,
        this.checkinTime,
        this.checkoutTime,
        this.forceUseWifi,
        this.hasCheckedIn,
        this.hasCheckedOut,
        this.maxAllowDistance,
        this.validCheckinTime,
        this.validCheckoutTime,
        this.validLatitude,
        this.validLongitude}) : super.fromJson(null) ;

  CheckInInfo.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    allowWifiIP = json['allowWifiIP'];
    canCheckin = json['canCheckin'];
    checkinTime = json['checkinTime'];
    checkoutTime = json['checkoutTime'];
    forceUseWifi = json['forceUseWifi'];
    hasCheckedIn = json['hasCheckedIn'];
    hasCheckedOut = json['hasCheckedOut'];
    maxAllowDistance = json['maxAllowDistance'];
    validCheckinTime = json['validCheckinTime'];
    validCheckoutTime = json['validCheckoutTime'];
    validLatitude = json['validLatitude'];
    validLongitude = json['validLongitude'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowWifiIP'] = this.allowWifiIP;
    data['canCheckin'] = this.canCheckin;
    data['checkinTime'] = this.checkinTime;
    data['checkoutTime'] = this.checkoutTime;
    data['forceUseWifi'] = this.forceUseWifi;
    data['hasCheckedIn'] = this.hasCheckedIn;
    data['hasCheckedOut'] = this.hasCheckedOut;
    data['maxAllowDistance'] = this.maxAllowDistance;
    data['validCheckinTime'] = this.validCheckinTime;
    data['validCheckoutTime'] = this.validCheckoutTime;
    data['validLatitude'] = this.validLatitude;
    data['validLongitude'] = this.validLongitude;
    return data;
  }
}
