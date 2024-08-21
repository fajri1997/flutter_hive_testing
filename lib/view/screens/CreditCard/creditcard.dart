import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardEvent.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardState.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/credicardBloc.dart';
import 'package:flutter_hive_testing/main.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/home/home_screen.dart';
import 'package:uuid/uuid.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({super.key});

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  var uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Card '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            BlocBuilder<CreditCardBloc, CreditCardState>(
              builder: (context, state) {
                return CreditCardWidget(
                  cardNumber: state.cardNumber,
                  expiryDate: state.expiryDate,
                  cardHolderName: state.cardHolderName,
                  cvvCode: state.cvvCode,
                  showBackView: false,
                  onCreditCardWidgetChange: (CreditCardBrand brand) {},
                );
              },
            ),
            CreditCardForm(
              formKey: GlobalKey<FormState>(),
              textColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              cardNumber: context.read<CreditCardBloc>().state.cardNumber,
              expiryDate: context.read<CreditCardBloc>().state.expiryDate,
              cardHolderName:
                  context.read<CreditCardBloc>().state.cardHolderName,
              cvvCode: context.read<CreditCardBloc>().state.cvvCode,
              themeColor: Colors.purpleAccent,
              cardNumberDecoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: const InputDecoration(
                labelText: 'Expiry Date',
                hintText: 'MM/YY',
              ),
              cvvCodeDecoration: const InputDecoration(
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: const InputDecoration(
                labelText: 'Card Holder',
              ),
              onCreditCardModelChange: (CreditCardModel data) {
                context.read<CreditCardBloc>().add(
                      UpdateCreditCard(
                        cardNumber: data.cardNumber,
                        expiryDate: data.expiryDate,
                        cardHolderName: data.cardHolderName,
                        cvvCode: data.cvvCode,
                      ),
                    );
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Get the current state of the CreditCardBloc
                final state = context.read<CreditCardBloc>().state;

                // Create a CreditCardInfo object with the current state
                final creditCardInfo = CreditCardInfo(
                  cardNumber: state.cardNumber,
                  expiryDate: state.expiryDate,
                  cardHolderName: state.cardHolderName,
                  cvvCode: state.cvvCode,
                  transactionHistory: [],
                );
                final existingCardInfo = boxCard.get('userCard');

                if (existingCardInfo != null &&
                    existingCardInfo == creditCardInfo) {
                  // Card info already exists, do nothing or show a message
                  return;
                }
                String key = uuid.v4();

                // Save the CreditCardInfo to Hive
                await boxCard.put(key, creditCardInfo);

                // Navigate to HomePage
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePage(user: boxPerson.get('user') ?? Person()),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Save and Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
