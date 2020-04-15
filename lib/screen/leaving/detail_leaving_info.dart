import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/calendar_cell.dart';
import 'package:hethongchamcong_mobile/screen/widget/round_text.dart';
import 'package:hethongchamcong_mobile/utils/convert.dart';
import 'package:intl/intl.dart';

class DetailLeavingInfo extends StatefulWidget {
  final LeavingStore leavingStore;

  const DetailLeavingInfo({Key key, this.leavingStore}) : super(key: key);
  @override
  _DetailLeavingInfoState createState() => _DetailLeavingInfoState(leavingStore);
}

class _DetailLeavingInfoState extends State<DetailLeavingInfo> {
  final LeavingStore _leavingStore;
  Map<int,Widget> mapStatusWidget = {
    0 : RoundText(title: "Bị từ chối/ Hủy", colorText: Colors.white, colorBackground: Colors.red,),
    1 : RoundText(title: "Đã được chấp nhận", colorText: Colors.white, colorBackground: Colors.green,),
    2 : RoundText(title: "Đang xử lý", colorText: Colors.white, colorBackground: Colors.grey,),
  };
  _DetailLeavingInfoState(this._leavingStore);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử đơn xin nghỉ"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _leavingStore.listRequest.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    key:
                    PageStorageKey<ListRequest>(_leavingStore.listRequest[index]),
                    elevation: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ExpansionTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    _leavingStore.listRequest[index].category
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Tình trạng : ",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        maxLines: 100,
                                      ),
                                      mapStatusWidget[
                                      _leavingStore.listRequest[index].status]
                                    ],
                                  ),
                                  Text(
                                    '${Convert.convertDateToString(_leavingStore.listRequest[index].dateFrom)} - ${Convert.convertDateToString(_leavingStore.listRequest[index].dateTo)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: Colors.black),
                                  )
                                ],
                              ),
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Lý do :",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                                maxLines: 100,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                _leavingStore
                                                    .listRequest[index].reason,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ) ,
    );

  }
}
