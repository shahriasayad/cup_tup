import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transaction = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer: ${transaction['customerNumber']}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
                'Time: ${DateFormat('h:mm a').format(transaction['saleTime'])}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Items Sold:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...transaction['items'].map<Widget>((item) => ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                  trailing: Text('${item['subtotal']} TK'),
                )),
            const Divider(),
            Text('Total Amount: ${transaction['totalAmount']} TK',
                style: const TextStyle(fontSize: 16)),
            Text('Amount Paid: ${transaction['amountPaid']} TK',
                style: const TextStyle(fontSize: 16)),
            Text('Change Given: ${transaction['changeGiven']} TK',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
