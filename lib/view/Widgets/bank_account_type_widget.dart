import 'package:flutter/material.dart';

class BankAccountTypeWidget extends StatelessWidget {
  final void Function(String accountType) onAccountTypeSelected;

  const BankAccountTypeWidget({super.key, required this.onAccountTypeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Your Account Type',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAccountTypeCard(
              context: context,
              icon: Icons.savings_outlined,
              title: 'Saving',
              accountType: 'Saving',
            ),
            _buildAccountTypeCard(
              context: context,
              icon: Icons.account_balance_wallet_outlined,
              title: 'Current',
              accountType: 'Current',
            ),
            _buildAccountTypeCard(
              context: context,
              icon: Icons.credit_card_outlined,
              title: 'Credit Card',
              accountType: 'Credit Card',
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
  }) {
    return GestureDetector(
      onTap: () => onAccountTypeSelected(accountType),
      child: Container(
        width: 120,
        height: 140,
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
              blurRadius: 10.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
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
