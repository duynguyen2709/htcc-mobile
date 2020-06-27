import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hethongchamcong_mobile/data/model/payslip.dart';
import 'package:hethongchamcong_mobile/screen/payslip/payslip_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/calendar_cell.dart';
import 'package:hethongchamcong_mobile/screen/widget/custom_expansion_tile.dart';
import 'package:hethongchamcong_mobile/screen/widget/loading_screen.dart';
import 'package:hethongchamcong_mobile/screen/widget/marquee_widget.dart';
import 'package:hethongchamcong_mobile/screen/widget/retry_screen.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class PaySlipScreen extends StatefulWidget {
  @override
  _PaySlipScreenState createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {
  PaySlipStore paySlipStore;

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, 1);

  String month = convertIntToDayofWeek(DateTime.now().month) + '/' + DateTime.now().year.toString();

  @override
  void initState() {
    paySlipStore = PaySlipStore();
    paySlipStore.getPayslip(DateFormat('yyyyMM').format(date));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MarqueeWidget(
          child: Text("Quản lý bảng lương"),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  var tmp = date.subtract(Duration(days: 32));
                  date = DateTime(tmp.year, tmp.month, 1);
                  month = convertIntToDayofWeek(date.month) + '/' + date.year.toString();
                  refresh();
                  setState(() {});
                },
              ),
              InkWell(
                onTap: () async {
                  var dateTime = await showMonthPicker(
                    context: context,
                    firstDate: DateTime(DateTime.now().year - 10),
                    lastDate: DateTime.now(),
                    initialDate: date,
                    locale: Locale("vi"),
                  );
                  if (dateTime != null) {
                    month = convertIntToDayofWeek(dateTime.month) + '/' + dateTime.year.toString();
                    date = dateTime;
                    refresh();
                    setState(() {});
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    month,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  var tmp = date.add(Duration(days: 32));
                  date = DateTime(tmp.year, tmp.month, 1);
                  month = convertIntToDayofWeek(date.month) + '/' + date.year.toString();
                  refresh();
                  setState(() {});
                },
              )
            ],
          ),
        ],
      ),
      body: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
//            Colors.blue,
//            Colors.lightBlueAccent,
//            Colors.lightBlueAccent,
//            Colors.blue,
//          ]),
//        ),
        child: Stack(
          children: <Widget>[
            Observer(
              builder: (BuildContext context) {
                if (paySlipStore.msg.isNotEmpty)
                  return RetryScreen(
                    refresh: refresh,
                    msg: paySlipStore.msg,
                  );
                else {
                  if (paySlipStore.listPayslip == null || paySlipStore.listPayslip.isEmpty) {
                    return Center();
                  } else
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: refresh,
                            child: new ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, position) {
                                return buildItemPaySlip(paySlipStore.listPayslip[position]);
                              },
                              itemCount: paySlipStore.listPayslip.length,
                            ),
                          ),
                        ),
                      ],
                    );
                }
              },
            ),
            Observer(
              builder: (BuildContext context) {
                if (paySlipStore.isLoading == true) {
                  return LoadingScreen();
                }
                return SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> refresh() async {
    paySlipStore.getPayslip(DateFormat('yyyyMM').format(date));
  }

  Widget buildItemPaySlip(Payslip paySlip) {
    return ItemPaySplit(paySlip);
  }
}

String convertIntToDayofWeek(int month) {
  switch (month) {
    case DateTime.january:
      {
        return 'Tháng 1';
      }
    case DateTime.february:
      {
        return 'Tháng 2';
      }
    case DateTime.march:
      {
        return 'Tháng 3';
      }
    case DateTime.april:
      {
        return 'Tháng 4';
      }
    case DateTime.may:
      {
        return 'Tháng 5';
      }
    case DateTime.june:
      {
        return 'Tháng 6';
      }
    case DateTime.july:
      {
        return 'Tháng 7';
      }
    case DateTime.august:
      {
        return 'Tháng 8';
      }
    case DateTime.september:
      {
        return 'Tháng 9';
      }
    case DateTime.october:
      {
        return 'Tháng 10';
      }
    case DateTime.november:
      {
        return 'Tháng 11';
      }
    case DateTime.december:
      {
        return 'Tháng 12';
      }
  }
  return 'Tháng 1';
}

class ItemPaySplit extends StatefulWidget {
  final Payslip payslip;

  ItemPaySplit(this.payslip);

  @override
  _ItemPaySplitState createState() => _ItemPaySplitState();
}

class _ItemPaySplitState extends State<ItemPaySplit> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 10,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                color: Colors.greenAccent,
              ),
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Center(
                child: Text(
                  '-- PHIẾU LƯƠNG --',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CustomExpansionTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: CalendarCell(
                                startDate: DateTime.parse(widget.payslip.dateFrom),
                                endDate: DateTime.parse(widget.payslip.dateTo),
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      widget.payslip.paySlipId,
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Tổng cộng: ",
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    Text(
                                      widget.payslip.totalNetPay,
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Ngày tạo phiếu: ",
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.payslip.payDate)),
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.keyboard_arrow_down),
                          )
                        ],
                      ),
                      children: <Widget>[
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              "** CHI TIẾT **",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 220, minHeight: 50),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.payslip.incomeList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return _buildItemInCome(widget.payslip.incomeList[index]);
                                    },
                                  ),
                                ),
                              ),
                              (widget.payslip.deductionList != null && widget.payslip.deductionList.length > 0)
                                  ? Container(
                                      height: 2,
                                      color: Colors.blueAccent,
                                    )
                                  : Center(),
                              (widget.payslip.deductionList != null && widget.payslip.deductionList.length > 0)
                                  ? Center(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(maxHeight: 220, minHeight: 50),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: widget.payslip.deductionList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return _buildItemDeduction(widget.payslip.deductionList[index]);
                                          },
                                        ),
                                      ),
                                    )
                                  : Center(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItemInCome(DeductionListElement item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.category + ': ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              (item.extraInfo != null && item.extraInfo.isNotEmpty)
                  ? Text(
                      '(${item.extraInfo})',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    )
                  : Center(),
            ],
          ),
          Text('+ ' + item.amount, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.green))
        ],
      ),
    );
  }

  Widget _buildItemDeduction(DeductionListElement item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.category + ': ',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              (item.extraInfo != null && item.extraInfo.isNotEmpty)
                  ? Text(
                      '(${item.extraInfo})',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    )
                  : Center(),
            ],
          ),
          Text('- ' + item.amount, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.red))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
