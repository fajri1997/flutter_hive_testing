import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'package:flutter_hive_testing/models/person.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Box<Person> personBox;

  ProfileBloc({required this.personBox}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final person = personBox.get(event.userId);
        if (person != null) {
          emit(ProfileLoaded(person: person));
        } else {
          emit(ProfileError(message: 'Profile not found'));
        }
      } catch (e) {
        emit(ProfileError(message: e.toString()));
      }
    });

    on<UpdateProfile>((event, emit) async {
      final currentState = state;
      if (currentState is ProfileLoaded) {
        try {
          final person = currentState.person;
          person.email = event.email;
          person.number = event.number;
          await person.save();
          emit(ProfileLoaded(person: person));
        } catch (e) {
          emit(ProfileError(message: 'Failed to update profile'));
        }
      }
    });
  }
}
