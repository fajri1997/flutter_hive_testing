import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardEvent.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/CreditCardState.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

class CreditCardBloc extends Bloc<CreditCardEvent, CreditCardState> {
  final Box<CreditCardInfo> creditCardBox;

  CreditCardBloc({required this.creditCardBox}) : super(CreditCardState()) {
    on<UpdateCreditCard>((event, emit) {
      final updatedState = state.copyWith(
        cardNumber: event.cardNumber,
        expiryDate: event.expiryDate,
        cardHolderName: event.cardHolderName,
        cvvCode: event.cvvCode,
      );

      // Save to Hive
      final creditCardInfo = CreditCardInfo(
        cardNumber: event.cardNumber,
        expiryDate: event.expiryDate,
        cardHolderName: event.cardHolderName,
        cvvCode: event.cvvCode,
        transactionHistory: [],
      );
      creditCardBox.put('creditCard', creditCardInfo);

      emit(updatedState);
    });
  }
}

class CreditCardDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Card '),
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
              cardNumber: context.read<CreditCardBloc>().state.cardNumber,
              expiryDate: context.read<CreditCardBloc>().state.expiryDate,
              cardHolderName:
                  context.read<CreditCardBloc>().state.cardHolderName,
              cvvCode: context.read<CreditCardBloc>().state.cvvCode,
              themeColor: Colors.blue,
              cardNumberDecoration: InputDecoration(
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
          ],
        ),
      ),
    );
  }
}
