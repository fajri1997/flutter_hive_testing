import 'package:flutter_hive_testing/models/history_hive.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'credit_card_info.g.dart';

// Ensure this is present and matches the file name exactly

@HiveType(typeId: 1)
class CreditCardInfo extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String cardNumber;

  @HiveField(1)
  final String expiryDate;

  @HiveField(2)
  final String cardHolderName;

  @HiveField(3)
  final String cvvCode;

  @HiveField(4)
  final List<History> transactionHistory;

  CreditCardInfo({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    required this.transactionHistory,
  });

  @override
  List<Object?> get props =>
      [cardNumber, expiryDate, cardHolderName, cvvCode, transactionHistory];
}
