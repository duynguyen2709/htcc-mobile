import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/screen/leaving/leaving_store.dart';
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

  @override
  void initState() {
    super.initState();
    _leavingStore = widget.leavingStore;

    dataMap.putIfAbsent("Flutter", () => 1);
    dataMap.putIfAbsent("React", () => 1);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.date_range),
                    ),
                  ),
                  TextSpan(
                    text: 'Ngày nghỉ trong năm',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Container(
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
                        "17",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                        "17",
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
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
                        "17",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(Icons.date_range),
                    ),
                  ),
                  TextSpan(
                    text: 'Chi tiết',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: 6,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("cả ngày"),
                    subtitle: Text("cả ngày"),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refresh() async {}
}
