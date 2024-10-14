// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:paper_trading/data/control_data.dart';

import 'package:paper_trading/data/list_data.dart';
import 'package:paper_trading/screens/edit_data_page.dart';
import 'package:paper_trading/tiles/appBar_items.dart';
import 'package:paper_trading/tiles/dialog_add.dart';
import 'package:paper_trading/tiles/list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<ControlParentDataClass> tData =
        ValueNotifier<ControlParentDataClass>(ControlParentDataClass());

    prefsFunction(double intiBal) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('initBal', intiBal);
    }

    editInitBal(double initBal) {
      prefsFunction(initBal);
      ListOperation.dataUpdateUsingNewValue(initBal, tData);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddDialog(
                  //dataUpdate: ListOperation.dataUpdate(tData),
                  tData: tData,
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: false,
            // leading: IconButton(
            //     onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditDataScreen(
                                initBal: tData.value.initBal,
                                editBal: editInitBal,
                              )),
                    );
                  },
                  icon: Icon(
                    Icons.edit_note,
                    size: 30,
                  ))
            ],
            expandedHeight: 310.0,
            pinned: true,
            stretch: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Paper Trading',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey[600],
                    borderRadius: BorderRadius.circular(10)),
                child: ValueListenableBuilder(
                    valueListenable: tData,
                    builder: (context, value, _) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 130,
                          ),
                          AppBarItems(
                            title: 'Initial Balence',
                            money:
                                double.parse(value.initBal.toStringAsFixed(1)),
                            isColorSpecic: false,
                          ),
                          AppBarItems(
                            title: 'Current Balence',
                            money:
                                double.parse(value.currBal.toStringAsFixed(1)),
                            isColorSpecic: true,
                          ),
                          AppBarItems(
                            title: 'Profit ',
                            money:
                                double.parse(value.tProfit.toStringAsFixed(1)),
                            isColorSpecic: true,
                          ),
                          AppBarItems(
                            title: 'Charges & Tax ',
                            money: double.parse(value.tCT.toStringAsFixed(1)),
                            isColorSpecic: false,
                          ),
                          AppBarItems(
                            title: 'Net Profit',
                            money: double.parse(
                                value.tNetProfit.toStringAsFixed(1)),
                            isColorSpecic: true,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: tradeList,
            builder: (context, value, _) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return TradesTile(
                      index: (value.length - 1) - index,
                      //dataUpdate: ListOperation.dataUpdate(tData),
                      tData: tData,
                    );
                  },
                  childCount: value.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
