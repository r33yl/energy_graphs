import 'package:energy_graphs/models/settings.dart';
import 'package:energy_graphs/services/database/hive_service.dart';
import 'package:hive_flutter/adapters.dart';

const settingsBoxName = 'settingsBox';

Future<void> openHiveBoxes() async {
  await _initializeSettings();
}

Future<void> _initializeSettings() async {
  final settingsBox = await Hive.openBox<Settings>(settingsBoxName);
  if (settingsBox.isEmpty) {
    HiveDataBase().addSettings(
      Settings.create(id: settingsKey),
    );
  }
}
