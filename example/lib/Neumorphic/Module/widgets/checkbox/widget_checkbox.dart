import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class CheckboxWidgetPage extends StatefulWidget {
  const CheckboxWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<CheckboxWidgetPage> {
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
          child: Scaffold(
            appBar: const TopBar(
              title: "Checkbox",
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
                      _EnabledDisabledWidget(isGlassMode: isGlassMode),
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
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  Widget _buildCode(BuildContext context) {
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
    isGlassMode: ${widget.isGlassMode ? true : false},
    value: isChecked,
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            value: check1,
            style: widget.isGlassMode
                ? const NeumorphicCheckboxStyle(
                    selectedColor: Colors.white,
                  )
                : const NeumorphicCheckboxStyle(),
            onChanged: (value) {
              setState(() {
                check1 = value;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            value: check2,
            style: widget.isGlassMode
                ? const NeumorphicCheckboxStyle(
                    selectedColor: Colors.white,
                  )
                : const NeumorphicCheckboxStyle(),
            onChanged: (value) {
              setState(() {
                check2 = value;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            value: check3,
            style: widget.isGlassMode
                ? const NeumorphicCheckboxStyle(
                    selectedColor: Colors.white,
                  )
                : const NeumorphicCheckboxStyle(),
            onChanged: (value) {
              setState(() {
                check3 = value;
              });
            },
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
  Color customColor = Colors.green;

  bool checkColor1 = false;
  bool checkColor2 = false;
  bool checkColor3 = false;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Colorizable",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ColorSelector(
            color: customColor,
            onColorChanged: (color) {
              setState(() {
                customColor = color;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicCheckboxStyle(
              selectedColor: widget.isGlassMode
                  ? customColor.withValues(alpha: 0.5)
                  : customColor,
            ),
            value: checkColor1,
            onChanged: (value) {
              setState(() {
                checkColor1 = value;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicCheckboxStyle(
              selectedColor: widget.isGlassMode
                  ? customColor.withValues(alpha: 0.5)
                  : customColor,
            ),
            value: checkColor2,
            onChanged: (value) {
              setState(() {
                checkColor2 = value;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            value: checkColor3,
            style: NeumorphicCheckboxStyle(
              selectedColor: widget.isGlassMode
                  ? customColor.withValues(alpha: 0.5)
                  : customColor,
            ),
            onChanged: (value) {
              setState(() {
                checkColor3 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
    isGlassMode: ${widget.isGlassMode ? true : false},
    value: isChecked,
    style: NeumorphicCheckboxStyle(
        selectedColor: Colors.green,
    ),
    onChanged: (value) {
        setState(() {
          isChecked = value;
        });
    },
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

class _EnabledDisabledWidget extends StatefulWidget {
  final bool isGlassMode;

  const _EnabledDisabledWidget({this.isGlassMode = false});

  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  bool check1 = false;
  bool check2 = false;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Enabled",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            value: check1,
            style: widget.isGlassMode
                ? const NeumorphicCheckboxStyle(selectedColor: Colors.white)
                : const NeumorphicCheckboxStyle(),
            onChanged: (value) {
              setState(() {
                check1 = value;
              });
            },
          ),
          const SizedBox(width: 24),
          Text(
            "Disabled",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicCheckbox(
            isGlassMode: widget.isGlassMode,
            isEnabled: false,
            value: check2,
            style: widget.isGlassMode
                ? NeumorphicCheckboxStyle(
                    selectedColor: Colors.white.withValues(alpha: 0.5),
                  )
                : const NeumorphicCheckboxStyle(),
            onChanged: (value) {
              setState(() {
                check2 = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
    
bool isChecked = false;  

NeumorphicCheckbox(
     isGlassMode: ${widget.isGlassMode ? true : false},
     isEnabled: false,
     value: isChecked,
     onChanged: (value) {
       setState(() {
         isChecked = value;
       });
     },
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
