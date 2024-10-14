import 'package:flutter/material.dart';

class AppBarItems extends StatelessWidget {
  final bool isColorSpecic;
  final String title;
  final double money;

  const AppBarItems(
      {super.key,
      required this.title,
      required this.money,
      required this.isColorSpecic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      //color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          )),
          Expanded(
            flex: 1,
            child: Text(
              '  $money',
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isColorSpecic
                      ? (money >= 0 ? Colors.green : Colors.red)
                      : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
