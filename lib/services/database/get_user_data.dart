import 'package:energy_graphs/models/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void initUserData(BuildContext context) {
  //initialize data
  Provider.of<SettingsData>(context, listen: false).initializeSettingsList();
}
