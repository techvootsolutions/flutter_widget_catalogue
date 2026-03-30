import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class ButtonWidgetPage extends StatefulWidget {
  const ButtonWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ButtonWidgetPage> {
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

  const _Page({required this.isGlassMode});

  @override
  createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicBackground(
      child: Scaffold(
        appBar: const TopBar(
          title: "Button",
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
                  _CircleWidget(isGlassMode: widget.isGlassMode),
                  _ColorizableWidget(isGlassMode: widget.isGlassMode),
                  _MinDistanceWidget(isGlassMode: widget.isGlassMode),
                  _EnabledDisabledWidget(isGlassMode: widget.isGlassMode),
                  _FlatConcaveConvexWidget(isGlassMode: widget.isGlassMode),
                  _DurationWidget(isGlassMode: widget.isGlassMode),
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
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     isGlassMode: ${widget.isGlassMode ? true : false},
     onPressed: () {
        
     },
     child: Text("Click me"),
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
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            onPressed: () {
              setState(() {});
            },
            style: widget.isGlassMode
                ? NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    surfaceIntensity: 0.5,
                    color: Colors.white.withValues(alpha: 0.1),
                    border: NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    ),
                  )
                : const NeumorphicStyle(),
            child: Text(
              "Click me",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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

class _CircleWidget extends StatefulWidget {
  final bool isGlassMode;

  const _CircleWidget({this.isGlassMode = false});

  @override
  createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<_CircleWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     isGlassMode: ${widget.isGlassMode ? true : false},
     boxShape: NeumorphicBoxShape.circle(),
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
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
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
              color: widget.isGlassMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : null,
              border: widget.isGlassMode
                  ? NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : const NeumorphicBorder.none(),
            ),
            onPressed: () {
              setState(() {});
            },
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.play_arrow,
              color: NeumorphicTheme.defaultTextColor(context),
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

class _MinDistanceWidget extends StatefulWidget {
  final bool isGlassMode;

  const _MinDistanceWidget({this.isGlassMode = false});

  @override
  createState() => _MinDistanceWidgetState();
}

class _MinDistanceWidgetState extends State<_MinDistanceWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     isGlassMode: ${widget.isGlassMode ? true : false},
     boxShape: NeumorphicBoxShape.circle(),
     minDistance: -5.0,
     onPressed: () {
       
     },
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.play_arrow),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "MinDistance -5",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            minDistance: -5.0,
            style: NeumorphicStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
              color: widget.isGlassMode
                  ? Colors.white.withValues(alpha: 0.1)
                  : null,
              border: widget.isGlassMode
                  ? NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : const NeumorphicBorder.none(),
            ),
            onPressed: () {
              setState(() {});
            },
            padding: const EdgeInsets.all(18.0),
            child: Icon(
              Icons.play_arrow,
              color: NeumorphicTheme.defaultTextColor(context),
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

class _ColorizableWidget extends StatefulWidget {
  final bool isGlassMode;

  const _ColorizableWidget({this.isGlassMode = false});

  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  Color currentColor = Colors.green;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    isGlassMode: ${widget.isGlassMode ? true : false},
    onPressed: (){

    },
    style: NeumorphicStyle(
        color: Colors.green
    ),
    child: Text("Click me"),
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
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            onPressed: () {},
            style: NeumorphicStyle(
              color: widget.isGlassMode
                  ? currentColor.withValues(alpha: 0.2)
                  : currentColor,
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              surfaceIntensity: 0.5,
              border: widget.isGlassMode
                  ? NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : const NeumorphicBorder.none(),
            ),
            child: Text(
              "Click me",
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
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            style: widget.isGlassMode
                ? NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    surfaceIntensity: 0.5,
                    color: Colors.white.withValues(alpha: 0.1),
                  )
                : const NeumorphicStyle(),
            child: Text(
              "First",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
            onPressed: () {
              setState(() {});
            },
          ),
          const SizedBox(width: 24),
          Text(
            "Disabled :",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicButton(
            isGlassMode: widget.isGlassMode,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            style: widget.isGlassMode
                ? NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    surfaceIntensity: 0.2,
                    color: Colors.white.withValues(alpha: 0.05),
                  )
                : const NeumorphicStyle(),
            child: Text(
              "Second",
              style:
                  TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
     isGlassMode: ${widget.isGlassMode ? true : false},
     isEnabled: false,
     child: Text("Second"),
     onPressed: () {
       
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

class _DurationWidget extends StatefulWidget {
  final bool isGlassMode;

  const _DurationWidget({this.isGlassMode = false});

  @override
  createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<_DurationWidget> {
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    isGlassMode: ${widget.isGlassMode ? true : false},
    onPressed: (){

    },
    child: Text("Press me all night long"),
    duration: Duration(seconds: 1),
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
              NeumorphicButton(
                isGlassMode: widget.isGlassMode,
                onPressed: () {},
                duration: const Duration(seconds: 1),
                style: widget.isGlassMode
                    ? NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        surfaceIntensity: 0.5,
                        color: Colors.white.withValues(alpha: 0.1),
                      )
                    : const NeumorphicStyle(),
                child: Text(
                  "Press me all night long",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
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

class _FlatConcaveConvexWidget extends StatefulWidget {
  final bool isGlassMode;

  const _FlatConcaveConvexWidget({this.isGlassMode = false});

  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicButton(
    isGlassMode: ${widget.isGlassMode ? true : false},
    style: NeumorphicStyle(
         shape: NeumorphicShape.flat 
         //or convex, concave
    ),
    onPressed: () {
        
    },
    child: ...
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
              NeumorphicButton(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: const NeumorphicBoxShape.circle(),
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : const NeumorphicBorder.none(),
                ),
                onPressed: () {
                  setState(() {});
                },
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  Icons.play_arrow,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
              ),
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
              NeumorphicButton(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: const NeumorphicBoxShape.circle(),
                  surfaceIntensity:
                      (NeumorphicTheme.intensity(context) ?? 0.5) * 0.6,
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : const NeumorphicBorder.none(),
                ),
                onPressed: () {
                  setState(() {});
                },
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  Icons.play_arrow,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
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
              NeumorphicButton(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  boxShape: const NeumorphicBoxShape.circle(),
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.1)
                      : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : const NeumorphicBorder.none(),
                ),
                onPressed: () {
                  setState(() {});
                },
                padding: const EdgeInsets.all(18.0),
                child: Icon(
                  Icons.play_arrow,
                  color: NeumorphicTheme.defaultTextColor(context),
                ),
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
