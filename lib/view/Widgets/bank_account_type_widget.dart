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
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12), // Reduced spacing between text and cards
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Evenly space the cards
          children: [
            _buildAccountTypeCard(
              context: context,
              icon: Icons.savings_outlined,
              title: 'Saving',
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
              icon: Icons.account_balance_wallet_outlined,
              title: 'Current',
              accountType: 'Current',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrentPage(
                      username: username,
                      cardNumber: cardNumber,
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
    required IconData icon,
    required String title,
    required String accountType,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160, // Further increased width
        height: 160, // Further increased height
        padding: const EdgeInsets.all(16.0), // Kept padding consistent
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white), // Increased icon size
            const SizedBox(height: 10), // Reduced space between icon and text
            Text(
              title,
              style: const TextStyle(
                fontSize: 18, // Increased font size
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
