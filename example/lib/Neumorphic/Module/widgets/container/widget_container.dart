import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/code.dart';

class ContainerWidgetPage extends StatefulWidget {
  const ContainerWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ContainerWidgetPage> {
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
            depth: depth,
            intensity: intensity,
          ),
          child: _Page(isGlassMode: isGlassMode),
        );
      },
    );
  }

  static const double depth = 4;
  static const double intensity = 0.5;
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
          title: "Container",
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ThemeConfigurator(),
            ),
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
                  _RoundRectWidget(isGlassMode: widget.isGlassMode),
                  _ColorizableWidget(isGlassMode: widget.isGlassMode),
                  _FlatConcaveConvexWidget(isGlassMode: widget.isGlassMode),
                  _EmbossWidget(isGlassMode: widget.isGlassMode),
                  _DrawAboveWidget(isGlassMode: widget.isGlassMode),
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
    return const Code("""
GlassWrap(
    isGlassMode: isGlassMode,
    child: Neumorphic(
        child: SizedBox(
            height: 100,
            width: 100,
        ),
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
          GlassWrap(
            isGlassMode: widget.isGlassMode,
            child: Neumorphic(
              style: widget.isGlassMode
                  ? NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 8,
                      intensity: 0.9,
                      surfaceIntensity: 0.5,
                      color: Colors.white.withValues(alpha: 0.1),
                      border: NeumorphicBorder(
                        isEnabled: true,
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      ),
                    )
                  : const NeumorphicStyle(),
              child: const SizedBox(
                height: 100,
                width: 100,
              ),
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
    return const Code("""
GlassWrap(
    isGlassMode: isGlassMode,
    isCircle: true,
    child: Neumorphic(
        boxShape: NeumorphicBoxShape.circle(),
        padding: EdgeInsets.all(18.0),
        child: Icon(Icons.map),
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
          Neumorphic(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicStyle(
              boxShape: const NeumorphicBoxShape.circle(),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              depth: widget.isGlassMode ? 8 : 4.0,
              intensity: widget.isGlassMode ? 0.9 : 0.5,
              surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
              color: widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
              border: widget.isGlassMode
                  ? NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : const NeumorphicBorder.none(),
            ),
            padding: const EdgeInsets.all(18.0),
            child: const Icon(Icons.map),
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

class _RoundRectWidget extends StatefulWidget {
  final bool isGlassMode;

  const _RoundRectWidget({this.isGlassMode = false});

  @override
  createState() => _RoundRectWidgetState();
}

class _RoundRectWidgetState extends State<_RoundRectWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
GlassWrap(
    isGlassMode: isGlassMode,
    borderRadius: BorderRadius.circular(8),
    child: Neumorphic(
        style: NeumorphicStyle(
             boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        ),
        padding: EdgeInsets.all(18.0),
        child: Icon(Icons.map),
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
            "RoundRect",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Neumorphic(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
              shape: widget.isGlassMode
                  ? NeumorphicShape.concave
                  : NeumorphicShape.flat,
              depth: widget.isGlassMode ? 8 : 4.0,
              intensity: widget.isGlassMode ? 0.9 : 0.5,
              surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
              color: widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
              border: widget.isGlassMode
                  ? NeumorphicBorder(
                      isEnabled: true,
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.5,
                    )
                  : const NeumorphicBorder.none(),
            ),
            padding: const EdgeInsets.all(18.0),
            child: const Icon(Icons.map),
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
  Color currentColor = Colors.white;

  Widget _buildCode(BuildContext context) {
    return const Code("""
GlassWrap(
    isGlassMode: isGlassMode,
    isCircle: true,
    child: Neumorphic(
        style: NeumorphicStyle(
            color: Colors.white,
            boxShape: NeumorphicBoxShape.circle()
        ),
        child: SizedBox(
          height: 100, 
          width: 100,
        ),
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
          Neumorphic(
            isGlassMode: widget.isGlassMode,
            style: NeumorphicStyle(
                color: widget.isGlassMode
                    ? currentColor.withValues(alpha: 0.2)
                    : currentColor,
                boxShape: const NeumorphicBoxShape.circle(),
                shape: widget.isGlassMode
                    ? NeumorphicShape.concave
                    : NeumorphicShape.flat,
                depth: widget.isGlassMode ? 8 : 4.0,
                intensity: widget.isGlassMode ? 0.9 : 0.5,
                surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
                border: widget.isGlassMode
                    ? NeumorphicBorder(
                        isEnabled: true,
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 0.5,
                      )
                    : const NeumorphicBorder.none()),
            child: const SizedBox(
              height: 100,
              width: 100,
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
GlassWrap(
    isGlassMode: isGlassMode,
    isCircle: true,
    child: Neumorphic(
        style: NeumorphicStyle(
             shape: NeumorphicShape.flat 
             //or convex, concave
        ),
        
        child: ...
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
              SizedBox(
                width: 100,
                child: Text(
                  "Flat",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              const SizedBox(width: 12),
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: widget.isGlassMode ? 8 : null,
                  intensity: widget.isGlassMode ? 0.9 : null,
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.25,
                  color:
                      widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : NeumorphicBorder.none(),
                ),
                padding: const EdgeInsets.all(18.0),
                child: const Icon(Icons.play_arrow),
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
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: widget.isGlassMode ? 8 : null,
                  intensity: widget.isGlassMode ? 0.9 : null,
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.25,
                  color:
                      widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : NeumorphicBorder.none(),
                ),
                padding: const EdgeInsets.all(18.0),
                child: const Icon(Icons.play_arrow),
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
                  depth: widget.isGlassMode ? 8 : null,
                  intensity: widget.isGlassMode ? 1.0 : 0.5,
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
                  color:
                      widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : const NeumorphicBorder.none(),
                ),
                padding: const EdgeInsets.all(18.0),
                child: const Icon(Icons.play_arrow),
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

class _EmbossWidget extends StatefulWidget {
  final bool isGlassMode;

  const _EmbossWidget({this.isGlassMode = false});

  @override
  createState() => _EmbossWidgetState();
}

class _EmbossWidgetState extends State<_EmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
GlassWrap(
    isGlassMode: isGlassMode,
    child: Neumorphic(
        child: Icon(Icons.play_arrow),
        style: NeumorphicStyle(
          depth: -10.0,
        ),
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
                "Emboss",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                padding: const EdgeInsets.all(18),
                style: NeumorphicStyle(
                  depth: -10.0,
                  intensity: widget.isGlassMode ? 0.9 : 0.5,
                  surfaceIntensity: widget.isGlassMode ? 0.5 : 0.5,
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.05)
                      : null,
                  border: widget.isGlassMode
                      ? NeumorphicBorder(
                          isEnabled: true,
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        )
                      : const NeumorphicBorder.none(),
                ),
                child: const Icon(Icons.play_arrow),
              ),
              const SizedBox(width: 12),
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                padding: const EdgeInsets.all(18),
                style: NeumorphicStyle(
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: -10.0,
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.05)
                      : null,
                ),
                child: const Icon(Icons.play_arrow),
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

class _DrawAboveWidget extends StatefulWidget {
  final bool isGlassMode;

  const _DrawAboveWidget({this.isGlassMode = false});

  @override
  createState() => _DrawAboveWidgetState();
}

class _DrawAboveWidgetState extends State<_DrawAboveWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    child: ...,
    drawSurfaceAboveChild: true,
    style: NeumorphicStyle(
        surfaceIntensity: 1,
        shape: NeumorphicShape.concave,
    ),
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth > 400;
        final double itemSize =
            isLargeScreen ? 100 : (constraints.maxWidth / 3) - 24;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 12),
              Text(
                "DrawAbove",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(height: 12),

              // Header Row
              Row(
                children: [
                  _buildHeader(itemSize, "false"),
                  _buildHeader(itemSize, "true\n(concave)"),
                  _buildHeader(itemSize, "true\n(convex)"),
                ],
              ),

              // Rectangle image Row
              Row(
                children: <Widget>[
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: false,
                    shape: NeumorphicShape.concave,
                  ),
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: true,
                    shape: NeumorphicShape.concave,
                  ),
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: true,
                    shape: NeumorphicShape.convex,
                    isConvex: true,
                  ),
                ],
              ),

              // Circle image Row
              Row(
                children: <Widget>[
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: false,
                    shape: NeumorphicShape.concave,
                    isCircle: true,
                  ),
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: true,
                    shape: NeumorphicShape.concave,
                    isCircle: true,
                  ),
                  _buildNeumorphicImage(
                    itemSize: itemSize,
                    drawSurfaceAboveChild: true,
                    shape: NeumorphicShape.convex,
                    isCircle: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(double size, String text) {
    return SizedBox(
      width: size,
      child: Center(
        child: Text(text, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildNeumorphicImage({
    required double itemSize,
    required bool drawSurfaceAboveChild,
    required NeumorphicShape shape,
    bool isCircle = false,
    bool isConvex = false,
  }) {
    return Neumorphic(
      isGlassMode: widget.isGlassMode,
      drawSurfaceAboveChild: drawSurfaceAboveChild,
      margin: const EdgeInsets.all(8),
      style: NeumorphicStyle(
        surfaceIntensity: 1,
        intensity: isConvex ? 1 : null,
        shape: shape,
        boxShape: isCircle ? const NeumorphicBoxShape.circle() : null,
        color: widget.isGlassMode ? Colors.white.withValues(alpha: 0.1) : null,
        depth: widget.isGlassMode ? 8 : null,
        border: widget.isGlassMode
            ? NeumorphicBorder(
                isEnabled: true,
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              )
            : const NeumorphicBorder.none(),
      ),
      child: Image.asset(
        "assets/images/weeknd.jpg",
        height: itemSize,
        width: itemSize,
        fit: BoxFit.cover,
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
