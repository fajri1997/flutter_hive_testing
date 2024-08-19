import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'history_event.dart';
import 'history_state.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final Box<History> historyBox;

  HistoryBloc({required this.historyBox}) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<AddHistory>(_onAddHistory);
    on<FilterHistoryByUser>(_onFilterHistoryByUser);
  }

  void _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final histories = historyBox.values.toList();
      emit(HistoryLoaded(histories));
    } catch (e) {
      emit(HistoryError('Failed to load history: $e'));
    }
  }

  void _onAddHistory(AddHistory event, Emitter<HistoryState> emit) async {
    try {
      await historyBox.add(event.history);
      add(LoadHistory()); // Reload history after adding a new entry
    } catch (e) {
      emit(HistoryError('Failed to add history: $e'));
    }
  }

  void _onFilterHistoryByUser(
      FilterHistoryByUser event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final filteredHistories = historyBox.values
          .where((history) => history.currentUser == event.user)
          .toList();
      emit(HistoryLoaded(filteredHistories));
    } catch (e) {
      emit(HistoryError('Failed to filter history: $e'));
    }
  }

  // Method to generate and add random history entries
  void generateRandomHistory(String currentUser) {
    final random = Random();
    final history = History(
      sender: 'User${random.nextInt(1000)}',
      receiver: 'User${random.nextInt(1000)}',
      amount: random.nextInt(1000) + 1, // Random amount between 1 and 1000
      dateTime: DateTime.now().subtract(Duration(
          days: random.nextInt(30))), // Random date within the last 30 days
      currentUser: currentUser,
    );
    add(AddHistory(
        history)); // Dispatch AddHistory event with the generated history
  }
}
