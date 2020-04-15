class EventDetail {
  String createAt;
  int session;
  String belongToRequestID;
  int statusRequest;
  String reason;
  String approver;

  EventDetail(
      {this.createAt,
      this.session,
      this.belongToRequestID,
      this.statusRequest,
      this.reason,
      this.approver});

  String getSession() {
    switch (session) {
      case 0:
        return "Cả ngày";
      case 1:
        return "Buổi sáng";
      case 2:
        return "Buổi chiều";
      default:
        return "Cả ngày";
    }
  }

  String getStatus(){
    switch (statusRequest) {
      case 0:
        return "Bị từ chối/ Hủy";
      case 1:
        return "Đã chấp nhận";
      case 2:
        return "Đang xử lý";
      default:
        return "Đang xử lý";
    }
  }
}
