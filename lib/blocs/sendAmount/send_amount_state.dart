import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/send_amount.dart';

class SendAmountState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendAmountInitial extends SendAmountState {}

class SendAmountLoaded extends SendAmountState {
  final SendAmount sendAmount;

  SendAmountLoaded({required this.sendAmount});

  @override
  List<Object?> get props => [sendAmount];
}
