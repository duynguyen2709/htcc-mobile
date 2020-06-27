// To parse this JSON data, do
//
//     final payslip = payslipFromJson(jsonString);

import 'dart:convert';

import 'package:hethongchamcong_mobile/data/base/base_model.dart';

Payslip payslipFromJson(String str) => Payslip.fromJson(json.decode(str));

String payslipToJson(Payslip data) => json.encode(data.toJson());

class Payslip extends BaseModel {
  Payslip({
    this.paySlipId,
    this.paymentType,
    this.payDate,
    this.dateFrom,
    this.dateTo,
    this.totalIncome,
    this.totalDeduction,
    this.totalNetPay,
    this.incomeList,
    this.deductionList,
  });

  String paySlipId;
  String paymentType;
  String payDate;
  String dateFrom;
  String dateTo;
  String totalIncome;
  String totalDeduction;
  String totalNetPay;
  List<DeductionListElement> incomeList;
  List<DeductionListElement> deductionList;

  factory Payslip.fromJson(Map<String, dynamic> json) => Payslip(
        paySlipId: json["paySlipId"],
        paymentType: json["paymentType"],
        payDate: json["payDate"],
        dateFrom: json["dateFrom"],
        dateTo: json["dateTo"],
        totalIncome: json["totalIncome"],
        totalDeduction: json["totalDeduction"],
        totalNetPay: json["totalNetPay"],
        incomeList: List<DeductionListElement>.from(json["incomeList"].map((x) => DeductionListElement.fromJson(x))),
        deductionList:
            List<DeductionListElement>.from(json["deductionList"].map((x) => DeductionListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "paySlipId": paySlipId,
        "paymentType": paymentType,
        "payDate": payDate,
        "dateFrom": dateFrom,
        "dateTo": dateTo,
        "totalIncome": totalIncome,
        "totalDeduction": totalDeduction,
        "totalNetPay": totalNetPay,
        "incomeList": List<dynamic>.from(incomeList.map((x) => x.toJson())),
        "deductionList": List<dynamic>.from(deductionList.map((x) => x.toJson())),
      };
}

class DeductionListElement {
  DeductionListElement({
    this.category,
    this.extraInfo,
    this.amount,
  });

  String category;
  String extraInfo;
  String amount;

  factory DeductionListElement.fromJson(Map<String, dynamic> json) => DeductionListElement(
        category: json["category"],
        extraInfo: json["extraInfo"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "extraInfo": extraInfo,
        "amount": amount,
      };
}
