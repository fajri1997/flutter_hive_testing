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

  void generateRandomHistory(String currentUser) {
    final random = Random();
    final List<String> merchantTexts = [
      'Online Shopping',
      'Food Delivery',
      'Grocery Store',
      'Restaurant',
      'Subscription Service',
      'Utility Bill',
      'Gym Membership',
      'Clothing Store',
      'Bookstore',
      'Electronics Store'
    ];

    for (int i = 0; i < 4; i++) {
      final historyOut = History(
        sender: 'User${random.nextInt(1000)}',
        receiver: merchantTexts[random.nextInt(merchantTexts.length)],
        amount: random.nextInt(101),
        dateTime: DateTime.now().subtract(Duration(days: random.nextInt(10))),
        currentUser: currentUser,
        isIn: false,
      );
      add(AddHistory(historyOut));
    }

    final historyIn = History(
      sender: 'Employer${random.nextInt(100)}',
      receiver: currentUser,
      amount: random.nextInt(501) + 500,
      dateTime: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      currentUser: currentUser,
      isIn: true,
    );
    add(AddHistory(historyIn));
  }
}
