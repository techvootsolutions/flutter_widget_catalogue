import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class IndicatorWidgetPage extends StatefulWidget {
  const IndicatorWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndicatorWidgetPage> {
  final NeumorphicThemeData _theme = const NeumorphicThemeData(
    lightSource: LightSource.topLeft,
    accentColor: NeumorphicColors.accent,
    depth: 4,
    intensity: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (context, isGlassMode, _) {
        return NeumorphicTheme(
          themeMode: isGlassMode ? ThemeMode.dark : ThemeMode.light,
          theme: _theme,
          child: _Page(),
        );
      },
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (context, isGlassMode, _) {
        return NeumorphicBackground(
          isGlassMode: isGlassMode,
          child: Scaffold(
            appBar: const TopBar(
              title: "Indicator",
              actions: <Widget>[
                ThemeConfigurator(),
              ],
            ),
            backgroundColor: isGlassMode
                ? Colors.transparent
                : NeumorphicColors.neumorphicScreenBg,
            body: Stack(
              children: [
                if (isGlassMode)
                  const Positioned.fill(
                    child: LiquidBackground(),
                  ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _DefaultWidget(isGlassMode: isGlassMode),
                      _DefaultOrientationWidget(isGlassMode: isGlassMode),
                      _DurationWidget(isGlassMode: isGlassMode),
                      _ColorWidget(isGlassMode: isGlassMode),
                      _CurveWidget(isGlassMode: isGlassMode),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  final bool isGlassMode;

  const _DefaultWidget({this.isGlassMode = false});

  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  double percent = 0.6;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    isGlassMode: ${widget.isGlassMode ? true : false},
    height: 100,
    width: 20,
    percent: 0.6,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicIndicator(
            isGlassMode: widget.isGlassMode,
            height: 100,
            width: 20,
            percent: percent,
            style: widget.isGlassMode
                ? IndicatorStyle(
                    accent: Colors.white.withValues(alpha: 0.3),
                    variant: Colors.white.withValues(alpha: 0.1),
                  )
                : const IndicatorStyle(),
          ),
          const SizedBox(width: 12),
          TextButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _DefaultOrientationWidget extends StatefulWidget {
  final bool isGlassMode;

  const _DefaultOrientationWidget({this.isGlassMode = false});

  @override
  createState() => _DefaultOrientationWidgetState();
}

class _DefaultOrientationWidgetState extends State<_DefaultOrientationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
     isGlassMode: ${widget.isGlassMode ? true : false},
     width: 150,
     height: 15,
     orientation: NeumorphicIndicatorOrientation.horizontal,
     percent: 0.7,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Orientation\nHorizontal",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicIndicator(
            isGlassMode: widget.isGlassMode,
            width: 150,
            height: 15,
            orientation: NeumorphicIndicatorOrientation.horizontal,
            percent: 0.7,
            style: widget.isGlassMode
                ? IndicatorStyle(
                    accent: Colors.white.withValues(alpha: 0.3),
                    variant: Colors.white.withValues(alpha: 0.1),
                  )
                : const IndicatorStyle(),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _ColorWidget extends StatefulWidget {
  final bool isGlassMode;

  const _ColorWidget({this.isGlassMode = false});

  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
      isGlassMode: ${widget.isGlassMode ? true : false},
      width: 150,
      height: 15,
      orientation: NeumorphicIndicatorOrientation.horizontal,
      percent: 0.7,
      style: IndicatorStyle(
        variant: variant,
        accent: accent
      ),
),
""");
  }

  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Accent : ",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              const SizedBox(width: 12),
              Text(
                "Variant : ",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Colorized",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              NeumorphicIndicator(
                isGlassMode: widget.isGlassMode,
                width: 150,
                height: 15,
                orientation: NeumorphicIndicatorOrientation.horizontal,
                percent: 0.7,
                style: IndicatorStyle(
                  variant: widget.isGlassMode
                      ? variant.withValues(alpha: 0.2)
                      : variant,
                  accent: widget.isGlassMode
                      ? accent.withValues(alpha: 0.3)
                      : accent,
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _DurationWidget extends StatefulWidget {
  final bool isGlassMode;

  const _DurationWidget({this.isGlassMode = false});

  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    isGlassMode: ${widget.isGlassMode ? true : false},
    height: 100,
    width: 20,
    percent: 0.3,
    duration: Duration(seconds: 1),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Duration",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicIndicator(
            isGlassMode: widget.isGlassMode,
            height: 100,
            width: 20,
            percent: percent,
            duration: const Duration(seconds: 1),
            style: widget.isGlassMode
                ? IndicatorStyle(
                    accent: Colors.white.withValues(alpha: 0.3),
                    variant: Colors.white.withValues(alpha: 0.1),
                  )
                : const IndicatorStyle(),
          ),
          const SizedBox(width: 12),
          TextButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}

class _CurveWidget extends StatefulWidget {
  final bool isGlassMode;

  const _CurveWidget({this.isGlassMode = false});

  @override
  createState() => _CurveWidgetState();
}

class _CurveWidgetState extends State<_CurveWidget> {
  double percent = 0.3;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicIndicator(
    isGlassMode: ${widget.isGlassMode ? true : false},
    height: 100,
    width: 20,
    percent: 0.3,
    curve: Curves.bounceOut,
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Curve",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicIndicator(
            isGlassMode: widget.isGlassMode,
            height: 100,
            width: 20,
            percent: percent,
            curve: Curves.bounceOut,
            style: widget.isGlassMode
                ? IndicatorStyle(
                    accent: Colors.white.withValues(alpha: 0.3),
                    variant: Colors.white.withValues(alpha: 0.1),
                  )
                : const IndicatorStyle(),
          ),
          const SizedBox(width: 12),
          TextButton(
              child: const Text('Update'),
              onPressed: () {
                setState(() {
                  percent = Random().nextDouble();
                });
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildWidget(context),
        _buildCode(context),
      ],
    );
  }
}
