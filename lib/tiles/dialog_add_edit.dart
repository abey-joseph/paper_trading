import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_trading/data/control_data.dart';

import 'package:paper_trading/data/list_data.dart';

class EditDialog extends StatelessWidget {
  final String stockName;
  final double buyPrice;
  final double sellPrice;
  final int quantity;
  final DateTime date;
  final int index;
  final bool isBuy;
  final ValueNotifier<ControlParentDataClass> tData;
  const EditDialog({
    super.key,
    required this.stockName,
    required this.buyPrice,
    required this.sellPrice,
    required this.quantity,
    required this.date,
    required this.index,
    required this.isBuy,
    required this.tData,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String?> selectedPosition;
    bool isLongPosition; // This will be true for 'Long' and false for 'Short'

    if (isBuy) {
      selectedPosition = ValueNotifier<String?>('Long');
      isLongPosition = true;
    } else {
      selectedPosition = ValueNotifier<String?>('Short');
      isLongPosition = false;
    }

    TextEditingController stockNameController = TextEditingController();
    TextEditingController buyPriceController = TextEditingController();
    TextEditingController sellPriceController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController dateController = TextEditingController();

    bool emptyCheck() {
      bool isEmpty;
      if (stockNameController.text == "" ||
          buyPriceController.text == "" ||
          sellPriceController.text == "" ||
          quantityController.text == "" ||
          dateController.text == "") {
        isEmpty = false;
      } else {
        isEmpty = true;
      }
      return isEmpty;
    }

    stockNameController.text = stockName;
    buyPriceController.text = buyPrice.toString();
    sellPriceController.text = sellPrice.toString();
    quantityController.text = quantity.toString();
    dateController.text = "${date.day}/${date.month}/${date.year}";

    return Dialog(
      backgroundColor: Colors.blueGrey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        //color: Colors.red, // Set the background color of the dialog to red
        padding:
            const EdgeInsets.only(top: 30.0, left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // CupertinoTextField controllers (commented)
            // TextEditingController stockNameController = TextEditingController();
            // TextEditingController buyPriceController = TextEditingController();
            // TextEditingController sellPriceController = TextEditingController();
            // TextEditingController quantityController = TextEditingController();
            // TextEditingController dateController = TextEditingController();

            CupertinoTextField(
              keyboardType: TextInputType.number,
              controller: stockNameController, // Commented for now
              placeholder: 'Stock Name',
              placeholderStyle: const TextStyle(
                  color: Colors.black54), // Placeholder text color
              style: const TextStyle(
                  color: Colors.black), // Input text color to black
              decoration: BoxDecoration(
                color: Colors.grey[300], // TextField background color
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: buyPriceController, // Commented for now
              placeholder: 'Buy Price',
              placeholderStyle: const TextStyle(color: Colors.black54),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: BoxDecoration(
                color: Colors.grey[300], // TextField background color
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: sellPriceController, // Commented for now
              placeholder: 'Sell Price',
              placeholderStyle: const TextStyle(color: Colors.black54),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: BoxDecoration(
                color: Colors.grey[300], // TextField background color
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: quantityController, // Commented for now
              placeholder: 'Quantity',
              placeholderStyle: const TextStyle(color: Colors.black54),
              style: const TextStyle(color: Colors.black),
              keyboardType: TextInputType.number,
              decoration: BoxDecoration(
                color: Colors.grey[300], // TextField background color
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: dateController, // Commented for now
              placeholder: 'Date (DD/MM/YYYY)',
              placeholderStyle: const TextStyle(color: Colors.black54),
              style: const TextStyle(color: Colors.black),
              readOnly: true, // Make it non-editable
              decoration: BoxDecoration(
                color: Colors.grey[300], // TextField background color
                borderRadius: BorderRadius.circular(5),
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  String formattedDate =
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                  // Do something with the selected date, like setting it in the TextField or controller
                  dateController.text =
                      formattedDate; // Assuming you will handle the controller later
                }
              },
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300], // Background color
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: ValueListenableBuilder(
                valueListenable: selectedPosition,
                builder: (context, value, child) {
                  return DropdownButton<String>(
                    dropdownColor: Colors.grey[300],
                    isExpanded: true, // Make sure it expands to the full width
                    value: value,
                    hint: const Text(
                      'Position',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16), // Hint text color
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                    style: const TextStyle(color: Colors.black), // Text color
                    underline:
                        const SizedBox(), // Removes the default underline
                    onChanged: (String? newValue) {
                      selectedPosition.value = newValue;
                      isLongPosition = (newValue ==
                          'Long'); // Set true for 'Long', false for 'Short'
                    },
                    items: <String>['Long', 'Short']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog on Cancel
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.white)), // Button text color to white
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    if (emptyCheck()) {
                      // Handle save action here
                      ListOperation.editData(
                          stockName: stockNameController.text,
                          buyPrice: double.parse(buyPriceController.text),
                          sellPrice: double.parse(sellPriceController.text),
                          quantity: int.parse(quantityController.text),
                          date: dateController.text,
                          index: index,
                          isBuy: isLongPosition,
                          tData: tData);

                      Navigator.of(context).pop(); // Close dialog on Save
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Fill up all the Fields'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'))
                                ],
                              ));
                    }
                  },
                  child: const Text('Save',
                      style: TextStyle(
                          color: Colors.white)), // Button text color to white
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
