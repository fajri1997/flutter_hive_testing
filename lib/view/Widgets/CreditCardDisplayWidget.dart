import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardState.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/credicardBloc.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/card_history_screen.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/creditcard.dart';

class CreditCardDisplayWidget extends StatefulWidget {
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
  State<CreditCardDisplayWidget> createState() =>
      _CreditCardDisplayWidgetState();
}

class _CreditCardDisplayWidgetState extends State<CreditCardDisplayWidget> {
  int balance = 0;

  generateRandomBalance() {
    Random random = Random();

    balance = random.nextInt(10000) * 2;
    setState(() {});
  }

  @override
  void initState() {
    generateRandomBalance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String maskedCardNumber = widget.creditCardInfo.cardNumber.replaceRange(
        6, widget.creditCardInfo.cardNumber.length - 4, 'XXXX XXXX XXXX');

    return SizedBox(
      height: 250, // Square-like appearance
      width: 150, // Set width equal to height for a square shape
      child: Visibility(
        visible: widget.visible,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardHistoryAndDetailsScreen(
                  cardIndex: widget.cardIndex!,
                  balance: balance,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple[200]!, Colors.purple[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.purple[100]!,
              //     blurRadius: 15.0,
              //     offset: const Offset(0, 8),
              //   ),
              // ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Account Holder:  ',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            widget.creditCardInfo.cardHolderName.isEmpty
                                ? widget.user.name
                                : widget.creditCardInfo.cardHolderName,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Reduced spacing
                      Text(
                        'Card Number: ${maskedCardNumber.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ")}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13, // Smaller font size
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10), // Reduced spacing
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     const Text(
                      //       'Expiry Date: ',
                      //       style: TextStyle(
                      //         color: Colors.white70,
                      //         fontSize: 12, // Smaller font size
                      //       ),
                      //     ),
                      //     Text(
                      //       widget.creditCardInfo.expiryDate,
                      //       style: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 14, // Smaller font size
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 8), // Added spacing for balance
                      Row(
                        children: [
                          const Text(
                            'Balance: ',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12, // Smaller font size
                            ),
                          ),
                          Text(
                            '$balance KWD',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16, // Slightly larger for emphasis
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Visibility(
                    visible: widget.dotsButtonVisible,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: PopupMenuButton(
                        icon: const Icon(Icons.more_vert,
                            color: Colors.white, size: 20), // Smaller icon size
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
    );
  }
}
