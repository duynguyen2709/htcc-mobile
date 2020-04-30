import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hethongchamcong_mobile/config/constant.dart';
import 'package:hethongchamcong_mobile/data/model/contact.dart';
import 'package:hethongchamcong_mobile/data/utils/date_time_utils.dart';
import 'package:hethongchamcong_mobile/screen/contact/contact_store.dart';
import 'package:hethongchamcong_mobile/screen/widget/contact_line.dart';
import 'package:hethongchamcong_mobile/screen/widget/paged_list_view.dart';
import 'package:hethongchamcong_mobile/screen/widget/search_app_bar.dart';
import 'package:hethongchamcong_mobile/utils/MeasureSize.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
class ContactList extends StatefulWidget {

  ContactList({Key key}) : super(key: key);

  @override
  ContactListState createState() => ContactListState();
}

class ContactListState extends State<ContactList> {
  bool isAnonymously = false;
  GlobalKey<PagedListViewState> globalKey = GlobalKey();
  bool isEmpty = true;
  bool isError = false;
  List<Contact> list = List();
  ContactStore store;
  String department;
  String officeId;
  String query ;
  List<String> _optionsDepartment= List();
  List<String> _optionsOfficeId= List();
  bool doneFilter = false;
  var screenSize = Size.zero;

  void getMoreData(int perPage, int page) {
    if(query==null ||query.compareTo("")==0)
      store.getMoreContact(departmentId: (department!=null ) ? department.compareTo("Tất cả")==0 ? null : department : null, officeId: (officeId!=null ) ? officeId.compareTo("Tất cả")==0 ? null : officeId : null,keyword: null, page : page ,perPage: perPage);
    else
      store.getMoreContact(departmentId:null, officeId: null,keyword: query, page : page ,perPage: perPage);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store = ContactStore();
    store.getFilterList();
    store.getContact(departmentId: (department!=null ) ? department.compareTo("Tất cả")==0 ? null : department : null, officeId: (officeId!=null ) ? officeId.compareTo("Tất cả")==0 ? null : officeId : null, page : 0 ,perPage: 20);
    reaction((_) => store.getListContactSuccess, (isSuccess) async {
      if (isSuccess == true) {
        if (store.listContact.length == 0) {
          setState(() {
            list = List();
            isEmpty = true;
            isError = false;
          });
        } else {
//          globalKey.currentState.setList(list);
          setState(() {
            list = store.listContact;
            isEmpty = false;
            isError = false;
          });
        }
        if(globalKey.currentState!=null) globalKey.currentState.setList(list);
      } else if (isSuccess != null) {
        setState(() {
          isError = true;
        });
      }
    });
    reaction((_) => store.getListFilterSuccess, (isSuccess) async {
      if(isSuccess){
        setState(() {
          doneFilter =true;
          _optionsDepartment = store.listFilter.departmentList;
          _optionsOfficeId = store.listFilter.officeIdList;
        });
      }
    });
    reaction((_) => store.canLoadMore, (canLoadMore) async {
      globalKey.currentState.setCanLoadMore(canLoadMore);
    });
  }
  Future<void> _refresh() async {
    store.getContact(departmentId: (department!=null ) ? department.compareTo("Tất cả")==0 ? null : department : null, officeId: (officeId!=null ) ? officeId.compareTo("Tất cả")==0 ? null : officeId : null, page : 0 ,perPage: 20);
  }
  void searchWithQuery(String queryString){
    query =queryString;
    store.searchContact(keyword:  query , page : 0 ,perPage: 20);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(searchQuery: (queryString) => searchWithQuery(queryString),),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child:  MeasureSize(
            onChange: (size){
              screenSize = size;
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    labelText: "Phòng ban",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                isEmpty: department == '' || department == null,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: department == '' || department == null
                                        ? null
                                        : department,
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        department = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _optionsDepartment.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                    labelText: "Mã chi nhánh",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5))),
                                isEmpty: officeId == ''  || officeId == null,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: officeId == '' || officeId==null
                                        ? null
                                        : officeId,
                                    isDense: true,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        officeId = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: _optionsOfficeId.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: (){
                          query="";
                          store.getContact(departmentId: (department!=null ) ? department.compareTo("Tất cả")==0 ? null : department : null, officeId: (officeId!=null ) ? officeId.compareTo("Tất cả")==0 ? null : officeId : null, page: 0);
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      RefreshIndicator(
                        onRefresh: _refresh,
                        child: !isEmpty ?
                        PagedListView(
                          key: globalKey,
                          list: list,
                          loadMoreDataFunc: (perPage, page) =>
                              getMoreData(perPage, page),
                          buildItemViewFunc: (model) =>
                              ContactItem(contact: model, key: Key((model as Contact).employeeId)),
                          page: 0,
                          perPage: 10,
                        ) : emptyPage,

                      ),
                      Observer(builder: (_) {
                        if (store.isLoading == true)
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: screenSize.height,
                            color: Colors.transparent,
                            child: SpinKitCircle(
                              color: Colors.blue,
                              size: 50.0,
                            ),
                          );
                        else
                          return Center();
                      })
                    ],
                  ),
                )
              ],
            ),
          )
      )
      ,
    )
    ;
  }


  Widget get emptyPage {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/empty_icon.PNG"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Hiện chưa có thông tin liên lạc.",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }


}

class ContactItem extends StatefulWidget {
  final Contact contact;

  const ContactItem({Key key, this.contact}) : super(key: key);
  @override
  _ContactItemState createState() => _ContactItemState(contact);
}

class _ContactItemState extends State<ContactItem> with AutomaticKeepAliveClientMixin {
  final Contact contact;

  _ContactItemState(this.contact);
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        elevation: 10,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: Random().nextInt(100).toDouble(),
              right: Random().nextInt(100).toDouble() - 40,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: Random().nextInt(100).toDouble() + 40,
                width: Random().nextInt(100).toDouble() + 40,
                margin: EdgeInsets.fromLTRB(8, 0, 8, 12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.4)),
              ),
            ),
            Positioned(
              top: Random().nextInt(100).toDouble(),
              right: Random().nextInt(100).toDouble() - 40,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: Random().nextInt(100).toDouble() + 40,
                width: Random().nextInt(100).toDouble() + 40,
                margin: EdgeInsets.fromLTRB(8, 0, 8, 12),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withOpacity(0.3)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  margin: EdgeInsets.fromLTRB(16, 8, 0, 8),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/login_header.png',
                        image: contact.avatar,
                        fit: BoxFit.cover,
                      )),
                ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExpansionTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              contact.fullName,
                              style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text('${contact.title} • ${contact.department}')
                          ],
                        ),
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Column(
                                children: <Widget>[
                                  ContactInfoLine(icon: Icon(Icons.cake, size: 18,), title: "Ngày sinh",content: DateTimeUtil.format(DateFormat("yyyy-MM-dd").parse(contact.birthDate), "dd / MM /yyyy")),
                                  ContactInfoLine(icon: Icon(Icons.phone, size: 18,), title: "Điện thoại",content: contact.phoneNumber),
                                  ContactInfoLine(icon: Icon(Icons.mail, size: 18,), title: "Email",content: contact.email)
                                ],
                              ),
                            ),
                          )

                        ],
                      )
                  ),
                )
              ],
            ),

          ],
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Gọi',
          color: Colors.blueAccent,
          icon: Icons.phone_forwarded,
          onTap: () { UrlLauncher.launch("tel:${contact.phoneNumber}");},
        ),
        IconSlideAction(
          caption: 'Nhắn tin',
          color: Color(0xEEFF9A00),
          icon: Icons.message,
          onTap: () {UrlLauncher.launch("sms:${contact.phoneNumber}");},
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



