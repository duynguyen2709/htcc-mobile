import 'package:hethongchamcong_mobile/data/base/base_model.dart';

class FilterList extends BaseModel{
  List<String> departmentList;
  List<String> officeIdList;

  FilterList({this.departmentList, this.officeIdList});

  FilterList.fromJson(Map<String, dynamic> json) {
    departmentList = json['departmentList'].cast<String>();
    officeIdList = json['officeIdList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentList'] = this.departmentList;
    data['officeIdList'] = this.officeIdList;
    return data;
  }
}