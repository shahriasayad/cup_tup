import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class SalesHistory extends StatelessWidget {
  const SalesHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales History'),
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('transactionsBox').listenable(),
        builder: (context, Box transactionsBox, _) {
          final transactionCount = transactionsBox.length;
          if (transactionCount == 0) {
            return const Center(child: Text('No sales history available.'));
          }
          final transactions = List.generate(transactionCount,
              (index) => transactionsBox.get(transactionCount - 1 - index));
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: const Color(0xFFE6FFE6),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    transaction['customerNumber'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      DateFormat('h:mm a').format(transaction['saleTime'])),
                  trailing: Text('${transaction['totalAmount']} TK'),
                  onTap: () {
                    Get.toNamed('/transactionDetails', arguments: transaction);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Hive.box('transactionsBox').clear();
          Get.snackbar('Sales History', 'Sales history refreshed!',
              snackPosition: SnackPosition.BOTTOM);
        },
        child: const Icon(Icons.refresh),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }
}
