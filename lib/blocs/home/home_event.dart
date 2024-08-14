import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadUserData extends HomeEvent {
  final String userId;

  const LoadUserData({required this.userId});

  @override
  List<Object> get props => [userId];
}

class LogoutUser extends HomeEvent {}
