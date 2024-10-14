import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper_trading/data/control_data.dart';
import 'package:paper_trading/data/data.dart';
import 'package:paper_trading/data/hive_operations.dart';

ValueNotifier<List<Trades>> tradeList = ValueNotifier<List<Trades>>([]);

class ListOperation {
  List<Trades> transferList = [];

  ListOperation.dataUpdate(ValueNotifier<ControlParentDataClass> tData) {
    tData.value = ControlParentDataClass.changeBal(tData.value.initBal);
  }
  ListOperation.dataUpdateUsingNewValue(
      double initBal, ValueNotifier<ControlParentDataClass> tData) {
    tData.value = ControlParentDataClass.changeBal(initBal);
  }
  ListOperation.deleteTask(
      int index, ValueNotifier<ControlParentDataClass> tData) {
    tradeList.value = List.from(tradeList.value)..removeAt(index);
    tData.value = ControlParentDataClass.changeBal(tData.value.initBal);
    update();
  }
  ListOperation.editData(
      {required String stockName,
      required double buyPrice,
      required double sellPrice,
      required int quantity,
      required String date,
      required int index,
      required bool isBuy,
      required ValueNotifier<ControlParentDataClass> tData}) {
    edit(
        Trades(
          // Add new Trades object
          stockName: stockName,
          buyPrice: buyPrice,
          sellPrice: sellPrice,
          qnty: quantity,
          date: DateFormat('dd/MM/yyyy').parse(date),
          isBuy: isBuy,
        ),
        tData);

    tData.value = ControlParentDataClass.changeBal(tData.value.initBal);
  }
}
