import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/settings/settings_bloc.dart';
import 'package:flutter_hive_testing/blocs/settings/settings_event.dart';
import 'package:flutter_hive_testing/blocs/settings/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Text('Settings',
                style: TextStyle(fontSize: state.settings.fontSize));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Text(
                  'Font Size',
                  style: TextStyle(fontSize: state.settings.fontSize),
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Slider(
                  value: state.settings.fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 6,
                  label: state.settings.fontSize.round().toString(),
                  onChanged: (value) {
                    context
                        .read<SettingsBloc>()
                        .add(ChangeFontSizeEvent(newFontSize: value));
                  },
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Text(
                  'Dark Mode',
                  style: TextStyle(fontSize: state.settings.fontSize),
                );
              },
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Switch(
                  value: state.settings.isDarkMode,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(ToggleDarkModeEvent());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
