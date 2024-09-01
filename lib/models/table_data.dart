import 'package:flutter/material.dart';

class TableData with ChangeNotifier {
  List<List<String>> _tableData = [];

  // Метод для получения данных таблицы
  List<List<String>> getTableData({
    bool includeHeadersRow = true,
    bool includeTotalRow = true,
  }) {
    List<List<String>> data = List.from(_tableData);

    if (includeHeadersRow && data.isNotEmpty) {
      // Добавление строки с номерами очередей
      String zeroCell = "Час/Черга";
      List<String> headers = [zeroCell] +
          List.generate(data[0].length - 1, (index) {
            return "${index + 1}";
          });
      data.insert(0, headers);
    }

    if (includeTotalRow && data.isNotEmpty) {
      // Создание строки "Всего"
      List<String> totalRow = ['Загалом'];

      for (int col = 1; col < _tableData[0].length; col++) {
        int totalHours = 0;

        for (int row = 0; row < _tableData.length; row++) {
          if (_tableData[row][col] == '0') {
            // Извлечение диапазона времени и подсчёт его продолжительности в часах
            String timeRange = _tableData[row][0];
            int hours = _calculateDurationInHours(timeRange);
            totalHours += hours;
          }
        }

        totalRow.add(totalHours.toString());
      }
      data = data + [totalRow];
    }

    return data;
  }

  void updateTableData(List<List<String>> newData) {
    _tableData = newData;
    notifyListeners();
  }

  void updateCell(int row, int column, String value) {
    _tableData[row][column] = value;
    notifyListeners();
  }

  int _calculateDurationInHours(String timeRange) {
    List<String> times = timeRange.split('-');
    DateTime startTime = _parseTime(times[0]);
    DateTime endTime = _parseTime(times[1]);

    // Расчёт разницы во времени в часах
    return endTime.difference(startTime).inHours;
  }

  // Функция для парсинга времени
  DateTime _parseTime(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return DateTime(0, 1, 1, hours, minutes);
  }
}
