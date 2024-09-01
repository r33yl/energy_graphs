import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final bool enabled;
  final bool selected;
  final IconData? icon;

  final Widget? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool dimmingIcons;

  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;

  const MyListTile({
    super.key,
    this.enabled = true,
    this.selected = false,
    this.icon,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.dimmingIcons = false,
    this.padding,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
  }) : assert(icon == null || leading == null,
            'You can only use either "icon" or "leading", not both.');

  @override
  Widget build(BuildContext context) {
    bool smallVerticalDensity = subtitle != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        onDoubleTap: enabled ? onDoubleTap : null,
        onLongPress: enabled ? onLongPress : null,
        child: ListTile(
          enabled: enabled,
          selected: selected,
          leading: (icon != null)
              ? Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Icon(
                      icon,
                      color: dimmingIcons ? Theme.of(context).hintColor : null,
                    ),
                  ],
                )
              : leading,
          title: title,
          subtitle: (subtitle != null)
              ? Text(
                  subtitle!,
                  style: TextStyle(
                    color: enabled ? Theme.of(context).hintColor : null,
                  ),
                )
              : null,
          trailing: trailing,
          visualDensity: smallVerticalDensity ? const VisualDensity(vertical: -4) : null,
          minVerticalPadding: smallVerticalDensity ? 10 : null,
          contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0),
        ),
      ),
    );
  }
}
