import 'package:energy_graphs/models/settings_data.dart';
import 'package:energy_graphs/utils/parse_schedule.dart';
import 'package:energy_graphs/models/table_data.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablePage extends StatefulWidget {
  const TablePage({
    super.key,
    required this.updateTab,
  });

  final void Function(int) updateTab;

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  final TextEditingController _queueController = TextEditingController();
  final TextEditingController _inputDataController = TextEditingController();
  final TextEditingController _tableDataController = TextEditingController();

  final FocusNode _queueFocus = FocusNode();
  final FocusNode _inputDataFocus = FocusNode();
  final FocusNode _tableDataFocus = FocusNode();

  bool isQueueValid = true;
  bool isTableValid = true;

  @override
  void initState() {
    super.initState();

    _queueController.text =
        Provider.of<SettingsData>(context, listen: false).getSettings().queueCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          children: [
            queueInputForm(),
            const SizedBox(height: 16.0),
            inputForm(),
            const SizedBox(height: 16.0),
            tableForm(),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: convertToTableButton()),
                const SizedBox(width: 16.0),
                createImageButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void checkValidateQueue() {
    setState(() {
      String queueText = _queueController.text;
      if (isNumeric(queueText) && isPositiveInteger(queueText)) {
        isQueueValid = true;
      } else {
        isQueueValid = false;
      }
    });
  }

  bool isNumeric(String str) {
    if (str.isEmpty) return false;

    final number = num.tryParse(str);
    return number != null;
  }

  bool isPositiveInteger(String str) {
    // Проверяем, не пустая ли строка и состоит ли она только из цифр
    if (str.isEmpty || !RegExp(r'^\d+$').hasMatch(str)) {
      return false;
    }

    // Преобразуем строку в число и проверяем, положительное ли оно
    final intValue = int.tryParse(str);
    return intValue != null && intValue > 0;
  }

  queueInputForm() {
    Widget clearButton() {
      return IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.clear),
        padding: const EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            if (_queueController.text.isNotEmpty) {
              _queueController.text = "";
            } else {
              _queueFocus.unfocus();
            }
          });
        },
      );
    }

    return TextFormField(
      controller: _queueController,
      focusNode: _queueFocus,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "Кількість черг",
        errorText: !isQueueValid ? "Некоректне значення " : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        prefixIcon: const Icon(Icons.numbers),
        suffixIcon:
            (_queueController.text.isNotEmpty || _queueFocus.hasFocus) ? clearButton() : null,
      ),
      onTap: () {
        setState(() {});
      },
      onChanged: (value) {
        setState(() {
          if (isNumeric(value) && isPositiveInteger(value)) {
            int queue = num.tryParse(value)!.toInt();
            Provider.of<SettingsData>(context, listen: false).setQueueCount(queue);
          }
        });
      },
    );
  }

  void checkValidateTable() {
    setState(() {
      if (_tableDataController.text.isNotEmpty) {
        isTableValid = true;
      } else {
        isTableValid = false;
      }
    });
  }

  inputForm() {
    Widget clearButton() {
      return IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.clear),
        padding: const EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            if (_inputDataController.text.isNotEmpty) {
              _inputDataController.text = "";
              _tableDataController.text = "";
              Provider.of<TableData>(context, listen: false).updateTableData([]);
            } else {
              _inputDataFocus.unfocus();
            }
          });
        },
      );
    }

    return Stack(
      children: [
        TextFormField(
          controller: _inputDataController,
          focusNode: _inputDataFocus,
          keyboardType: TextInputType.multiline,
          minLines: 8,
          maxLines: 11,
          decoration: const InputDecoration(
            labelText: "Вхідні данні",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // ignore: prefer_interpolation_to_compose_strings
            hintText: "Підтримує дані типу:\n" +
                "16:00-17:00 1 та 3 черги\n" +
                "17:00-18:00 2, 3 та 4 черги\n" +
                "18:00-19:00 1, 2 та 4 черги\n",
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            suffixIconConstraints: BoxConstraints(minWidth: 44),
            suffixIcon: SizedBox.shrink(),
          ),
          onTap: () {
            setState(() {});
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
        if (_inputDataController.text.isNotEmpty || _inputDataFocus.hasFocus)
          Positioned(
            right: 2,
            top: 2,
            child: clearButton(),
          ),
      ],
    );
  }

  tableForm() {
    return Stack(
      children: [
        TextFormField(
          readOnly: true,
          controller: _tableDataController,
          focusNode: _tableDataFocus,
          keyboardType: TextInputType.multiline,
          minLines: 5,
          maxLines: 8,
          style: TextStyle(
            color: Theme.of(context).disabledColor.withOpacity(0.7),
          ),
          decoration: InputDecoration(
            labelText: "Таблиця для створення зображення",
            errorText: !isTableValid ? "Не може бути порожнім " : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // ignore: prefer_interpolation_to_compose_strings
            hintText: "Результат перетворення в таблицю типу:\n" +
                "[16:00-17:00, 1, 0, 1, 0],\n" +
                "[17:00-18:00, 0, 1, 1, 1],\n" +
                "[18:00-19:00, 1, 1, 0, 1]\n",
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),

            suffixIconConstraints: const BoxConstraints(minWidth: 44),
            suffixIcon: const SizedBox.shrink(),
          ),
          onTap: () {
            setState(() {});
          },
          onChanged: (value) {
            setState(() {});
          },
        ),
      ],
    );
  }

  convertToTableButton() {
    return FloatingActionButton.extended(
      label: const Row(
        children: [
          Icon(Icons.create_outlined),
          SizedBox(width: 8.0),
          Text("Створити таблицю"),
        ],
      ),
      onPressed: () {
        try {
          setState(() {
            checkValidateQueue();

            if (isQueueValid) {
              int queue = num.tryParse(_queueController.text)!.toInt();
              List<List<String>> parseData = parseSchedule(_inputDataController.text, queue);
              Provider.of<TableData>(context, listen: false).updateTableData(parseData);

              _tableDataController.text = "";
              for (int i = 0; i < parseData.length; i++) {
                List<String> row = parseData[i];
                if (i != 0) _tableDataController.text += ",\n";
                _tableDataController.text += "$row";
              }
            }
            checkValidateTable();
          });
        } catch (e) {
          _tableDataController.text = "";
          _tableDataController.text += "Виникла помилка:";
          _tableDataController.text += e.toString();
        }
      },
    );
  }

  createImageButton() {
    return FloatingActionButton.extended(
      label: const Icon(Icons.arrow_forward_outlined),
      onPressed: () {
        setState(() {
          checkValidateTable();

          if (isTableValid) {
            widget.updateTab(1);
          }
        });
      },
    );
  }
}
