import 'package:flutter/material.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_form.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_list.dart';
import 'package:hethongchamcong_mobile/screen/complaint/complaint_store.dart';
import 'package:intl/intl.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  String month = "";
  DateTime currentMonth;
  ComplaintStore store;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store = ComplaintStore();
    DateTime now = DateTime.now();
    currentMonth = now;
    setState(() {
      month = DateFormat('TM/yyyy').format(now);
    });
    store.getComplaint(currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xEEEEEEEE),
        appBar: AppBar(
          actions: <Widget>[
            Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        currentMonth =
                            currentMonth.subtract(Duration(days: 30));
                        setState(() {
                          month = DateFormat('TM/yyyy').format(currentMonth);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        month,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        currentMonth = currentMonth.add(Duration(days: 30));
                        setState(() {
                          month = DateFormat('TM/yyyy').format(currentMonth);
                        });
                      },
                    )
                  ],
                )),
            IconButton(
              icon: Icon(
                Icons.note_add,
                color: Colors.white,
              ),
              onPressed: () async  {
                final res= await Navigator.push(context,  MaterialPageRoute(builder: (context) => ComplaintForm(store: store,)),);
                if(res.toString().compareTo('Success')==0){
                  store.getComplaint(currentMonth);
                }
              },
            )
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Của tôi",
              ),
              Tab(
                text: "Đã hoàn thành",
              ),
            ],
          ),
          title: Text('Góp ý - Khiếu nại'),
        ),
        body: TabBarView(
          children: [
            ComplaintList(store: store, isSuccessList: false),
            ComplaintList(store: store, isSuccessList: true),
          ],
        ),
      ),
    );
  }
//  void _showMyBottomSheet(){
//    // the context of the bottomSheet will be this widget
//    //the context here is where you want to showthe bottom sheet
//    showBottomSheet(context: context,
//        builder: (BuildContext context){
//          return MyBottomSheetLayout(); // returns your BottomSheet widget
//        }
//    );
//  }
}
