import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Box<Person> personBox;

  RegisterBloc({required this.personBox}) : super(RegisterInitial()) {
    on<RegisterUser>(
      (event, emit) async {
        try {
          final person = Person(
            username: event.username,
            name: event.name,
            age: event.age,
            email: event.email,
            password: event.password,
            number: event.number,
            gender: event.gender,
            dateOfBirth: event.dateOfBirth,
            nationality: event.nationality,
          );
          await personBox.put(
              event.username, person); // Save person using username as key
          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterFailure(error: e.toString()));
        }
      },
    );
  }
}
