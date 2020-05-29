class QRCodeData {
  String companyId;
  int genTime;
  String officeId;
  String qrCodeId;

  QRCodeData({this.companyId, this.genTime, this.officeId, this.qrCodeId});

  factory QRCodeData.fromJson(Map<String, dynamic> json) {
    return QRCodeData(
      companyId: json['companyId'],
      genTime: json['genTime'],
      officeId: json['officeId'],
      qrCodeId: json['qrCodeId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['genTime'] = this.genTime;
    data['officeId'] = this.officeId;
    data['qrCodeId'] = this.qrCodeId;
    return data;
  }
}