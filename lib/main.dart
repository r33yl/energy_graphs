import 'package:energy_graphs/app.dart';
import 'package:energy_graphs/services/database/hive_adapters.dart';
import 'package:energy_graphs/services/database/hive_open_box.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initalize Hive
  await Hive.initFlutter();
  registerAllHiveApadters();
  await openHiveBoxes();

  runApp(const MyApp());
}
