import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {}

class AddHistory extends HistoryEvent {
  final History history;

  const AddHistory(this.history);

  @override
  List<Object> get props => [history];
}

class FilterHistoryByUser extends HistoryEvent {
  final String user;

  const FilterHistoryByUser(this.user);

  @override
  List<Object> get props => [user];
}
