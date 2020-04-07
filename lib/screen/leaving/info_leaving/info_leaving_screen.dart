import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/data/model/leaving.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/round_text.dart';
import 'package:hethongchamcong_mobile/utils/convert.dart';
import 'package:pie_chart/pie_chart.dart';

class InfoLeavingScreen extends StatefulWidget {
  final LeavingStore leavingStore;

  InfoLeavingScreen({this.leavingStore});

  @override
  _InfoLeavingScreenState createState() => _InfoLeavingScreenState();
}

class _InfoLeavingScreenState extends State<InfoLeavingScreen> {
  LeavingStore _leavingStore;

  List<Color> colorList = [
    Colors.red,
    Colors.blue,
  ];

  Map<String, double> dataMap = new Map();

  Map<int,Widget> mapStatusWidget = {
    0 : RoundText(title: "REJECTED", colorText: Colors.white, colorBackground: Colors.red,),
    1 : RoundText(title: "APPROVED", colorText: Colors.white, colorBackground: Colors.green,),
    2 : RoundText(title: "SPENDING", colorText: Colors.white, colorBackground: Colors.grey,),
  };

  @override
  void initState() {
    super.initState();
    _leavingStore = widget.leavingStore;

    dataMap.putIfAbsent("Đã nghỉ", () => _leavingStore.leavingData.usedDays);
    dataMap.putIfAbsent("Còn lại", () => _leavingStore.leavingData.leftDays);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.white,
                      child: Align(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.body1,
                                  children: [
                                    TextSpan(
                                      text: 'Thống kê',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(5)), border: Border.all()),
                                  child: Row(
                                    children: <Widget>[
                                      Observer(
                                        builder: (BuildContext context) {
                                          return Text(_leavingStore.year.toString());
                                        },
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  selectYear(context, _leavingStore.year);
                                },
                              )
                            ],
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "${_leavingStore.leavingData.totalDays}",
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Text(
                                    "Tổng",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "${_leavingStore.leavingData.usedDays}",
                                    style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Text(
                                    "Đã nghỉ",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "${_leavingStore.leavingData.leftDays}",
                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Text(
                                    "Còn lại",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: Colors.black),
                                  ),
                                ),
                                child: PieChart(
                                  dataMap: dataMap,
                                  animationDuration: Duration(milliseconds: 800),
                                  showChartValuesInPercentage: false,
                                  showChartValues: false,
                                  showChartValuesOutside: false,
                                  showChartValueLabel: false,
                                  chartLegendSpacing: 1,
                                  showLegends: false,
                                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                                  chartValueBackgroundColor: Colors.deepPurple,
                                  colorList: colorList,
                                  legendPosition: LegendPosition.right,
                                  decimalPlaces: 0,
                                  initialAngle: 0,
                                  chartValueStyle: defaultChartValueStyle.copyWith(
                                    color: Colors.blueGrey[900].withOpacity(0.9),
                                  ),
                                  chartType: ChartType.ring,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      elevation: 10,
                    ),
                  ],
                );
              }, childCount: 1),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: TitleDetail(leavingStore: _leavingStore),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              Observer(
                builder: (BuildContext context) {
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _leavingStore.listRequest.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          key: PageStorageKey<ListRequest>(_leavingStore.listRequest[index]),
                          elevation: 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 48,
                                  height: 48,
                                  margin: EdgeInsets.fromLTRB(16, 8, 0, 8),
                                  child: RoundText(
                                    title: "approve",
                                    colorBackground: Colors.red,
                                    colorText: Colors.white,
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ExpansionTile(
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _leavingStore.listRequest[index].category.toString(),
                                          style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "Tình trạng : ",
                                              style: TextStyle(
                                                fontSize: 16, color: Colors.black
                                              ),
                                              maxLines: 100,
                                            ),
                                            mapStatusWidget[_leavingStore.listRequest[index].status]
                                          ],
                                        ),
                                        Text(
                                          '${Convert.convertDateToString(_leavingStore.listRequest[index].dateFrom)} - ${Convert.convertDateToString(_leavingStore.listRequest[index].dateTo)}',
                                          style:
                                              TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
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
                                                      _leavingStore.listRequest[index].reason,
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    _leavingStore.loadData();
  }

  void selectYear(context, int year) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: YearPicker(
            selectedDate: DateTime(year),
            firstDate: DateTime(1990),
            lastDate: DateTime.now(),
            onChanged: (val) {
              _leavingStore.year = val.year;
              _leavingStore.loadData();
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

class TitleDetail extends SliverPersistentHeaderDelegate {
  final LeavingStore leavingStore;

  TitleDetail({this.leavingStore});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(
              builder: (BuildContext context) {
                if (leavingStore.status != null) {
                  return Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(5)),
                    child: DropdownButton(
                      iconEnabledColor: Colors.black,
                      hint: Text(
                        leavingStore.status.value,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      onChanged: (value) {
                        leavingStore.status = value;
                        leavingStore.filter(value);
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
                          child: Text("Đang chờ phê duyệt"),
                          value: Pair(key: 2, value: "Đang chờ phê duyệt"),
                        ),
                        DropdownMenuItem(
                          child: Text("Đã duyệt"),
                          value: Pair(key: 1, value: "Đã duyệt"),
                        ),
                        DropdownMenuItem(
                          child: Text("Từ chối"),
                          value: Pair(key: 0, value: "Từ chối"),
                        ),
                      ],
                    ),
                  );
                } else
                  return Center();
              },
            ),
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
    return false;
  }
}
