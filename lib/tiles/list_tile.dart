import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:paper_trading/data/control_data.dart';
import 'package:paper_trading/data/list_data.dart';
import 'package:paper_trading/screens/detailed_view.dart';
import 'package:paper_trading/tiles/dialog_add_edit.dart';

class TradesTile extends StatelessWidget {
  final int index;

  final ValueNotifier<ControlParentDataClass> tData;
  const TradesTile({
    super.key,
    required this.index,
    required this.tData,
  });

  @override
  Widget build(BuildContext context) {
    editDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return EditDialog(
              stockName: tradeList.value[index].stockName,
              buyPrice: tradeList.value[index].buyPrice,
              sellPrice: tradeList.value[index].sellPrice,
              quantity: tradeList.value[index].qnty,
              date: tradeList.value[index].date,
              index: index,
              isBuy: tradeList.value[index].isBuy,
              tData: tData,
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 18, right: 16, left: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(2, 3),
              )
            ]),
        child: Slidable(
          endActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                //edit
                editDialog();
              },
              icon: Icons.edit,
              backgroundColor: Colors.blue,
              //borderRadius: BorderRadius.circular(10),
            ),
            SlidableAction(
              onPressed: (context) {
                //delete

                ListOperation.deleteTask(index, tData);
              },
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            )
          ]),
          child: SizedBox(
            child: ListTile(
              onTap: () {
                //dialog edit

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TradeDetailsScreen(trade: tradeList.value[index]);
                }));
              },
              onLongPress: () => editDialog(),
              title: Text(
                tradeList.value[index].stockName,
                style: const TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy').format(tradeList.value[index].date),
                style: TextStyle(color: Colors.grey[700]),
              ),
              trailing: Hero(
                tag: 'hero',
                child: Text(
                    tradeList.value[index].netProfit
                        .toStringAsFixed(1)
                        .toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: tradeList.value[index].netProfit.round() >= 0
                          ? Colors.green
                          : Colors.red,
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
