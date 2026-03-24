import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class IndeterminateProgressWidgetPage extends StatefulWidget {
  const IndeterminateProgressWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<IndeterminateProgressWidgetPage> {
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
              title: "Indeterminate Progress",
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
                      DefaultWidget1(isGlassMode: isGlassMode),
                      ColorWidget1(isGlassMode: isGlassMode),
                      _SizedWidget(isGlassMode: isGlassMode),
                      _DurationWidget(isGlassMode: isGlassMode),
                      _ReversedWidget(isGlassMode: isGlassMode),
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

class DefaultWidget1 extends StatefulWidget {
  final bool isGlassMode;
  const DefaultWidget1({super.key, this.isGlassMode = false});

  @override
  createState() => _DefaultWidgetState1();
}

class _DefaultWidgetState1 extends State<DefaultWidget1> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
      isGlassMode: ${widget.isGlassMode ? true : false},
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
            child: NeumorphicProgressIndeterminate(
              isGlassMode: widget.isGlassMode,
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
        _buildCode(context),
      ],
    );
  }
}

class ColorWidget1 extends StatefulWidget {
  final bool isGlassMode;
  const ColorWidget1({super.key, this.isGlassMode = false});

  @override
  createState() => _ColorWidgetState1();
}

class _ColorWidgetState1 extends State<ColorWidget1> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
      isGlassMode: ${widget.isGlassMode ? true : false},
      style: ProgressStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
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
                "Default",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgressIndeterminate(
                  isGlassMode: widget.isGlassMode,
                  style: ProgressStyle(
                    accent: widget.isGlassMode
                        ? accent.withValues(alpha: 0.3)
                        : accent,
                    variant: widget.isGlassMode
                        ? variant.withValues(alpha: 0.2)
                        : variant,
                  ),
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
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
      isGlassMode: ${widget.isGlassMode ? true : false},
      height: 30,
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
                child: NeumorphicProgressIndeterminate(
                  isGlassMode: widget.isGlassMode,
                  height: 30,
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
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
       isGlassMode: ${widget.isGlassMode ? true : false},
       duration: Duration(seconds: 10),
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
                "Duration",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicProgressIndeterminate(
                  isGlassMode: widget.isGlassMode,
                  duration: const Duration(seconds: 10),
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

class _ReversedWidget extends StatefulWidget {
  final bool isGlassMode;
  const _ReversedWidget({this.isGlassMode = false});

  @override
  createState() => _ReversedWidgetState();
}

class _ReversedWidgetState extends State<_ReversedWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
       isGlassMode: ${widget.isGlassMode ? true : false},
       reverse: true,
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
            "Reversed",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicProgressIndeterminate(
              isGlassMode: widget.isGlassMode,
              reverse: true,
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
  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicProgressIndeterminate(
       isGlassMode: ${widget.isGlassMode ? true : false},
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
            child: NeumorphicProgressIndeterminate(
              isGlassMode: widget.isGlassMode,
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
        _buildCode(context),
      ],
    );
  }
}
