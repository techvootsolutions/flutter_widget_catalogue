import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class SwitchWidgetPage extends StatefulWidget {
  const SwitchWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<SwitchWidgetPage> {
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
          child: Scaffold(
            appBar: const TopBar(
              title: "Switch",
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
                      _ColorizableWidget(isGlassMode: isGlassMode),
                      ColorizableThumbSwitch(isGlassMode: isGlassMode),
                      _FlatConcaveConvexWidget(isGlassMode: isGlassMode),
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
  bool isChecked = false;
  bool isEnabled = true;

  Widget _buildCode(BuildContext context) {
    return const Code("""
bool isChecked;

NeumorphicSwitch(
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
          NeumorphicSwitch(
            isGlassMode: widget.isGlassMode,
            isEnabled: isEnabled,
            value: isChecked,
            style: widget.isGlassMode
                ? NeumorphicSwitchStyle(
                    thumbShape: NeumorphicShape.concave,
                    activeTrackColor: Colors.white.withValues(alpha: 0.1),
                  )
                : const NeumorphicSwitchStyle(),
            onChanged: (value) {
              setState(() {
                isChecked = value;
              });
            },
          ),
          const SizedBox(width: 12),
          TextButton(
              onPressed: () {
                setState(() {
                  isEnabled = !isEnabled;
                });
              },
              child: Text(isEnabled ? 'Disable' : 'Enable'))
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

class _FlatConcaveConvexWidget extends StatefulWidget {
  final bool isGlassMode;

  const _FlatConcaveConvexWidget({this.isGlassMode = false});

  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  Widget _buildCode(BuildContext context) {
    return const Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
         thumbShape: NeumorphicShape.flat 
         //or convex, concave
    ),
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
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Flat",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              NeumorphicSwitch(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.flat,
                  activeTrackColor: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Concave",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              NeumorphicSwitch(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.concave,
                  activeTrackColor: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Convex",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              NeumorphicSwitch(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.convex,
                  activeTrackColor: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                ),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value;
                  });
                },
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

class _ColorizableWidget extends StatefulWidget {
  final bool isGlassMode;

  const _ColorizableWidget({this.isGlassMode = false});

  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  bool isChecked = false;
  Color currentColor = Colors.green;

  Widget _buildCode(BuildContext context) {
    return const Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
        activeTrackColor: Colors.green
    ),
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
            "Color",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ColorSelector(
            color: currentColor,
            onColorChanged: (color) {
              setState(() {
                currentColor = color;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicSwitch(
            isGlassMode: widget.isGlassMode,
            value: isChecked,
            style: NeumorphicSwitchStyle(
              activeTrackColor: widget.isGlassMode
                  ? currentColor.withValues(alpha: 0.3)
                  : currentColor,
              thumbShape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value;
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

class ColorizableThumbSwitch extends StatefulWidget {
  final bool isGlassMode;

  const ColorizableThumbSwitch({super.key, this.isGlassMode = false});

  @override
  createState() => _ColorizableThumbSwitchState();
}

class _ColorizableThumbSwitchState extends State<ColorizableThumbSwitch> {
  bool isChecked = false;
  Color thumbColor = Colors.purple;
  Color trackColor = Colors.lightGreen;

  Widget _buildCode(BuildContext context) {
    return const Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    style: NeumorphicSwitchStyle(
          activeTrackColor: Colors.lightGreen,
          activeThumbColor: Colors.purple
    ),
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
            "Track",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ColorSelector(
            color: trackColor,
            onColorChanged: (color) {
              setState(() {
                trackColor = color;
              });
            },
          ),
          const SizedBox(width: 12),
          Text(
            "Thumb",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          ColorSelector(
            color: thumbColor,
            onColorChanged: (color) {
              setState(() {
                thumbColor = color;
              });
            },
          ),
          const SizedBox(width: 12),
          NeumorphicSwitch(
            isGlassMode: widget.isGlassMode,
            value: isChecked,
            style: NeumorphicSwitchStyle(
              activeTrackColor: widget.isGlassMode
                  ? trackColor.withValues(alpha: 0.3)
                  : trackColor,
              activeThumbColor: widget.isGlassMode
                  ? thumbColor.withValues(alpha: 0.8)
                  : thumbColor,
              thumbShape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value;
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

class _EnabledDisabledWidget extends StatefulWidget {
  final bool isGlassMode;

  const _EnabledDisabledWidget({this.isGlassMode = false});

  @override
  createState() => _EnabledDisabledWidgetState();
}

class _EnabledDisabledWidgetState extends State<_EnabledDisabledWidget> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  Widget _buildCode(BuildContext context) {
    return const Code("""
bool isChecked;

NeumorphicSwitch(
    value: isChecked,
    isEnabled: false,
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
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Enabled",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              NeumorphicSwitch(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.concave,
                  activeTrackColor: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                ),
                value: isChecked1,
                onChanged: (value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  "Disabled",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              NeumorphicSwitch(
                isGlassMode: widget.isGlassMode,
                isEnabled: false,
                style: NeumorphicSwitchStyle(
                  thumbShape: NeumorphicShape.convex,
                  activeTrackColor: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.05)
                      : null,
                ),
                value: isChecked2,
                onChanged: (value) {
                  setState(() {
                    isChecked2 = value;
                  });
                },
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
