import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardState.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/credicardBloc.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/creditcard.dart';

class CreditCardDisplayWidget extends StatelessWidget {
  final Person user;
  final CreditCardInfo creditCardInfo;
  final bool visible; // Add a visible parameter
  final bool dotsButtonVisible;

  const CreditCardDisplayWidget({
    super.key,
    required this.user,
    required this.creditCardInfo,
    this.visible = true,
    required this.dotsButtonVisible, // Default to visible
  });

  @override
  Widget build(BuildContext context) {
    String maskedCardNumber = creditCardInfo.cardNumber.replaceRange(
        6, creditCardInfo.cardNumber.length - 4, 'XXXX XXXX XXXX');

    return SizedBox(
      height: 50,
      child: Visibility(
        visible: visible, // Control visibility with this parameter
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditCardPage()),
            );
          },
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 188, 221, 221),
                    Color.fromARGB(255, 31, 35, 161),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          maskedCardNumber.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2.0,
                          ),
                          textAlign: TextAlign.center,
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
                          icon:
                              const Icon(Icons.more_vert, color: Colors.black),
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
