import 'package:example/Neumorphic/Module/code.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class TipsRecursiveeEmbossPage extends StatefulWidget {
  const TipsRecursiveeEmbossPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<TipsRecursiveeEmbossPage> {
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
            intensity: 0.6,
          ),
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
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: const TopBar(
          title: "Emboss Recursive",
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
                  _EmbossmbossWidget(isGlassMode: widget.isGlassMode),
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

class _EmbossmbossWidget extends StatefulWidget {
  final bool isGlassMode;

  const _EmbossmbossWidget({this.isGlassMode = false});

  @override
  createState() => _EmbossmbossWidgetState();
}

class _EmbossmbossWidgetState extends State<_EmbossmbossWidget> {
  Widget _buildCode(BuildContext context) {
    return const Code("""
 Widget _generateEmbosss({int number, Widget child, bool reverseEachPair = false}) {
    Widget element = child;
    for (int i = 0; i < number; ++i) {
      element = Neumorphic(
        padding: EdgeInsets.all(20),
        boxShape: NeumorphicBoxShape.circle(),
        style: NeumorphicStyle(
          depth: -(NeumorphicTheme.depth(context).abs()), //force negative
          oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
        ),
        child: element,
      );
    }
    return element;
  }
""");
  }

  Widget _generateEmbosss(
      {int? number, Widget? child, bool reverseEachPair = false}) {
    Widget element = child!;
    final double themeDepth = NeumorphicTheme.depth(context) ?? 4;
    final double themeIntensity = NeumorphicTheme.intensity(context) ?? 0.5;

    for (int i = 0; i < number!; ++i) {
      element = Neumorphic(
        isGlassMode: widget.isGlassMode,
        padding: const EdgeInsets.all(20),
        style: widget.isGlassMode
            ? NeumorphicStyle(
                boxShape: const NeumorphicBoxShape.circle(),
                shape: NeumorphicShape.concave,
                surfaceIntensity: 0.5,
                intensity: themeIntensity,
                depth: -(themeDepth.abs()), //force negative
                color: Colors.white.withValues(alpha: 0.05),
                border: NeumorphicBorder(
                  isEnabled: true,
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 0.5,
                ),
                oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
              )
            : NeumorphicStyle(
                boxShape: const NeumorphicBoxShape.circle(),
                intensity: themeIntensity,
                depth: -(themeDepth.abs()), //force negative
                oppositeShadowLightSource: (reverseEachPair && i % 2 == 0),
              ),
        child: element,
      );
    }
    return element;
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 5,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 5,
                    reverseEachPair: true,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Recursive Emboss",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 4,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    child: Text(
                      "Each pair number\nLightsource is reversed",
                      style: TextStyle(
                          color: NeumorphicTheme.defaultTextColor(context)),
                    ),
                  ),
                  _generateEmbosss(
                    number: 4,
                    reverseEachPair: true,
                    child: const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                  ),
                ],
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
