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

  @HiveField(5)
  bool isIn;

  History({
    required this.sender,
    required this.receiver,
    required this.amount,
    required this.dateTime,
    required this.currentUser,
    required this.isIn,
  });

  @override
  List<Object?> get props => [sender, receiver, amount, dateTime, currentUser];

  Future<void> saveHistory() async {
    try {
      final box = await Hive.openBox<History>('history');
      await box.add(this);
    } catch (err) {
      throw err;
    }
  }
}
