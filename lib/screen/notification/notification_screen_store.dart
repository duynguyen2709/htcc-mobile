import 'dart:developer';

import 'package:hethongchamcong_mobile/data/base/result.dart';
import 'package:hethongchamcong_mobile/data/model/notification.dart';
import 'package:hethongchamcong_mobile/injector/injector.dart';
import 'package:mobx/mobx.dart';

part 'notification_screen_store.g.dart';

const SIZE = 20;

class NotificationScreenStore = _NotificationScreenStore with _$NotificationScreenStore;

abstract class _NotificationScreenStore with Store {
  int index = 0;

  @observable
  bool isLoading = false;

  @observable
  List<NotificationPush> list = [];

  @observable
  String msg = '';

  @observable
  String msgLoadMore = '';

  @action
  init() async {
    try {
      log("init");

      index = 0;

      isLoading = true;

      msg = '';

      msgLoadMore = '';

      var result = await Injector.notificationRepository.getListNotification(index, SIZE);
      switch (result.runtimeType) {
        case Success:
          {
            list = (result as Success).data;
            if (list.length < SIZE) index = -1;
            break;
          }
        case Error:
          {
            msg = (result as Error).msg;
            break;
          }
        default:
          {}
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }

  @action
  loadNextPage() async {
    try {
      log("load page");

      msgLoadMore = '';

      if (index != -1) {
        index++;

        var result = await Injector.notificationRepository.getListNotification(index, SIZE);
        switch (result.runtimeType) {
          case Success:
            {
              list.addAll((result as Success).data);

              //trigger observer
              list = list;

              if ((result as Success).data.length < SIZE) index = -1;
              break;
            }
          case Error:
            {
              msgLoadMore = (result as Error).msg;
              break;
            }
          default:
            {}
        }
      }
      isLoading = false;
    } catch (error) {
      isLoading = false;
    }
  }

  @action
  updateStatusNotification(String id, int type) {
    Injector.notificationRepository.updateStatusNotification(id, type);
    if (id.isEmpty) {
      for (var item in list) {
        item.hasRead = true;
      }
    } else {
      for (var item in list) {
        if (item.notiId == id) {
          item.hasRead = true;
        }
      }
    }
    list = list;
  }
}
