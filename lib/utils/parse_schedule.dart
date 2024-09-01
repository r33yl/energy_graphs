List<List<String>> parseSchedule(String inputText, int queueCount) {
  // Разделяем текст на строки
  final lines = inputText.trim().split('\n');

  // Создаем пустой список для хранения данных
  List<List<String>> parsedData = [];

  // Проходим по каждой строке
  for (var line in lines) {
    // Проверяем, содержит ли строка время в формате xx:xx-xx:xx
    final timeMatch = RegExp(r'\d{2}:\d{2}-\d{2}:\d{2}').firstMatch(line);

    if (timeMatch != null) {
      // Извлекаем время
      final timeRange = timeMatch.group(0);

      // Извлекаем номера очередей
      final queueMatches = RegExp(r'\d+').allMatches(line).map((m) => m.group(0)).toList();

      // Инициализируем строку массива с временем
      List<String> row = [timeRange!];

      // Заполняем колонки нулями и единицами
      for (int i = 1; i <= queueCount; i++) {
        row.add(queueMatches.contains(i.toString()) ? '0' : '1');
      }

      // Добавляем строку в общий массив данных
      parsedData.add(row);
    }
  }

  // Возвращаем заполненный массив
  return mergeRows(parsedData);
}

// Функция для объединения строк с одинаковыми очередями
List<List<String>> mergeRows(List<List<String>> data) {
  List<List<String>> mergedData = [];

  for (var i = 0; i < data.length; i++) {
    // Если это последняя строка, просто добавляем её в mergedData
    if (i == data.length - 1) {
      mergedData.add(data[i]);
    } else {
      // Сравниваем текущую строку с следующей
      if (data[i].sublist(1).join() == data[i + 1].sublist(1).join()) {
        // Если строки совпадают, объединяем их диапазоны времени
        final mergedRow =
            [data[i][0].split('-')[0] + '-' + data[i + 1][0].split('-')[1]] + data[i].sublist(1);
        mergedData.add(mergedRow);
        i++; // Пропускаем следующую строку, так как она объединена
      } else {
        // Если не совпадают, добавляем текущую строку в mergedData
        mergedData.add(data[i]);
      }
    }
  }

  return mergedData;
}
