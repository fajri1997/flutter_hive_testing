import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hive_testing/main.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';

class CurrentPage extends StatefulWidget {
  final String username;
  final String cardNumber;

  final String expiryDate;

  const CurrentPage({
    super.key,
    required this.username,
    required this.cardNumber,
    required this.expiryDate,
    required String balance,
  });

  @override
  State<CurrentPage> createState() => _CurrentPageState();
}

class _CurrentPageState extends State<CurrentPage> {
  int balance = 0;

  generateRandomBalance() {
    Random random = Random();

    balance = random.nextInt(1000) * 2;
    setState(() {});
  }

  @override
  void initState() {
    generateRandomBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final CreditCardInfo? card = boxCard.getAt(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Account Details'),
        backgroundColor: Colors.purple[300],
        elevation: 0,
      ),
      body: Container(
        color: isDarkTheme ? Colors.black : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[200]!, Colors.purple[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[100]!,
                    blurRadius: 15.0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Holder: ${card!.cardHolderName}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Card Number: ${card.cardNumber}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Expiry Date: ${card.expiryDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Balance: $balance kwd ',
                    style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem(
                      context, 'Transfer to Saving', '-\$100', Colors.red),
                  _buildTransactionItem(
                      context, 'Interest Credit', '+\$150', Colors.green),
                  _buildTransactionItem(
                      context, 'Deposit', '+\$250', Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, String description,
      String amount, Color amountColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black87
            : Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple[100]!,
            blurRadius: 10.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple[300],
          child: const Icon(Icons.swap_horiz, color: Colors.white),
        ),
        title: Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.purple[400],
          ),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
            color: amountColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
