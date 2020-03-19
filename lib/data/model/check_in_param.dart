class CheckInParam {
  int clientTime;
  String companyId;
  String ip;
  double latitude;
  double longitude;
  int type;
  bool usedWifi;
  String username;

  CheckInParam(
      {this.clientTime,
        this.companyId,
        this.ip,
        this.latitude,
        this.longitude,
        this.type,
        this.usedWifi,
        this.username});

  CheckInParam.fromJson(Map<String, dynamic> json) {
    clientTime = json['clientTime'];
    companyId = json['companyId'];
    ip = json['ip'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    usedWifi = json['usedWifi'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clientTime'] = this.clientTime;
    data['companyId'] = this.companyId;
    data['ip'] = this.ip;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['usedWifi'] = this.usedWifi;
    data['username'] = this.username;
    return data;
  }
}