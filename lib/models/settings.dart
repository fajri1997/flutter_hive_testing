import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 3)
class SettingsModel extends HiveObject {
  @HiveField(0)
  double fontSize;

  @HiveField(1)
  bool isDarkMode;

  SettingsModel({required this.fontSize, required this.isDarkMode});

  SettingsModel copyWith({
    double? fontSize,
    bool? isDarkMode,
  }) {
    return SettingsModel(
      fontSize: fontSize ?? this.fontSize,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
