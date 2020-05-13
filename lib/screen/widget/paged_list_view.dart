import 'package:flutter/material.dart';

class PagedListView extends StatefulWidget {
  final List<dynamic> list;
  final int page;
  final int perPage;
  final void Function(int perPage, int page) loadMoreDataFunc;
  final Widget Function(dynamic model) buildItemViewFunc;

  const PagedListView({Key key, this.page, this.perPage, this.loadMoreDataFunc, this.buildItemViewFunc, this.list}) : super(key: key);

  @override
  PagedListViewState createState() => PagedListViewState<dynamic>(page ?? 0, perPage ?? 10, loadMoreDataFunc, buildItemViewFunc, list);
}

class PagedListViewState<T> extends State<PagedListView> {
  List<T> list;
  int page = 0;
  int perPage = 10;
  bool isLoading = false;
  int length = 0;
  bool canLoadMore = true;
  void Function(int perPage, int page) loadMoreDataFunc;
  Widget Function(T model) buildItemViewFunc;
  ScrollController _scrollController = ScrollController();

  PagedListViewState(this.page, this.perPage, this.loadMoreDataFunc, this.buildItemViewFunc, this.list) {
    length = list.length ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (canLoadMore) {
          setState(() {
            isLoading = true;
            length += 1;
          });
          loadMoreDataFunc(perPage, ++page);
        }
      }
    });
  }

  resetPage() {
    setState(() {
      page = 0;
    });
  }

  setCanLoadMore(bool _canLoadMore) {
    setState(() {
      length -= 1;
      canLoadMore = _canLoadMore;
      isLoading = false;
    });
  }

  addList(List<T> data) {
    length -= 1;
    list.addAll(data);
    setState(() {
      isLoading = false;
      length = list.length ?? 0;
    });
  }

  setList(List<T> data) {
    length = data.length;
    list = data;
    setState(() {
      isLoading = false;
      length = data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == list.length)
              return Container(height: 100, child: Center(child: CircularProgressIndicator()));
            else if (index < list.length)
              return buildItemViewFunc(list[index]);
            else
              return Container();
          },
          itemCount: length,
        ),
      ),
    ]);
  }
}
