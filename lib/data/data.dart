import 'package:hive_flutter/hive_flutter.dart';
part 'data.g.dart';

@HiveType(typeId: 1)
class Trades {
  @HiveField(0)
  String stockName;

  @HiveField(1)
  double buyPrice = 0;

  @HiveField(2)
  double sellPrice = 0;

  @HiveField(3)
  int qnty = 0;

  @HiveField(4)
  DateTime date;

  @HiveField(5)
  bool isBuy;

  @HiveField(6)
  int index = 0;

  late double totalBuy;
  late double totalSell;
  late double profit;
  late double ctBuy;
  late double ctSell;
  late double totalCT;
  late double netProfit;

  Trades(
      {required this.stockName,
      required this.buyPrice,
      required this.sellPrice,
      required this.qnty,
      required this.date,
      required this.isBuy}) {
    totalBuy = buyPrice * qnty;
    totalSell = sellPrice * qnty;
    profit = totalSell - totalBuy;
    ctBuy = ((20 + (totalBuy * 0.0000322)) * 0.18) +
        ((20 + (totalBuy * 0.0000322) + (totalBuy * 0.000001))) +
        (totalBuy * 0.00003) +
        ((totalBuy / 100000) * 0.1);
    ctSell = ((20 + (totalSell * 0.0000322)) * 0.18) +
        ((20 + (totalSell * 0.0000322) + (totalSell * 0.000001))) +
        ((totalSell * 0.00025).round()) +
        ((totalSell / 100000) * 0.1);
    totalCT = ctBuy + ctSell;
    netProfit = profit - totalCT;
  }
}
