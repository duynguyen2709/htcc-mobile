import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_request_list.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/number_statistics_cell.dart';
import 'package:mobx/mobx.dart';

class LeavingRequestScreen extends StatefulWidget {
  final LeavingStore store;

  const LeavingRequestScreen({Key key, this.store}) : super(key: key);

  @override
  _LeavingRequestScreenState createState() => _LeavingRequestScreenState(store);
}

class _LeavingRequestScreenState extends State<LeavingRequestScreen> {
  final LeavingStore store;
  int curValue = -1;
  GlobalKey<LeavingRequestListState> _key = GlobalKey();

  _LeavingRequestScreenState(this.store);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    reaction((_) => store.status, (status) {
      if (status != null)
        setState(() {
          curValue = status.key;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thông tin nghỉ phép'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                  Colors.lightBlueAccent,
                  Colors.blue,
                ]),
          ),
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverGrid.count(
                  crossAxisCount: 3,
                  children: <Widget>[
                    NumberStatisticCell(
                      number: store.leavingData.totalDays,
                      content: "TỔNG PHÉP NĂM",
                      colorContent: Colors.blue,
                    ),
                    NumberStatisticCell(
                      number: store.leavingData.usedDays,
                      content: "NGHỈ PHÉP",
                      colorContent: Colors.green,
                    ),
                    NumberStatisticCell(
                      number: store.leavingData.leftDays,
                      content: "CÒN LẠI",
                      colorContent: Color(0xEEFF9A00),
                    ),
                    NumberStatisticCell(
                      number: store.leavingData.externalDaysOff,
                      content: "NGHỈ KHÔNG PHÉP",
                      colorContent: Colors.red,
                    )
                  ],
                ),
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: TitleDetail(
                      leavingStore: store,
                      changeVal: (val) {
                        _key.currentState.filter(val);
                        setState(() {
                          this.curValue = val;
                        });
                      }),
                ),
              ];
            },
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: LeavingRequestList(
                      key: _key,
                      store: store,
                      code: curValue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class TitleDetail extends SliverPersistentHeaderDelegate {
  final LeavingStore leavingStore;
  final void Function(int curVal) changeVal;

  TitleDetail({this.leavingStore, this.changeVal});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlueAccent,
              Colors.lightBlueAccent,
            ]),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.body1,
                  children: [
                    TextSpan(
                      text: 'Chi tiết',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  underline: null,
                  iconEnabledColor: Colors.white,
                  hint: Text(
                    leavingStore.status.value,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  onChanged: (value) {
                    leavingStore.status = value;
                    changeVal(value.key);
                  },
                  items: <DropdownMenuItem>[
                    DropdownMenuItem(
                      child: Text(
                        "Tất cả",
                        style: TextStyle(fontSize: 15),
                      ),
                      value: Pair(key: -1, value: "Tất cả"),
                    ),
                    DropdownMenuItem(
                      child: Text("Đang chờ phê duyệt",
                          style: TextStyle(fontSize: 15)),
                      value: Pair(key: 2, value: "Đang chờ phê duyệt"),
                    ),
                    DropdownMenuItem(
                      child: Text("Đã duyệt", style: TextStyle(fontSize: 15)),
                      value: Pair(key: 1, value: "Đã duyệt"),
                    ),
                    DropdownMenuItem(
                      child: Text("Từ chối", style: TextStyle(fontSize: 15)),
                      value: Pair(key: 0, value: "Từ chối"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
