import 'package:example/Neumorphic/Module/code.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class ContainerWidgetPage extends StatefulWidget {
  const ContainerWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ContainerWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      themeMode: ThemeMode.light,
      theme: const NeumorphicThemeData(
        lightSource: LightSource.topLeft,
        accentColor: NeumorphicColors.accent,
        depth: 8,
        intensity: 0.5,
      ),
      child: _Page(),
    );
  }
}

class _Page extends StatefulWidget {
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
        backgroundColor: NeumorphicColors.neumorphicScreenBg,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _DefaultWidget(),
              _CircleWidget(),
              _RoundRectWidget(),
              _ColorizableWidget(),
              _FlatConcaveConvexWidget(),
              _EmbossWidget(),
              _DrawAboveWidget(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatefulWidget {
  @override
  createState() => _DefaultWidgetState();
}

class _DefaultWidgetState extends State<_DefaultWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    child: SizedBox(
        height: 100,
        width: 100,
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
          const Neumorphic(
            child: SizedBox(
              height: 100,
              width: 100,
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
  @override
  createState() => _CircleWidgetState();
}

class _CircleWidgetState extends State<_CircleWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
     boxShape: NeumorphicBoxShape.circle(),
     padding: EdgeInsets.all(18.0),
     child: Icon(Icons.map),
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
          const Neumorphic(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: EdgeInsets.all(18.0),
            child: Icon(Icons.map),
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
  @override
  createState() => _RoundRectWidgetState();
}

class _RoundRectWidgetState extends State<_RoundRectWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    style: NeumorphicStyle(
         boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
    ),
    padding: EdgeInsets.all(18.0),
    child: Icon(Icons.map),
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
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
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
  @override
  createState() => _ColorizableWidgetState();
}

class _ColorizableWidgetState extends State<_ColorizableWidget> {
  Color currentColor = Colors.white;

  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    style: NeumorphicStyle(
        color: Colors.white,
        boxShape: NeumorphicBoxShape.circle()
    ),
    child: SizedBox(
      height: 100, 
      width: 100,
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
            style: NeumorphicStyle(
                color: currentColor,
                boxShape: const NeumorphicBoxShape.circle()),
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
  @override
  createState() => _FlatConcaveConvexWidgetState();
}

class _FlatConcaveConvexWidgetState extends State<_FlatConcaveConvexWidget> {
  bool isChecked = false;

  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    style: NeumorphicStyle(
         shape: NeumorphicShape.flat 
         //or convex, concave
    ),
    
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
              const Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
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
              const Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
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
              const NeumorphicButton(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.circle()),
                padding: EdgeInsets.all(18.0),
                child: Icon(Icons.play_arrow),
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
  @override
  createState() => _EmbossWidgetState();
}

class _EmbossWidgetState extends State<_EmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
Neumorphic(
    child: Icon(Icons.play_arrow),
    style: NeumorphicStyle(
      depth: -10.0,
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
              const Neumorphic(
                padding: EdgeInsets.all(18),
                style: NeumorphicStyle(
                  depth: -10.0,
                ),
                child: Icon(Icons.play_arrow),
              ),
              const SizedBox(width: 12),
              const Neumorphic(
                padding: EdgeInsets.all(18),
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: -10.0,
                ),
                child: Icon(Icons.play_arrow),
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
      drawSurfaceAboveChild: drawSurfaceAboveChild,
      margin: const EdgeInsets.all(8),
      style: NeumorphicStyle(
        surfaceIntensity: 1,
        intensity: isConvex ? 1 : null,
        shape: shape,
        boxShape: isCircle ? const NeumorphicBoxShape.circle() : null,
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
