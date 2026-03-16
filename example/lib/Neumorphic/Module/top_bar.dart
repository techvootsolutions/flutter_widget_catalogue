import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

import 'back_button.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  static const double kToolbarHeight = 70.0;

  const TopBar({
    super.key,
    this.title = "",
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0, top: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(alignment: Alignment.centerLeft, child: NeumorphicBack()),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: NeumorphicTheme.isUsingDark(context)
                    ? Colors.white70
                    : Colors.black87,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ValueListenableBuilder<bool>(
                  valueListenable: GlassModeManager.instance.isGlassMode,
                  builder: (context, isGlassMode, _) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: NeumorphicSwitch(
                        height: 30,
                        value: isGlassMode,
                        onChanged: (value) {
                          GlassModeManager.instance.setGlassMode(value);
                        },
                      ),
                    );
                  },
                ),
                ...?actions,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
