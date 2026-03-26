import 'package:example/Neumorphic/Module/theme_color_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

@immutable
class ColorSelector extends StatelessWidget {
  final Color? color;
  final ValueChanged<Color>? onColorChanged;
  final double height;
  final double width;

  const ColorSelector({
    super.key,
    this.height = 40,
    this.width = 40,
    this.color,
    this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _changeColor(context),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          // Glass-style border: subtle white glow
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.35),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (color ?? Colors.white).withValues(alpha: 0.25),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _changeColor(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      builder: (context) {
        return ValueListenableBuilder<bool>(
          valueListenable: GlassModeManager.instance.isGlassMode,
          builder: (context, isGlassMode, _) {
            final content = SingleChildScrollView(
              child: ColorPicker(
                pickerColor: color!,
                onColorChanged: onColorChanged!,
                labelTypes: const [],
                pickerAreaHeightPercent: 0.8,
                displayThumbColor: true,
                hexInputBar: true,
                pickerAreaBorderRadius: BorderRadius.circular(12),
                paletteType: PaletteType.hsvWithHue,
              ),
            );

            if (isGlassMode) {
              return LiquidGlassDialog(
                title: 'Pick a color!',
                height: 500,
                child: content,
              );
            }

            return AlertDialog(
              title: const Text('Pick a color!'),
              content: SizedBox(width: 300, child: content),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
