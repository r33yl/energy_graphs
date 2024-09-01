import 'package:energy_graphs/models/settings_data.dart';
import 'package:energy_graphs/services/themes/theme_provider.dart';
import 'package:energy_graphs/models/table_data.dart';
import 'package:provider/provider.dart';

List<ChangeNotifierProvider> providersList = [
  ChangeNotifierProvider<ThemeProvider>(
    create: (context) => ThemeProvider(),
  ),
  ChangeNotifierProvider<TableData>(
    create: (context) => TableData(),
  ),
  ChangeNotifierProvider<SettingsData>(
    create: (context) => SettingsData(),
  ),
];
