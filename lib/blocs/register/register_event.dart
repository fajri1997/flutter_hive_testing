import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUser extends RegisterEvent {
  final String username;
  final String name;
  final int age;
  final String email;
  final String password;
  final String number;
  final String gender;
  final DateTime dateOfBirth;
  final String nationality;

  RegisterUser({
    required this.username,
    required this.name,
    required this.age,
    required this.email,
    required this.password,
    required this.number,
    required this.gender,
    required this.dateOfBirth,
    required this.nationality,
  });

  @override
  List<Object?> get props => [
        username,
        name,
        age,
        email,
        password,
        number,
        gender,
        dateOfBirth,
        nationality,
      ];
}
