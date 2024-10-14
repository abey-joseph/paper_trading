import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paper_trading/data/control_data.dart';
import 'package:paper_trading/data/data.dart';

import 'package:paper_trading/data/list_data.dart';
import 'package:paper_trading/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(TradesAdapter().typeId)) {
    Hive.registerAdapter(TradesAdapter());
  }
  await downloadForMain();

  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('initBal')) {
    tempInitBal = prefs.getDouble('initBal')!;
  } else {
    tempInitBal = 50000;
  }

  runApp(const PaperTrading());
}

downloadForMain() async {
  List<Trades> tempList = [];
  final mybox = await Hive.openBox<Trades>('mybox');
  tempList.clear();
  tempList.addAll(mybox.values);
  tradeList.value = List.from(tempList);
}

class PaperTrading extends StatelessWidget {
  const PaperTrading({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
