import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/model/complaint.dart';
import 'package:hethongchamcong_mobile/screen/widget/info_line.dart';
import 'package:hethongchamcong_mobile/screen/widget/photo_viewer.dart';

class ComplaintDetail extends StatelessWidget {
  final Complaint complaint;

  const ComplaintDetail({Key key, this.complaint}) : super(key: key);

  String codeToStatus(int code) {
    switch (code) {
      case 1:
        return 'Đã xử lý';
      case 2:
        return 'Đang xử lý';
      case 3:
        return 'Bị từ chối xử lý';
      default:
        return 'Đang xử lý';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(complaint.complaintId),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Colors.blue,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                    child: Wrap(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                InfoLine(
                                    title: "Id",
                                    content: this.complaint.complaintId),
                                InfoLine(
                                    title: "Chủ đề",
                                    content: this.complaint.category),
                                InfoLine(
                                    title: "Nội dung",
                                    content: this.complaint.content),
                                InfoLine(
                                    title: "Ngày gửi",
                                    content: this.complaint.date +
                                        " " +
                                        this.complaint.time),
                                InfoLine(
                                    title: "Người nhận",
                                    content: this.complaint.receiverType == 1
                                        ? "Hệ thống"
                                        : "Công ty"),
                                InfoLine(
                                    title: "Trạng thái",
                                    content: codeToStatus(this.complaint.status)),
                                InfoLine(title: "Ảnh đính kèm", content: ""),
                                complaint.images.length > 0
                                    ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                      child: Row(
                                          children: complaint.images.map((element) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => PhotoViewer(images: complaint.images, initialIndex:  complaint.images.indexOf(element),)));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                    'assets/human_error.png',
                                                    image: element,
                                                    fit: BoxFit.cover,
                                                    width: MediaQuery.of(context).size.width / 3.5,
                                                    height: MediaQuery.of(context).size.width / 3.5
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                    )
                                    : Container(),
                              ]),
                        ),
                      ],
                    )),
                (complaint.response != null && complaint.response.isNotEmpty)
                    ? Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: InfoLine(
                            title: "Phản hồi",
                            content: complaint.response,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        )));
  }
}
