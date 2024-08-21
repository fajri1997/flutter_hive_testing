import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/models/settings.dart';
import 'package:hive/hive.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Box<SettingsModel> settingsBox;

  SettingsBloc(this.settingsBox)
      : super(
          SettingsState(
            settings: settingsBox.get('settings') ??
                SettingsModel(fontSize: 16.0, isDarkMode: false),
          ),
        ) {
    on<ChangeFontSizeEvent>((event, emit) {
      final updatedSettings =
          state.settings.copyWith(fontSize: event.newFontSize);
      settingsBox.put('settings', updatedSettings);
      emit(state.copyWith(settings: updatedSettings));
    });

    on<ToggleDarkModeEvent>((event, emit) {
      final updatedSettings =
          state.settings.copyWith(isDarkMode: !state.settings.isDarkMode);
      settingsBox.put('settings', updatedSettings);
      emit(state.copyWith(settings: updatedSettings));
    });
  }
}
