import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final Function refresh;

  EmptyScreen({this.refresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Text("Không có dữ liệu!"),
            ),
          );
        },
      ),
    );
  }
}
