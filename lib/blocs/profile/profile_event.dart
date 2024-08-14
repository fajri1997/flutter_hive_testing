import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String userId;

  const LoadProfile({required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateProfile extends ProfileEvent {
  final String email;
  final String number;

  const UpdateProfile({required this.email, required this.number});

  @override
  List<Object> get props => [email, number];
}
