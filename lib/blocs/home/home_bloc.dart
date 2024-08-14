import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_hive_testing/models/person.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Box<Person> personBox;

  HomeBloc({required this.personBox}) : super(HomeInitial()) {
    on<LoadUserData>(_onLoadUserData);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onLoadUserData(
      LoadUserData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final user = personBox.get(event.userId);
      if (user != null) {
        emit(HomeLoaded(user: user));
      } else {
        emit(HomeError(message: 'User not found'));
      }
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onLogoutUser(LogoutUser event, Emitter<HomeState> emit) {
    // Implement your logout logic here.
    // Example: clearing session data, navigating to the login screen, etc.
  }
}
