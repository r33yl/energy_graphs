import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerListTile extends StatelessWidget {
  final String title;
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPickerListTile({
    super.key,
    required this.title,
    required this.pickerColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: pickerColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        _showColorPickerDialog(context);
      },
    );
  }

  void _showColorPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
          content: SingleChildScrollView(
            child: SlidePicker(
              pickerColor: pickerColor,
              onColorChanged: onColorChanged,
              showParams: true,
              indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
            ),
          ),
        );
      },
    );
  }
}
