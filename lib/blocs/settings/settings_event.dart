import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeFontSizeEvent extends SettingsEvent {
  final double newFontSize;

  ChangeFontSizeEvent({required this.newFontSize});

  @override
  List<Object> get props => [newFontSize];
}

class ToggleDarkModeEvent extends SettingsEvent {}
