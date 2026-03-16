import 'dart:math' show Random;
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';

class ProgressWidgetPage extends StatefulWidget {
  const ProgressWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ProgressWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (context, isGlassMode, _) {
        return NeumorphicTheme(
          themeMode: isGlassMode ? ThemeMode.dark : ThemeMode.light,
          theme: const NeumorphicThemeData(
            lightSource: LightSource.topLeft,
            accentColor: NeumorphicColors.accent,
            depth: 4,
            intensity: 0.5,
          ),
          child: const _Page(),
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
              title: "Progress",
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
                      _SizedWidget(isGlassMode: isGlassMode),
                      _ColorWidget(isGlassMode: isGlassMode),
                      _DurationWidget(isGlassMode: isGlassMode),
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
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
  ),
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
          Expanded(
            child: NeumorphicProgress(
              isGlassMode: widget.isGlassMode,
              percent: percent,
              style: widget.isGlassMode
                  ? ProgressStyle(
                      accent: Colors.white.withValues(alpha: 0.3),
                      variant: Colors.white.withValues(alpha: 0.1),
                    )
                  : const ProgressStyle(),
            ),
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
        TextButton(
            child: const Text('Update'),
            onPressed: () {
              setState(() {
                percent = Random().nextDouble();
              });
            }),
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
  double percent = 0.5;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      percent: percent,
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
              const Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              const SizedBox(width: 12),
              const Text("Variant : "),
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
                "Default",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  isGlassMode: widget.isGlassMode,
                  style: ProgressStyle(
                    accent:
                        widget.isGlassMode ? accent.withValues(alpha: 0.3) : accent,
                    variant: widget.isGlassMode
                        ? variant.withValues(alpha: 0.2)
                        : variant,
                  ),
                  percent: percent,
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

class _SizedWidget extends StatefulWidget {
  final bool isGlassMode;

  const _SizedWidget({this.isGlassMode = false});

  @override
  createState() => _SizedWidgetState();
}

class _SizedWidgetState extends State<_SizedWidget> {
  double percent = 0.5;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double percent = 0.5;  

Expanded(
  child: NeumorphicProgress(
      height: 30,
      percent: percent,
  ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Sized",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgress(
                  isGlassMode: widget.isGlassMode,
                  height: 30,
                  percent: percent,
                  style: widget.isGlassMode
                      ? ProgressStyle(
                          accent: Colors.white.withValues(alpha: 0.3),
                          variant: Colors.white.withValues(alpha: 0.1),
                        )
                      : const ProgressStyle(),
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
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      duration: Duration(seconds: 1),
  ),
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
          Expanded(
            child: NeumorphicProgress(
              isGlassMode: widget.isGlassMode,
              percent: percent,
              duration: const Duration(seconds: 1),
              style: widget.isGlassMode
                  ? ProgressStyle(
                      accent: Colors.white.withValues(alpha: 0.3),
                      variant: Colors.white.withValues(alpha: 0.1),
                    )
                  : const ProgressStyle(),
            ),
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
        TextButton(
            child: const Text('Update'),
            onPressed: () {
              setState(() {
                percent = Random().nextDouble();
              });
            }),
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
  double percent = 0.2;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double percent = 0.2;  

Expanded(
  child: NeumorphicProgress(
      percent: percent,
      curve: Curves.bounceOut,
  ),
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
          Expanded(
            child: NeumorphicProgress(
              isGlassMode: widget.isGlassMode,
              percent: percent,
              curve: Curves.bounceOut,
              style: widget.isGlassMode
                  ? ProgressStyle(
                      accent: Colors.white.withValues(alpha: 0.3),
                      variant: Colors.white.withValues(alpha: 0.1),
                    )
                  : const ProgressStyle(),
            ),
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
        TextButton(
            child: const Text('Update'),
            onPressed: () {
              setState(() {
                percent = Random().nextDouble();
              });
            }),
        _buildCode(context),
      ],
    );
  }
}
