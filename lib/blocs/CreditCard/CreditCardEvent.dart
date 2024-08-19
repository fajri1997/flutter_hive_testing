import 'package:equatable/equatable.dart';

abstract class CreditCardEvent extends Equatable {
  const CreditCardEvent();

  @override
  List<Object> get props => [];
}

class UpdateCreditCard extends CreditCardEvent {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  const UpdateCreditCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
  });

  @override
  List<Object> get props => [cardNumber, expiryDate, cardHolderName, cvvCode];
}
