import 'package:energy_graphs/models/settings_data.dart';
import 'package:energy_graphs/widgets/my_switch_list_tile.dart';
import 'package:energy_graphs/widgets/schedule_table.dart';
import 'package:energy_graphs/services/image_saver/save_image.dart';
import 'package:energy_graphs/utils/show_toast.dart';
import 'package:energy_graphs/models/table_data.dart';
import 'package:energy_graphs/widgets/color_picker_list_tile.dart';

import 'package:energy_graphs/widgets/slider_list_tile.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:uuid/uuid.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({
    super.key,
  });

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final GlobalKey _globalKey = GlobalKey();

  late double textSize;
  late double textWeight;
  late double verticalPadding;
  late double horizontalPadding;
  late double timeColumnHorizontalPadding;
  late double borderWidth;
  late double evenColumnOpacity;

  late Color backgroundColor;
  late Color enableColor;
  late Color disableColor;
  late Color unknownColor;
  late Color borderColor;
  late Color textColor;

  late bool includeHeadersRow;
  late bool includeTotalRow;

  late bool showDate;
  late int dateDaysOffset;
  late double dateTextSize;
  late double dateTextWeight;
  late Color dateTextColor;

  @override
  void initState() {
    super.initState();

    textSize = Provider.of<SettingsData>(context, listen: false).getSettings().textSize;
    textWeight = Provider.of<SettingsData>(context, listen: false).getSettings().textWeight;
    verticalPadding =
        Provider.of<SettingsData>(context, listen: false).getSettings().verticalPadding;
    horizontalPadding =
        Provider.of<SettingsData>(context, listen: false).getSettings().horizontalPadding;
    timeColumnHorizontalPadding =
        Provider.of<SettingsData>(context, listen: false).getSettings().timeColumnHorizontalPadding;
    borderWidth = Provider.of<SettingsData>(context, listen: false).getSettings().borderWidth;
    evenColumnOpacity =
        Provider.of<SettingsData>(context, listen: false).getSettings().evenColumnOpacity;

    //colors

    backgroundColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().backgroundColor);
    enableColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().enableColor);
    disableColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().disableColor);
    unknownColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().unknownColor);
    borderColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().borderColor);
    textColor =
        HexColor.fromHex(Provider.of<SettingsData>(context, listen: false).getSettings().textColor);

    //
    includeHeadersRow =
        Provider.of<SettingsData>(context, listen: false).getSettings().includeHeadersRow;
    includeTotalRow =
        Provider.of<SettingsData>(context, listen: false).getSettings().includeTotalRow;

    //
    showDate = Provider.of<SettingsData>(context, listen: false).getSettings().showDate;
    dateDaysOffset = Provider.of<SettingsData>(context, listen: false).getSettings().dateDaysOffset;
    dateTextSize = Provider.of<SettingsData>(context, listen: false).getSettings().dateTextSize;
    dateTextWeight = Provider.of<SettingsData>(context, listen: false).getSettings().dateTextWeight;
    dateTextColor = HexColor.fromHex(
        Provider.of<SettingsData>(context, listen: false).getSettings().dateTextColor);
  }

  @override
  void dispose() {
    super.dispose();
  }

  String createImageName() {
    return "image_${const Uuid().v1().substring(0, 8)}";
  }

  Future<void> _captureAndSaveImage() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      if (mounted) await saveImageToGallery(context, pngBytes, "${createImageName()}.png");
    } catch (e) {
      if (mounted) showToast(context, "Ошибка сохранения");
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<SettingsData>(
        builder: (context, settingsData, child) {
          List<List<String>> tableData = Provider.of<TableData>(context, listen: false)
              .getTableData(includeHeadersRow: includeHeadersRow, includeTotalRow: includeTotalRow);

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ScheduleTable(
                        tableData: tableData,
                        textSize: textSize,
                        textWeight: textWeight,
                        verticalPadding: verticalPadding,
                        horizontalPadding: horizontalPadding,
                        timeColumnHorizontalPadding: timeColumnHorizontalPadding,
                        borderWidth: borderWidth,
                        evenColumnOpacity: evenColumnOpacity,
                        backgroundColor: backgroundColor,
                        enableColor: enableColor,
                        disableColor: disableColor,
                        unknownColor: unknownColor,
                        borderColor: borderColor,
                        textColor: textColor,
                        includeHeadersRow: includeHeadersRow,
                        includeTotalRow: includeTotalRow,
                      ),
                      if (showDate)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            DateFormat("Дата: dd.MM.yyyy")
                                .format(DateTime.now().add(Duration(days: dateDaysOffset))),
                            style: TextStyle(
                              fontSize: dateTextSize,
                              color: dateTextColor,
                              fontWeight: FontWeight.values[(dateTextWeight.toInt() - 1) % 8],
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(children: [Expanded(child: saveImageButton())]),
                            SliderListTile(
                              title: "Text Size:",
                              value: textSize,
                              min: 8.0,
                              max: 22.0,
                              divisions: 7,
                              onChanged: (double value) {
                                setState(() {
                                  textSize = value;
                                  settingsData.setTextSize(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Text Weight:",
                              value: textWeight,
                              min: 1.0,
                              max: 8.0,
                              divisions: 7,
                              onChanged: (double value) {
                                setState(() {
                                  textWeight = value;
                                  settingsData.setTextWeight(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Vert Padding:",
                              value: verticalPadding,
                              min: 0.0,
                              max: 8.0,
                              divisions: 8,
                              onChanged: (double value) {
                                setState(() {
                                  verticalPadding = value;
                                  settingsData.setVerticalPadding(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Queue Hor Padding:",
                              value: horizontalPadding,
                              min: 4.0,
                              max: 24.0,
                              divisions: 10,
                              onChanged: (double value) {
                                setState(() {
                                  horizontalPadding = value;
                                  settingsData.setHorizontalPadding(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Time Hor Padding:",
                              value: timeColumnHorizontalPadding,
                              min: 2.0,
                              max: 18.0,
                              divisions: 8,
                              onChanged: (double value) {
                                setState(() {
                                  timeColumnHorizontalPadding = value;
                                  settingsData.setTimeColumnHorizontalPadding(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Border Width:",
                              value: borderWidth,
                              min: 0.0,
                              max: 4.0,
                              divisions: 8,
                              onChanged: (double value) {
                                setState(() {
                                  borderWidth = value;
                                  settingsData.setBorderWidth(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Even Column Opacity:",
                              value: evenColumnOpacity,
                              min: 0.5,
                              max: 1.0,
                              divisions: 10,
                              onChanged: (double value) {
                                setState(() {
                                  evenColumnOpacity = value;
                                  settingsData.setEvenColumnOpacity(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ColorPickerListTile(
                        title: "Background Color",
                        pickerColor: backgroundColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            backgroundColor = value;
                            settingsData.setBackgroundColor(value.hex);
                          });
                        },
                      ),
                      ColorPickerListTile(
                        title: "Enable Color",
                        pickerColor: enableColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            enableColor = value;
                            settingsData.setEnableColor(value.hex);
                          });
                        },
                      ),
                      ColorPickerListTile(
                        title: "Disable Color",
                        pickerColor: disableColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            disableColor = value;
                            settingsData.setDisableColor(value.hex);
                          });
                        },
                      ),
                      ColorPickerListTile(
                        title: "Unknown Color",
                        pickerColor: unknownColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            unknownColor = value;
                            settingsData.setUnknownColor(value.hex);
                          });
                        },
                      ),
                      ColorPickerListTile(
                        title: "Border Color",
                        pickerColor: borderColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            borderColor = value;
                            settingsData.setBorderColor(value.hex);
                          });
                        },
                      ),
                      ColorPickerListTile(
                        title: "Text Color",
                        pickerColor: textColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            textColor = value;
                            settingsData.setTextColor(value.hex);
                          });
                        },
                      ),
                      MySwitchListTile(
                        title: const Text("Headers Row"),
                        value: includeHeadersRow,
                        onChanged: (bool value) {
                          setState(() {
                            includeHeadersRow = value;
                            settingsData.setIncludeHeadersRow(value);
                          });
                        },
                      ),
                      MySwitchListTile(
                        title: const Text("Total Row"),
                        value: includeTotalRow,
                        onChanged: (bool value) {
                          setState(() {
                            includeTotalRow = value;
                            settingsData.setIncludeTotalRow(value);
                          });
                        },
                      ),
                      MySwitchListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Show Date"),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        dateDaysOffset -= 1;
                                        settingsData.setDateDaysOffset(dateDaysOffset);
                                      });
                                    },
                                    icon: const Icon(Icons.remove)),
                                Container(
                                  width: 36,
                                  alignment: Alignment.center,
                                  child: Text(dateDaysOffset.toString()),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        dateDaysOffset += 1;
                                        settingsData.setDateDaysOffset(dateDaysOffset);
                                      });
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ],
                        ),
                        value: showDate,
                        onChanged: (bool value) {
                          setState(() {
                            showDate = value;
                            settingsData.setShowDate(value);
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SliderListTile(
                              title: "Date Text Size:",
                              value: dateTextSize,
                              min: 8.0,
                              max: 22.0,
                              divisions: 7,
                              onChanged: (double value) {
                                setState(() {
                                  dateTextSize = value;
                                  settingsData.setDateTextSize(value);
                                });
                              },
                            ),
                            SliderListTile(
                              title: "Date Text Weight:",
                              value: dateTextWeight,
                              min: 1.0,
                              max: 8.0,
                              divisions: 7,
                              onChanged: (double value) {
                                setState(() {
                                  dateTextWeight = value;
                                  settingsData.setDateTextWeight(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ColorPickerListTile(
                        title: "Date Text Color",
                        pickerColor: dateTextColor,
                        onColorChanged: (Color value) {
                          setState(() {
                            dateTextColor = value;
                            settingsData.setDateTextColor(value.hex);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
  saveImageButton() {
    return FloatingActionButton.extended(
      label: const Row(
        children: [
          Icon(Icons.save_outlined),
          SizedBox(width: 8.0),
          Text("Зберігти як зображення"),
        ],
      ),
      onPressed: () {
        setState(() {
          _captureAndSaveImage();
        });
      },
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
