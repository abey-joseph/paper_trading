import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paper_trading/data/data.dart';

class TradeDetailsScreen extends StatelessWidget {
  final Trades trade;

  const TradeDetailsScreen({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text(
          'Trade Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Trade Information'),
              _buildDetailRow('Stock Name', trade.stockName),
              _buildDetailRow('Buy Price', trade.buyPrice.toStringAsFixed(2)),
              _buildDetailRow('Sell Price', trade.sellPrice.toStringAsFixed(2)),
              _buildDetailRow('Quantity', trade.qnty.toString()),
              _buildDetailRow(
                  'Date', DateFormat('yyyy-MM-dd').format(trade.date)),
              _buildDetailRow('Position', trade.isBuy ? 'Long' : 'Short'),
              const SizedBox(height: 20),
              _buildSectionHeader('Charges & Taxes'),
              _buildDetailRow(
                  'Charges & Taxes (Buy)', trade.ctBuy.toStringAsFixed(2)),
              _buildDetailRow(
                  'Charges & Taxes (Sell)', trade.ctSell.toStringAsFixed(2)),
              _buildDetailRow(
                  'Total Charges & Taxes', trade.totalCT.toStringAsFixed(2)),
              const SizedBox(height: 20),
              _buildSectionHeader('Profit Analysis'),
              _buildProfitRow('Profit', trade.profit),
              _buildNetProfitRow('Net Profit', trade.netProfit),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a header for sections
  Widget _buildSectionHeader(String header) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        header,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey[100],
        ),
      ),
    );
  }

  // Helper method for profit values
  Widget _buildProfitRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 16.0,
              color:
                  value >= 0 ? Colors.green : Colors.red, // Color-coded profit
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to highlight net profit
  Widget _buildNetProfitRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          // color: value >= 0
          //     ? Colors.green[50]
          //     : Colors.red[50], // Highlighted background
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: value >= 0
                ? Colors.green
                : Colors.red, // Border color based on profit
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:
                    value >= 0 ? Colors.green : Colors.red, // Color-coded label
              ),
            ),
            Hero(
              tag: 'hero',
              child: Text(
                value.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: value >= 0
                      ? Colors.green
                      : Colors.red, // Color-coded value
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
