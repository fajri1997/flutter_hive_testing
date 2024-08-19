import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<History> histories;

  const HistoryLoaded(this.histories);

  @override
  List<Object> get props => [histories];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object> get props => [message];
}
