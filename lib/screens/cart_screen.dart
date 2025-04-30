import 'package:cup_tub/utils/custom%20themes/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class CartScreen extends StatelessWidget {
  final List<String> items = [
    'Chips',
    'Cookies',
    'Popcorn',
    'Tea',
    'Coffee',
    'Juice'
  ];
  final List<int> prices = [10, 15, 20, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    final quantities = Get.arguments as List<int>;
    final totalAmount = quantities
        .asMap()
        .entries
        .fold<int>(0, (sum, entry) => sum + (entry.value * prices[entry.key]));

    final TextEditingController collectedController = TextEditingController();
    final salesBox = Hive.box('salesBox');
    final transactionsBox = Hive.box('transactionsBox');

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      if (quantities[index] == 0) return SizedBox.shrink();
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          tileColor: Color(0xFFF0FFF0),
                          title: Text(items[index],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          trailing: Text(
                            '${quantities[index]} x ${prices[index]} = ${quantities[index] * prices[index]} TK',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('VAT: 0 BDT', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    Text('Discount: 0 BDT', style: TextStyle(fontSize: 16)),
                    Divider(height: 20, thickness: 1),
                    Text('Total Amount: $totalAmount BDT',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    TextField(
                      controller: collectedController,
                      decoration: InputDecoration(
                        labelText: 'Collected Amount',
                        labelStyle:
                            TextStyle(fontSize: 16, color: Colors.black87),
                        prefixIcon: Icon(Icons.money),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: collectedController,
                      builder: (context, value, child) {
                        final collected = int.tryParse(value.text) ?? 0;
                        final change = collected - totalAmount;
                        return Text(
                          'Change: ${change > 0 ? change : 0} BDT',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            CustomButton(
              buttonText: "DONE",
              onPressed: () {
                // Save transaction to transactionsBox
                final nextKey = transactionsBox.length;
                final customerNumber = 'Customer ${nextKey + 1}';
                final collected = int.tryParse(collectedController.text) ?? 0;
                final change =
                    collected > totalAmount ? collected - totalAmount : 0;

                final transactionData = {
                  'customerNumber': customerNumber,
                  'saleTime': DateTime.now(),
                  'items': [
                    for (int i = 0; i < items.length; i++)
                      if (quantities[i] > 0)
                        {
                          'name': items[i],
                          'quantity': quantities[i],
                          'price': prices[i],
                          'subtotal': quantities[i] * prices[i],
                        }
                  ],
                  'totalAmount': totalAmount,
                  'amountPaid': collected,
                  'changeGiven': change,
                };
                transactionsBox.put(nextKey, transactionData);

                // Update aggregated data in salesBox
                for (int i = 0; i < items.length; i++) {
                  if (quantities[i] > 0) {
                    final itemName = items[i];
                    salesBox.put(
                        '$itemName-sold',
                        salesBox.get('$itemName-sold', defaultValue: 0) +
                            quantities[i]);
                    salesBox.put(
                        '$itemName-amount',
                        salesBox.get('$itemName-amount', defaultValue: 0) +
                            (quantities[i] * prices[i]));
                  }
                }
                salesBox.put('totalProfit',
                    salesBox.get('totalProfit', defaultValue: 0) + totalAmount);

                Get.offAllNamed('/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
