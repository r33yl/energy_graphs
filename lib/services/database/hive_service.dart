import 'package:energy_graphs/models/settings.dart';
import 'package:energy_graphs/services/database/hive_open_box.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  static Box<Settings> getSettingsBox() {
    return Hive.box<Settings>(settingsBoxName);
  }

  Future<void> addSettings(Settings settings) async {
    final settingsBox = getSettingsBox();
    await settingsBox.put(settings.id, settings);
  }

  Settings? getSettings() {
    final settingsBox = getSettingsBox();
    return settingsBox.get(settingsKey);
  }

  Future<void> updateSetting(Settings settings) async {
    await settings.save();
  }

  Future<void> deleteSetting() async {
    final settingsBox = getSettingsBox();
    await settingsBox.delete(settingsKey);
  }
}
