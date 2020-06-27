import 'dart:convert';

ScreenResponse screenResponseFromJson(String str) => ScreenResponse.fromJson(json.decode(str));

String screenResponseToJson(ScreenResponse data) => json.encode(data.toJson());

final ScreenResponse screenResponse = ScreenResponse();

bool checkScreen(int screen) {
  if (screenResponse.data != null && screenResponse.data.displayScreens != null)
    return screenResponse.data.displayScreens.indexWhere((element) => element == screen) != -1;
  else
    return false;
}

class ScreenResponse {
  ScreenResponse({
    this.returnCode,
    this.returnMessage,
    this.data,
  });

  int returnCode;
  String returnMessage;
  ListScreen data;

  factory ScreenResponse.fromJson(Map<String, dynamic> json) => ScreenResponse(
        returnCode: json["returnCode"],
        returnMessage: json["returnMessage"],
        data: ListScreen.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "returnCode": returnCode,
        "returnMessage": returnMessage,
        "data": data.toJson(),
      };
}

class ListScreen {
  ListScreen({
    this.unreadNotifications,
    this.displayScreens,
  });

  int unreadNotifications;
  List<int> displayScreens;

  factory ListScreen.fromJson(Map<String, dynamic> json) => ListScreen(
        unreadNotifications: json["unreadNotifications"],
        displayScreens: List<int>.from(json["displayScreens"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "unreadNotifications": unreadNotifications,
        "displayScreens": List<dynamic>.from(displayScreens.map((x) => x)),
      };
}
