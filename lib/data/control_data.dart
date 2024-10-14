import 'package:paper_trading/data/list_data.dart';

double tempInitBal = 50000;

class ParentData {
  double initBal = 50000;
  double tNetProfit = 0;
  double tProfit = 0;
  double tCT = 0;
  double currBal = 0;
}

class ControlParentDataClass extends ParentData {
  ControlParentDataClass() {
    initBal = tempInitBal;
    tNetProfit = getNetProfit();
    tProfit = getProfit();
    tCT = getCT();
    currBal = getCurrBal();
  }

  ControlParentDataClass.changeBal(double bal) {
    initBal = bal;

    tNetProfit = getNetProfit();
    tProfit = getProfit();
    tCT = getCT();
    currBal = getCurrBal();
  }

  double getNetProfit() {
    double x = 0;
    for (int i = 0; i < tradeList.value.length; i++) {
      x = x + tradeList.value[i].netProfit;
    }
    return x;
  }

  double getProfit() {
    double x = 0;
    for (int i = 0; i < tradeList.value.length; i++) {
      x = x + tradeList.value[i].profit;
    }
    return x;
  }

  double getCT() {
    double x = 0;
    for (int i = 0; i < tradeList.value.length; i++) {
      x = x + tradeList.value[i].totalCT;
    }
    return x;
  }

  double getCurrBal() {
    return initBal + getNetProfit();
  }
}
