import 'package:flutter/material.dart';

class SavingPage extends StatelessWidget {
  final String username;

  const SavingPage(
      {super.key,
      required this.username,
      required String cardNumber,
      required String balance,
      required String expiryDate});

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saving Account'),
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
                    'Account Holder: $username',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Account Type: Saving',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Balance: 300 KWD',
                    style: TextStyle(
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
                      context, 'Deposit', '+\$150', Colors.green),
                  _buildTransactionItem(
                      context, 'Deposit', '+\$150', Colors.green),
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
