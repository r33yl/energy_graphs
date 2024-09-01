import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings.g.dart';

String settingsKey = 'settings';

@HiveType(typeId: 1)
class Settings extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int queueCount;

  @HiveField(3)
  double textSize;
  @HiveField(4)
  double textWeight;
  @HiveField(5)
  double verticalPadding;
  @HiveField(6)
  double horizontalPadding;
  @HiveField(7)
  double timeColumnHorizontalPadding;
  @HiveField(8)
  double borderWidth;
  @HiveField(9)
  double evenColumnOpacity;

  @HiveField(12)
  String backgroundColor;
  @HiveField(13)
  String enableColor;
  @HiveField(14)
  String disableColor;
  @HiveField(15)
  String unknownColor;
  @HiveField(16)
  String borderColor;
  @HiveField(17)
  String textColor;

  @HiveField(20)
  bool includeHeadersRow;
  @HiveField(21)
  bool includeTotalRow;

  @HiveField(24)
  bool showDate;
  @HiveField(25)
  int dateDaysOffset;
  @HiveField(26)
  double dateTextSize;
  @HiveField(27)
  double dateTextWeight;
  @HiveField(28)
  String dateTextColor;

  Settings({
    required this.id,
    required this.queueCount,
    required this.textSize,
    required this.textWeight,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.timeColumnHorizontalPadding,
    required this.borderWidth,
    required this.evenColumnOpacity,
    required this.backgroundColor,
    required this.enableColor,
    required this.disableColor,
    required this.unknownColor,
    required this.borderColor,
    required this.textColor,
    required this.includeHeadersRow,
    required this.includeTotalRow,
    required this.showDate,
    required this.dateDaysOffset,
    required this.dateTextSize,
    required this.dateTextWeight,
    required this.dateTextColor,
  }) : super();

  factory Settings.create({
    required String id,
  }) {
    return Settings(
      id: id,
      queueCount: 6,
      textSize: 12.0,
      textWeight: 6.0,
      verticalPadding: 3.0,
      horizontalPadding: 18.0,
      timeColumnHorizontalPadding: 10.0,
      borderWidth: 0.8,
      evenColumnOpacity: 0.85,
      backgroundColor: const Color.fromARGB(255, 46, 46, 46).hex,
      enableColor: const Color.fromARGB(255, 50, 170, 90).hex,
      disableColor: const Color.fromARGB(255, 163, 40, 31).hex,
      unknownColor: Colors.white.hex,
      borderColor: const Color.fromARGB(255, 90, 90, 90).hex,
      textColor: Colors.white.hex,
      includeHeadersRow: true,
      includeTotalRow: true,
      showDate: true,
      dateDaysOffset: 0,
      dateTextSize: 14.0,
      dateTextWeight: 6.0,
      dateTextColor: const Color.fromARGB(255, 90, 190, 50).hex,
    );
  }
}
