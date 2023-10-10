import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

import 'color_selector.dart';

class ThemeColorSelector extends StatefulWidget {
  final BuildContext? customContext;

  const ThemeColorSelector({super.key, this.customContext});

  @override
  ThemeColorSelectorState createState() => ThemeColorSelectorState();
}

class ThemeColorSelectorState extends State<ThemeColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      color: Colors.black,
      child: ColorSelector(
        color: NeumorphicTheme.baseColor(widget.customContext ?? context),
        onColorChanged: (color) {
          setState(() {
            NeumorphicTheme.update(widget.customContext ?? context,
                (current) => current!.copyWith(baseColor: color));
          });
        },
      ),
    );
  }
}
