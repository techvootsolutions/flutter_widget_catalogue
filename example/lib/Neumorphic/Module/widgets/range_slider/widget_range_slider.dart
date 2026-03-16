import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class RangeSliderWidgetPage extends StatefulWidget {
  const RangeSliderWidgetPage({super.key});

  @override
  createState() => _RangeWidgetPageState();
}

class _RangeWidgetPageState extends State<RangeSliderWidgetPage> {
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
          child: _Page(isGlassMode: isGlassMode),
        );
      },
    );
  }
}

class _Page extends StatefulWidget {
  final bool isGlassMode;

  const _Page({
    required this.isGlassMode,
  });

  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    bool isGlassMode = widget.isGlassMode;
    return NeumorphicBackground(
      isGlassMode: isGlassMode,
      child: Scaffold(
        appBar: const TopBar(
          title: "Range Slider",
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
                  _ColorWidget(isGlassMode: isGlassMode),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
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
  double lowVal = 30;
  double highVal = 70;

  Widget _buildCode(BuildContext context) {
    return const Code("""
  double lowVal = 30;
  double highVal = 70;

  Expanded(
    child: NeumorphicRangeSlider(
      valueLow: lowVal,
      valueHigh: highVal,
      min: 18,
      max: 90,
      onChangedLow: (value) {
        setState(() {
          lowVal = value;
        });
      },
      onChangeHigh: (value) {
        setState(() {
          highVal = value;
        });
      },
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
            child: NeumorphicRangeSlider(
              isGlassMode: widget.isGlassMode,
              valueLow: lowVal,
              valueHigh: highVal,
              min: 18,
              max: 90,
              style: widget.isGlassMode
                  ? RangeSliderStyle(
                      accent: Colors.white.withValues(alpha: 0.3),
                      variant: Colors.white.withValues(alpha: 0.1),
                    )
                  : const RangeSliderStyle(),
              onChangedLow: (value) {
                setState(() {
                  lowVal = value;
                });
              },
              onChangeHigh: (value) {
                setState(() {
                  highVal = value;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "${lowVal.round()} - ${highVal.round()}",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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

class _ColorWidget extends StatefulWidget {
  final bool isGlassMode;

  const _ColorWidget({this.isGlassMode = false});

  @override
  createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<_ColorWidget> {
  double lowVal = 30;
  double highVal = 80;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double lowVal = 30;
double highVal = 80;

  Expanded(
    child: NeumorphicRangeSlider(
      style: RangeSliderStyle(
        accent: accent,
        variant: variant,
      ),
      valueLow: lowVal,
      valueHigh: highVal,
      min: 18,
      max: 90,
      onChangedLow: (value) {
        setState(() {
          lowVal = value;
        });
      },
      onChangeHigh: (value) {
        setState(() {
          highVal = value;
        });
      },
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
                child: NeumorphicRangeSlider(
                  isGlassMode: widget.isGlassMode,
                  style: RangeSliderStyle(
                    accent:
                        widget.isGlassMode ? accent.withValues(alpha: 0.3) : accent,
                    variant: widget.isGlassMode
                        ? variant.withValues(alpha: 0.2)
                        : variant,
                  ),
                  valueLow: lowVal,
                  valueHigh: highVal,
                  min: 18,
                  max: 90,
                  onChangedLow: (value) {
                    setState(() {
                      lowVal = value;
                    });
                  },
                  onChangeHigh: (value) {
                    setState(() {
                      highVal = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "${lowVal.round()} - ${highVal.round()}",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
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
