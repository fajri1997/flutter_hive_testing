import 'package:flutter/material.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/CurrentPage.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/SavingPage.dart';

class BankAccountTypeWidget extends StatelessWidget {
  final String username;
  final String cardNumber;
  final String balance;
  final String expiryDate;

  const BankAccountTypeWidget({
    super.key,
    required this.username,
    required this.cardNumber,
    required this.balance,
    required this.expiryDate,
    required Null Function(dynamic accountType) onAccountTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Account Type',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        const SizedBox(height: 10), // Reduced spacing between text and cards
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Evenly space the cards
          children: [
            _buildAccountTypeCard(
              context: context,
              title: 'Saving',
              subtitle: ' 43491023 \n\nBalance: \n300 KWD',
              accountType: 'Saving',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SavingPage(
                      username: username,
                      cardNumber: cardNumber,
                      balance: balance,
                      expiryDate: expiryDate,
                    ),
                  ),
                );
              },
            ),
            _buildAccountTypeCard(
              context: context,
              title: 'Current',
              subtitle: '43491333 \n\nBalance: \n$balance',
              accountType: 'Current',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrentPage(
                      username: username,
                      cardNumber: cardNumber,
                      balance: balance, // Added balance here
                      expiryDate: expiryDate,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountTypeCard({
    required BuildContext context,
    required String title,
    String? subtitle,
    required String accountType,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFD1C4E9), // Light purple
              Color(0xFF9575CD) // Slightly darker light purple
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.purple[200]!.withOpacity(0.5),
              blurRadius: 8.0,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
            const Spacer(),
            if (subtitle != null)
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.left,
              ),
          ],
        ),
      ),
    );
  }
}
