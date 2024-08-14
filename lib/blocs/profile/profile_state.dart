import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/person.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Person person;

  const ProfileLoaded({required this.person});

  @override
  List<Object> get props => [person];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
