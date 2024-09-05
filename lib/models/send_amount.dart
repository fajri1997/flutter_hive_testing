import 'package:hive/hive.dart';
part 'send_amount.g.dart';

@HiveType(typeId: 4)
class SendAmount extends HiveObject {
  @HiveField(0)
  String amount;

  SendAmount({required this.amount});
  //create a copy of the object
  SendAmount copyWith({
    String? amount,
  }) {
    return SendAmount(
      amount: amount ?? this.amount,
    );
  }
}
