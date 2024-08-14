import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/person.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Person user;

  const HomeLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
