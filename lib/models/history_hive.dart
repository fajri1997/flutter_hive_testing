import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'history_hive.g.dart';

@HiveType(typeId: 2)
class History extends HiveObject with EquatableMixin {
  @HiveField(0)
  String sender;

  @HiveField(1)
  String receiver;

  @HiveField(2)
  int amount;

  @HiveField(3)
  DateTime dateTime;

  @HiveField(4)
  String currentUser;

  History({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.dateTime,
    required this.currentUser,
  });

  @override
  List<Object?> get props => [sender, receiver, amount, dateTime, currentUser];

  Future<void> saveHistory() async {
    try {
      final box = await Hive.openBox<History>('transaction_history');
      await box.add(this);
    } catch (err) {
      throw err;
    }
  }
}
