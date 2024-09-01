import 'package:energy_graphs/widgets/my_list_tile.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class MySwitchListTile extends StatelessWidget {
  final bool enabled;
  final IconData? icon;
  final Widget? title;
  final String? subtitle;
  final bool value;
  final bool dimmingIcons;
  final EdgeInsets? padding;
  final Function(bool) onChanged;

  const MySwitchListTile({
    super.key,
    this.enabled = true,
    this.icon,
    this.title,
    this.subtitle,
    required this.value,
    this.dimmingIcons = false,
    this.padding,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter updateState) {
        return MyListTile(
          enabled: enabled,
          icon: icon,
          title: title,
          subtitle: subtitle,
          dimmingIcons: dimmingIcons,
          padding: padding,
          onTap: (() {
            updateState(() {
              onChanged(!value);
            });
          }),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: FlutterSwitch(
              disabled: !enabled,
              width: 50.0,
              height: 28.0,
              toggleSize: 20, // height - 2*padding
              padding: 4,
              value: value,
              activeColor: Theme.of(context)
                  .indicatorColor
                  .blend(Theme.of(context).colorScheme.inversePrimary, 40),
              inactiveColor: Theme.of(context).disabledColor.withOpacity(0.26),
              onToggle: (bool newValue) {
                updateState(() {
                  onChanged(newValue);
                });
              },
            ),
          ),
        );
      },
    );
  }
}
