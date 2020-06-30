import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class MiniShiftDetail {
  String officeId;
  String shiftId;
  String shiftTime;

  MiniShiftDetail({this.officeId, this.shiftId, this.shiftTime});

  MiniShiftDetail.fromJson(Map<String, dynamic> json) {
    officeId = json['officeId'];
    shiftId = json['shiftId'];
    shiftTime = json['shiftTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['officeId'] = this.officeId;
    data['shiftId'] = this.shiftId;
    data['shiftTime'] = this.shiftTime;
    return data;
  }
}

class ShiftArrangement extends BaseModel {
  String date;
  List<MiniShiftDetail> shiftList;

  ShiftArrangement(this.date, this.shiftList);

  ShiftArrangement.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    shiftList = List<MiniShiftDetail>.from(
        json['shiftList'].map((child) => MiniShiftDetail.fromJson(child)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['shiftList'] =
        List<String>.from(shiftList.map((child) => child.toJson()).toList())
            .toString();
    return data;
  }
}

class WorkingDayDetail {
  String date;
  int session;
  bool isWorking;
  String extraInfo;

  WorkingDayDetail(this.date, this.session, this.isWorking, this.extraInfo);

  WorkingDayDetail.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    session  = json['session'];
    isWorking = json['isWorking'];
    extraInfo = json['extraInfo'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data= new Map<String,dynamic>();
    data['date']=this.date;
    data['session'] = this.session;
    data['isWorking'] = this.isWorking;
    data['extraInfo'] = this.extraInfo;
  }
}

class WorkingDayResponse extends BaseModel{
  Map<String,List<WorkingDayDetail>> detailMap;

  WorkingDayResponse(this.detailMap);

  WorkingDayResponse.fromJson(Map<String,dynamic> jsonMap){
    var mapTemp = Map<String, dynamic>.from(jsonMap['detailMap']);
    detailMap=Map();
    try{
      for(String office in mapTemp.keys){
        detailMap[office]= List<WorkingDayDetail>();
        for(var item in mapTemp[office]){
          var data = WorkingDayDetail.fromJson(item);
          print(data.date + " " + data.isWorking.toString());
          detailMap[office].add(data);
        }

      }
    }
    catch(e){
      print(e);
    }

//    detailMap = Map<String, List<WorkingDayDetail>>.from(jsonMap['detailMap']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String,dynamic> data= new Map<String,dynamic>();
    data['detailMap'] = json.encode(this.detailMap);
  }

}
