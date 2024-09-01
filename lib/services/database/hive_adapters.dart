import 'package:energy_graphs/models/settings.dart';
import 'package:hive_flutter/adapters.dart';

void registerAllHiveApadters() {
  Hive.registerAdapter(SettingsAdapter());
}
