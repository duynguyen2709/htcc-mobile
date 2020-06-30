import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class StatisticResponse extends BaseModel {
  double onTimePercentage;
  double totalDays;
  double workingDays;
  double validOffDays;
  double nonPermissionOffDays;
  double overtimeHours;
  List<DetailStatisticByDate> detailList;


  StatisticResponse({this.onTimePercentage, this.totalDays, this.workingDays,
      this.validOffDays, this.nonPermissionOffDays, this.overtimeHours,
      this.detailList});

  StatisticResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    onTimePercentage = json['onTimePercentage'];
    totalDays = json['totalDays'];
    workingDays = json['workingDays'];
    validOffDays = json['validOffDays'];
    nonPermissionOffDays = json['nonPermissionOffDays'];
    overtimeHours = json['overtimeHours'];
    detailList = List<DetailStatisticByDate>.from(
        json['detailList'].map((child) => DetailStatisticByDate.fromJson(child)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onTimePercentage'] = this.onTimePercentage;
    data['totalDays'] = this.totalDays;
    data['workingDays'] = this.workingDays;
    data['validOffDays'] = this.validOffDays;
    data['nonPermissionOffDays'] = this.nonPermissionOffDays;
    data['overtimeHours'] = this.overtimeHours;
    data['detailList'] =
        List<String>.from(detailList.map((child) => child.toJson()).toList())
            .toString();
  }
}

class DetailStatisticByDate {
  String date;

  List<DetailCheckInTime> listCheckInTime;

  List<DetailDayOff> listDayOff;

  DetailStatisticByDate({this.date, this.listCheckInTime, this.listDayOff});

  DetailStatisticByDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    listCheckInTime = List<DetailCheckInTime>.from(
        json['listCheckInTime'].map((child) => DetailCheckInTime.fromJson(child)));
    listDayOff = List<DetailDayOff>.from(
        json['listDayOff'].map((child) => DetailDayOff.fromJson(child)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['listCheckInTime'] =  List<String>.from(listCheckInTime.map((child) => child.toJson()).toList())
        .toString();
    data['listDayOff'] =  List<String>.from(listDayOff.map((child) => child.toJson()).toList())
        .toString();
    return data;
  }
}

class DetailDayOff {
  String date;
  int session;

  DetailDayOff({
    this.date,
    this.session,
  });

  factory DetailDayOff.fromJson(Map<String, dynamic> json) =>
      DetailDayOff(
        date: json["date"],
        session: json["session"],
      );

  Map<String, dynamic> toJson() =>
      {
        "date": date,
        "session": session,
      };
}


class DetailCheckInTime {
  String officeId;
  String shiftName;
  String shiftTime;
  double shiftStartTime;
  double shiftEndTime;
  int type;
  int subType;
  int clientTime;
  bool isOnTime;
  int status;
  String approver;
  String image;
  String reason;

  DetailCheckInTime(
      {this.officeId, this.shiftName, this.shiftTime, this.type, this.subType,
        this.clientTime, this.isOnTime, this.status, this.approver, this.image,
        this.reason, this.shiftStartTime,this.shiftEndTime});


  DetailCheckInTime.fromJson(Map<String, dynamic> json) {
    isOnTime = json['isOnTime'];
    officeId = json['officeId'];
    shiftName = json['shiftName'];
    shiftTime = json['shiftTime'];
    shiftStartTime = json['shiftStartTime'];
    shiftEndTime = json['shiftEndTime'];
    type = json['type'];
    subType = json['subType'];
    clientTime = json['clientTime'];
    isOnTime = json['isOnTime'];
    status = json['status'];
    approver = json['approver'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnTime'] = this.isOnTime;
    data['officeId'] = this.officeId;
    data['shiftName'] = this.shiftName;
    data['shiftTime'] = this.shiftTime;
    data['shiftStartTime'] = this.shiftStartTime;
    data['shiftEndTime'] = this.shiftEndTime;
    data['type'] = this.type;
    data['subType'] = this.subType;
    data['clientTime'] = this.clientTime;
    data['isOnTime'] = this.isOnTime;
    data['status'] = this.status;
    data['approver'] = this.approver;
    data['reason'] = this.reason;
    return data;
  }
}

class GetStatisticParam{
  String companyId;
  String dateFrom;
  String dateTo;
  String username;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['username'] =this.username;
    return data;
  }

  GetStatisticParam(this.companyId, this.dateFrom, this.dateTo, this.username);
}
