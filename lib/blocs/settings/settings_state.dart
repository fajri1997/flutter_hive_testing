import 'package:equatable/equatable.dart';
import 'package:flutter_hive_testing/models/settings.dart';

class SettingsState extends Equatable {
  final SettingsModel settings;

  SettingsState({required this.settings});

  SettingsState copyWith({SettingsModel? settings}) {
    return SettingsState(
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [settings];
}
