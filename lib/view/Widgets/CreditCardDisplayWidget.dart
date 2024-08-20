import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardState.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/credicardBloc.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/card_history_screen.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/creditcard.dart';

class CreditCardDisplayWidget extends StatelessWidget {
  final Person user;
  final CreditCardInfo creditCardInfo;
  final int? cardIndex;
  final bool visible; // Control visibility
  final bool dotsButtonVisible;

  const CreditCardDisplayWidget({
    super.key,
    required this.user,
    required this.creditCardInfo,
    this.visible = true,
    required this.dotsButtonVisible,
    this.cardIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    String maskedCardNumber = creditCardInfo.cardNumber.replaceRange(
        6, creditCardInfo.cardNumber.length - 4, 'XXXX XXXX XXXX');

    return SizedBox(
      height: 150, // Square-like appearance
      width: 150, // Set width equal to height for a square shape
      child: Visibility(
        visible: visible,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CardHistoryAndDetailsScreen(cardIndex: cardIndex!),
              ),
            );
          },
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  10.0), // Smaller radius for sharper corners
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[100]!, Colors.purple[300]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(
                    10.0), // Smaller radius for sharper corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple[200]!.withOpacity(0.5),
                    blurRadius: 15.0,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          creditCardInfo.cardHolderName.isEmpty
                              ? user.name
                              : creditCardInfo.cardHolderName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Smaller font size
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8), // Reduced spacing
                        Text(
                          maskedCardNumber.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14, // Smaller font size
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10), // Reduced spacing
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Expiry Date: ',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12, // Smaller font size
                              ),
                            ),
                            Text(
                              creditCardInfo.expiryDate,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14, // Smaller font size
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8), // Added spacing for balance
                        const Text(
                          'Balance:',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12, // Smaller font size
                          ),
                        ),
                        const Text(
                          '1200 KWD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16, // Slightly larger for emphasis
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Visibility(
                      visible: dotsButtonVisible,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton(
                          icon: const Icon(Icons.more_vert,
                              color: Colors.white,
                              size: 20), // Smaller icon size
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'card',
                              child: Text('Add another card'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'card') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreditCardPage()),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
