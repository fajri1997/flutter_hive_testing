import 'package:hive/hive.dart';

part 'person.g.dart';

enum Gender { male, female }

@HiveType(typeId: 0)
class Person extends HiveObject {
  Person({
    this.username = "",
    this.name = "",
    this.age = 0,
    this.email = "",
    this.password = "",
    this.number = "",
    this.gender = Gender.male,
    this.dateOfBirth,
    this.nationality = "",
  });

  @HiveField(0)
  late String username;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int age;

  @HiveField(3)
  late String email;

  @HiveField(4)
  late String password;

  @HiveField(5)
  late String number;

  @HiveField(6)
  late Gender gender;

  @HiveField(7)
  DateTime? dateOfBirth;

  @HiveField(8)
  late String nationality;
}

// Remember to generate the adapter with:
// flutter packages pub run build_runner build
