import 'package:energy_graphs/models/settings.dart';
import 'package:energy_graphs/services/database/hive_service.dart';
import 'package:flutter/material.dart';

class SettingsData extends ChangeNotifier {
  final db = HiveDataBase();
  Settings _settingsList = Settings.create(id: settingsKey);

  void initializeSettingsList() {
    Settings? settings = db.getSettings();
    if (settings != null) {
      _settingsList = settings;
    }
  }

  Settings getSettings() {
    return _settingsList;
  }

  // update wish
  void updateSettings(Settings settings) {
    db.updateSetting(settings);
    notifyListeners();
  }

  //////////// QueueCount
  void setQueueCount(int value, {bool listeners = true}) {
    _settingsList.queueCount = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// TextSize
  void setTextSize(double value, {bool listeners = true}) {
    _settingsList.textSize = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// TextWeight
  void setTextWeight(double value, {bool listeners = true}) {
    _settingsList.textWeight = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// VerticalPadding
  void setVerticalPadding(double value, {bool listeners = true}) {
    _settingsList.verticalPadding = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// HorizontalPadding
  void setHorizontalPadding(double value, {bool listeners = true}) {
    _settingsList.horizontalPadding = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// TimeColumnHorizontalPadding
  void setTimeColumnHorizontalPadding(double value, {bool listeners = true}) {
    _settingsList.timeColumnHorizontalPadding = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// BorderWidth
  void setBorderWidth(double value, {bool listeners = true}) {
    _settingsList.borderWidth = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// EvenColumnOpacity
  void setEvenColumnOpacity(double value, {bool listeners = true}) {
    _settingsList.evenColumnOpacity = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// BackgroundColor
  void setBackgroundColor(String value, {bool listeners = true}) {
    _settingsList.backgroundColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// EnableColor
  void setEnableColor(String value, {bool listeners = true}) {
    _settingsList.enableColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// DisableColor
  void setDisableColor(String value, {bool listeners = true}) {
    _settingsList.disableColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// UnknownColor
  void setUnknownColor(String value, {bool listeners = true}) {
    _settingsList.unknownColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// BorderColor
  void setBorderColor(String value, {bool listeners = true}) {
    _settingsList.borderColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// TextColor
  void setTextColor(String value, {bool listeners = true}) {
    _settingsList.textColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// IncludeHeadersRow
  void setIncludeHeadersRow(bool value, {bool listeners = true}) {
    _settingsList.includeHeadersRow = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// IncludeTotalRow
  void setIncludeTotalRow(bool value, {bool listeners = true}) {
    _settingsList.includeTotalRow = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// ShowDate
  void setShowDate(bool value, {bool listeners = true}) {
    _settingsList.showDate = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// DateDaysOffset
  void setDateDaysOffset(int value, {bool listeners = true}) {
    _settingsList.dateDaysOffset = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// DateTextSize
  void setDateTextSize(double value, {bool listeners = true}) {
    _settingsList.dateTextSize = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// DateTextWeight
  void setDateTextWeight(double value, {bool listeners = true}) {
    _settingsList.dateTextWeight = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }

  //////////// DateTextColor
  void setDateTextColor(String value, {bool listeners = true}) {
    _settingsList.dateTextColor = value;
    db.updateSetting(_settingsList);
    if (listeners) notifyListeners();
  }
}
