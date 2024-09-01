import 'package:flutter/material.dart';

class ScheduleTable extends StatelessWidget {
  final List<List<String>> tableData;

  final double textSize;
  final double textWeight;
  final double verticalPadding;
  final double horizontalPadding;
  final double timeColumnHorizontalPadding;
  final double borderWidth;
  final double evenColumnOpacity;
  final Color backgroundColor;
  final Color enableColor;
  final Color disableColor;
  final Color unknownColor;
  final Color borderColor;
  final Color textColor;

  final bool includeHeadersRow;
  final bool includeTotalRow;

  const ScheduleTable({
    super.key,
    required this.tableData,
    required this.textSize,
    required this.textWeight,
    required this.verticalPadding,
    required this.horizontalPadding,
    required this.timeColumnHorizontalPadding,
    required this.borderWidth,
    required this.evenColumnOpacity,
    required this.backgroundColor,
    required this.enableColor,
    required this.disableColor,
    required this.unknownColor,
    required this.borderColor,
    required this.textColor,
    required this.includeHeadersRow,
    required this.includeTotalRow,
  });

  Color getCellColor(String value) {
    if (value == '1') {
      return enableColor;
    } else if (value == '0') {
      return disableColor;
    } else {
      return unknownColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      border: TableBorder.all(width: borderWidth, color: borderColor),
      children: tableData.asMap().entries.map((rowEntry) {
        int rowIndex = rowEntry.key;
        List<String> row = rowEntry.value;

        bool isFirstRow = rowIndex == 0;
        bool isLastRow = rowIndex == tableData.length - 1;

        return TableRow(
          children: row.asMap().entries.map((cellEntry) {
            int cellIndex = cellEntry.key;
            String cell = cellEntry.value;

            bool isFirstColumn = cellIndex == 0;
            bool isEvenColumn = cellIndex % 2 == 0;

            return Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: isFirstColumn ? timeColumnHorizontalPadding : horizontalPadding,
              ),
              color:
                  (isFirstColumn || isFirstRow && includeHeadersRow || isLastRow && includeTotalRow)
                      ? isEvenColumn && !isFirstColumn
                          ? backgroundColor.withOpacity(evenColumnOpacity)
                          : backgroundColor
                      : isEvenColumn
                          ? getCellColor(cell).withOpacity(evenColumnOpacity)
                          : getCellColor(cell),
              child: Center(
                child: Text(
                  (isFirstColumn || isFirstRow && includeHeadersRow || isLastRow && includeTotalRow)
                      ? cell
                      : " ",
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.values[(textWeight.toInt() - 1) % 8],
                    color: textColor,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
      // ),
    );
  }
}
