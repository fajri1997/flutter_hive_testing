import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Box<Person> personBox;

  LoginBloc({required this.personBox}) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      try {
        final person = personBox.get(event.username);
        if (person != null && person.password == event.password) {
          print('Login successful for user: ${event.username}');
          emit(LoginSuccess());
        } else {
          print('Login failed for user: ${event.username}');
          emit(LoginFailure(error: 'Invalid username or password'));
        }
      } catch (e) {
        print('Login error: ${e.toString()}');
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
