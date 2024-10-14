import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper_trading/data/control_data.dart';

import 'package:paper_trading/data/data.dart';
import 'package:paper_trading/data/list_data.dart';

int? tempID;
bool isUploaded = false;
List<Trades> tempList = [];

upload(Trades trade, ValueNotifier<ControlParentDataClass> tData) async {
  final mybox = await Hive.openBox<Trades>('mybox');

  tempID = await mybox.add(trade);

  if (tempID != null) {
    trade.index = tempID!;
    mybox.put(trade.index, trade);
    isUploaded = true;
    download(tData);
  } else {
    isUploaded = false;
  }
}

download(ValueNotifier<ControlParentDataClass> tData) async {
  final mybox = await Hive.openBox<Trades>('mybox');
  tempList.clear();
  tempList.addAll(mybox.values);
  tradeList.value = List.from(tempList);
  ListOperation.dataUpdate(tData);
}

edit(Trades trade, ValueNotifier<ControlParentDataClass> tData) async {
  final mybox = await Hive.openBox<Trades>('mybox');
  mybox.put(trade.index, trade);
  download(tData);
}

update() async {
  final mybox = await Hive.openBox<Trades>('mybox');
  await mybox.clear();
  await mybox.addAll(tradeList.value);
}
