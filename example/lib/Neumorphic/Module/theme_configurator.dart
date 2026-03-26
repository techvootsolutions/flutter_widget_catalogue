import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

import 'theme_color_selector.dart';

class ThemeConfigurator extends StatelessWidget {
  const ThemeConfigurator({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (innerContext, isGlassMode, _) {
        return NeumorphicButton(
          padding: const EdgeInsets.all(15),
          //isGlassMode: isGlassMode,
          style: isGlassMode
              ? NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: const NeumorphicBoxShape.circle(),
                  // color: Colors.white.withValues(alpha: 0.1),
                )
              : const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
          child: Icon(
            Icons.settings,
            color: NeumorphicTheme.isUsingDark(context)
                ? Colors.white70
                : Colors.black87,
          ),
          onPressed: () => _changeColor(innerContext),
        );
      },
    );
  }

  void _changeColor(BuildContext themeContext) {
    final theme = NeumorphicTheme.currentTheme(themeContext);

    showDialog(
      context: themeContext,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (context) {
        return ValueListenableBuilder<bool>(
          valueListenable: GlassModeManager.instance.isGlassMode,
          builder: (context, isGlassMode, _) {
            final content = SingleChildScrollView(
              child: _ThemeConfiguratorDialog(
                contextContainingTheme: themeContext,
                initialIntensity: theme.intensity,
                initialDepth: theme.depth,
                isGlassMode: isGlassMode,
              ),
            );

            if (isGlassMode) {
              return LiquidGlassDialog(
                title: 'Update Theme',
                height: 420,
                child: content,
              );
            }
            return AlertDialog(
              title: const Text('Update Theme'),
              content: SizedBox(width: 250, child: content),
              actions: [
                NeumorphicButton(
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

class _ThemeConfiguratorDialog extends StatefulWidget {
  final BuildContext? contextContainingTheme;
  final double? initialIntensity;
  final double? initialDepth;
  final bool isGlassMode;

  const _ThemeConfiguratorDialog({
    this.contextContainingTheme,
    this.initialIntensity,
    this.initialDepth,
    this.isGlassMode = false,
  });

  @override
  _ThemeConfiguratorState createState() => _ThemeConfiguratorState();
}

class _ThemeConfiguratorState extends State<_ThemeConfiguratorDialog> {
  double? _intensity;
  double? _depth;

  @override
  void initState() {
    super.initState();
    _intensity = widget.initialIntensity;
    _depth = widget.initialDepth;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only re-initialize if it was null for some reason
    _intensity ??=
        NeumorphicTheme.intensity(widget.contextContainingTheme ?? context);
    _depth ??= NeumorphicTheme.depth(widget.contextContainingTheme ?? context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!widget.isGlassMode) ...[
          ThemeColorSelector(customContext: widget.contextContainingTheme),
          const SizedBox(height: 14),
        ],
        _intensitySelector(),
        const SizedBox(height: 14),
        _depthSelector(),
        const SizedBox(height: 22),
        _glassTheme(),
      ],
    );
  }

  Widget _intensitySelector() {
    bool isGlassMode = GlassModeManager.instance.isGlassMode.value;

    return LiquidSliderRow(
      label: 'Intensity',
      value: _intensity ?? 0.5,
      displayValue: (((_intensity ?? 0.5) * 100).floor() / 100).toString(),
      min: Neumorphic.MIN_INTENSITY,
      max: Neumorphic.MAX_INTENSITY,
      isGlassMode: isGlassMode,
      onChanged: (value) {
        setState(() {
          _intensity = value;
        });
        // We update the theme also to provide real-time feedback to the background
        NeumorphicTheme.update(
          widget.contextContainingTheme ?? context,
          (current) => current!.copyWith(intensity: value),
        );
      },
    );
  }

  Widget _depthSelector() {
    bool isGlassMode = GlassModeManager.instance.isGlassMode.value;

    return LiquidSliderRow(
      label: 'Depth',
      value: _depth ?? 4,
      displayValue: (_depth ?? 4).floor().toString(),
      min: Neumorphic.MIN_DEPTH,
      max: Neumorphic.MAX_DEPTH,
      isGlassMode: isGlassMode,
      onChanged: (value) {
        setState(() {
          _depth = value;
        });
        NeumorphicTheme.update(
          widget.contextContainingTheme ?? context,
          (current) => current!.copyWith(depth: value),
        );
      },
    );
  }

  Widget _glassTheme() {
    bool isGlassMode = GlassModeManager.instance.isGlassMode.value;
    return GlassControlRow(
      label: 'Glass View (iOS style)',
      isGlassMode: isGlassMode,
      value: isGlassMode,
      onChanged: (value) {
        GlassModeManager.instance.setGlassMode(value);
      },
    );
  }
}
