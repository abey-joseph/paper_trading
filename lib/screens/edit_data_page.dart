import 'package:flutter/material.dart';

class EditDataScreen extends StatelessWidget {
  final double initBal;
  final Function(double) editBal;
  const EditDataScreen(
      {super.key, required this.initBal, required this.editBal});

  @override
  Widget build(BuildContext context) {
    TextEditingController initBalController = TextEditingController();
    initBalController.text = initBal.toString();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                editBal(double.parse(initBalController.text));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save))
        ],
        title: const Text(
          'Edit',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 16, top: 35),
            //color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                const Expanded(
                    child: Text(
                  'Initial Balence',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: initBalController,
                    decoration: const InputDecoration(
                      border: InputBorder.none, // Removes underline
                    ),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
