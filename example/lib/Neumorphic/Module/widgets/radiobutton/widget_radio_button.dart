import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class RadioButtonWidgetPage extends StatefulWidget {
  const RadioButtonWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<RadioButtonWidgetPage> {
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
    return NeumorphicBackground(
      child: Scaffold(
        appBar: const TopBar(
          title: "RadioButton",
          actions: <Widget>[
            ThemeConfigurator(),
          ],
        ),
        backgroundColor: widget.isGlassMode
            ? Colors.transparent
            : NeumorphicColors.neumorphicScreenBg,
        body: Stack(
          children: [
            if (widget.isGlassMode)
              const Positioned.fill(
                child: LiquidBackground(),
              ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _DefaultWidget(isGlassMode: widget.isGlassMode),
                  CircleRadios(isGlassMode: widget.isGlassMode),
                  _EnabledDisabledWidget(isGlassMode: widget.isGlassMode),
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
  int? groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
    isGlassMode: ${widget.isGlassMode ? true : false},
    groupValue: groupValue,
    value: 1991,
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text(
      "2012",
      style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            groupValue: groupValue,
            value: 1991,
            onChanged: (int? value) {
              setState(() {
                groupValue = value;
              });
            },
            style: widget.isGlassMode
                ? NeumorphicRadioStyle(
                    shape: NeumorphicShape.concave,
                    selectedColor: Colors.white.withValues(alpha: 0.1),
                    unselectedColor: Colors.white.withValues(alpha: 0.05),
                  )
                : const NeumorphicRadioStyle(),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "1991",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            value: 2000,
            groupValue: groupValue,
            onChanged: (int? value) {
              setState(() {
                groupValue = value;
              });
            },
            style: widget.isGlassMode
                ? NeumorphicRadioStyle(
                    shape: NeumorphicShape.concave,
                    selectedColor: Colors.white.withValues(alpha: 0.1),
                    unselectedColor: Colors.white.withValues(alpha: 0.05),
                  )
                : const NeumorphicRadioStyle(),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2000",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            groupValue: groupValue,
            value: 2012,
            onChanged: (int? value) {
              setState(() {
                groupValue = value;
              });
            },
            style: widget.isGlassMode
                ? NeumorphicRadioStyle(
                    shape: NeumorphicShape.concave,
                    selectedColor: Colors.white.withValues(alpha: 0.1),
                    unselectedColor: Colors.white.withValues(alpha: 0.05),
                  )
                : const NeumorphicRadioStyle(),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "2012",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
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

class CircleRadios extends StatefulWidget {
  final bool isGlassMode;

  const CircleRadios({super.key, this.isGlassMode = false});

  @override
  createState() => _CircleRadiosState();
}

class _CircleRadiosState extends State<CircleRadios> {
  String? groupValue;

  Widget _buildCode(BuildContext context) {
    return Code("""
String groupValue;

NeumorphicRadio(
    isGlassMode: ${widget.isGlassMode ? true : false},
    groupValue: groupValue,
    style: NeumorphicRadioStyle(boxShape: NeumorphicBoxShape.circle()),
    value: "A",
    onChanged: (value) {
        setState(() {
          groupValue = value;
        });
    },
    child: Text(
      "A",
      style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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
            "Circle",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicRadioStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              selectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
              unselectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.05) : null,
            ),
            groupValue: groupValue,
            value: "A",
            onChanged: (value) {
              setState(() {
                groupValue = value.toString();
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "A",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            value: "B",
            style: NeumorphicRadioStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              selectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
              unselectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.05) : null,
            ),
            groupValue: groupValue,
            onChanged: (value) {
              setState(() {
                groupValue = value.toString();
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "B",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicRadioStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              selectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
              unselectedColor:
                  widget.isGlassMode ? Colors.white.withValues(alpha: 0.05) : null,
            ),
            groupValue: groupValue,
            value: "C",
            onChanged: (value) {
              setState(() {
                groupValue = value.toString();
              });
            },
            padding: const EdgeInsets.all(18.0),
            child: Text(
              "C",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
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

class _EnabledDisabledWidget extends StatefulWidget {
  final bool isGlassMode;

  const _EnabledDisabledWidget({this.isGlassMode = false});

  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  int? groupValue;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            groupValue: groupValue,
            value: 1,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            style: widget.isGlassMode
                ? NeumorphicRadioStyle(
                    shape: NeumorphicShape.concave,
                    selectedColor: Colors.white.withValues(alpha: 0.1),
                  )
                : const NeumorphicRadioStyle(),
            child: Text(
              "First",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
            onChanged: (int? value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
          const SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicRadio(
            isGlassMode: widget.isGlassMode,
            isEnabled: false,
            groupValue: groupValue,
            value: 2,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            style: widget.isGlassMode
                ? NeumorphicRadioStyle(
                    shape: NeumorphicShape.concave,
                    selectedColor: Colors.white.withValues(alpha: 0.05),
                  )
                : const NeumorphicRadioStyle(),
            child: Text(
              "Second",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
            onChanged: (int? value) {
              setState(() {
                groupValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
int groupValue;

NeumorphicRadio(
     isGlassMode: ${widget.isGlassMode ? true : false},
     isEnabled: false,
     groupValue: groupValue,
     value: 2,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
     child: Text(
       "Second",
       style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
     ),
),
""");
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
