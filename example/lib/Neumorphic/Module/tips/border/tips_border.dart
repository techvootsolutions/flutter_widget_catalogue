import 'package:example/Neumorphic/Module/code.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class TipsBorderPage extends StatefulWidget {
  const TipsBorderPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<TipsBorderPage> {
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
          title: "Border",
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
                  _CustomWidget(
                    title: "Emboss Inside Flat",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: 8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                  ),
                  _CustomWidget(
                    title: "Emboss Inside Convex",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      depth: 8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                  ),
                  _CustomWidget(
                    title: "Emboss Inside Concave",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      depth: 8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                  ),
                  _CustomWidget(
                    title: "Flat Inside Emboss",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.flat,
                    ),
                  ),
                  _CustomWidget(
                    title: "Convex Inside Emboss",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.convex,
                    ),
                  ),
                  _CustomWidget(
                    title: "Concave Inside Emboss",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      depth: -8,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.concave,
                    ),
                  ),
                  _CustomWidget(
                    title: "Concave Inside Convex",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.convex,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.concave,
                    ),
                  ),
                  _CustomWidget(
                    title: "Convex Inside Concave",
                    isGlassMode: widget.isGlassMode,
                    firstStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.concave,
                    ),
                    secondStyle: const NeumorphicStyle(
                      depth: 8,
                      shape: NeumorphicShape.convex,
                    ),
                  ),
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

class _CustomWidget extends StatefulWidget {
  final String? title;
  final bool isGlassMode;

  final NeumorphicStyle? firstStyle;
  final NeumorphicStyle? secondStyle;

  const _CustomWidget({
    required this.title,
    required this.firstStyle,
    required this.secondStyle,
    this.isGlassMode = false,
  });

  @override
  createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<_CustomWidget> {
  String _describe(NeumorphicStyle style) {
    return "NeumorphicStyle(depth: ${style.depth}, oppositeShadowLightSource: ${style.oppositeShadowLightSource}, ...)";
  }

  Widget _buildCode(BuildContext context) {
    return Code("""
Neumorphic(
      padding: EdgeInsets.all(20),
      boxShape: NeumorphicBoxShape.circle(),
      style: ${_describe(widget.firstStyle!)},
      child: Neumorphic(
          boxShape: NeumorphicBoxShape.circle(),
          style: ${_describe(widget.secondStyle!)},
          child: SizedBox(
            height: 100,
            width: 100,
          ),
      ),
    ),
""");
  }

  Widget _buildWidget(BuildContext context) {
    final double themeDepth = NeumorphicTheme.depth(context) ?? 4;
    final double themeIntensity = NeumorphicTheme.intensity(context) ?? 0.5;

    NeumorphicStyle getStyle(NeumorphicStyle baseStyle) {
      if (widget.isGlassMode) {
        return baseStyle.copyWith(
          shape: NeumorphicShape.concave,
          surfaceIntensity: 0.5,
          intensity: themeIntensity,
          depth: themeDepth * (baseStyle.depth! > 0 ? 1 : -1),
          color: Colors.white.withValues(alpha: 0.1),
          border: NeumorphicBorder(
            isEnabled: true,
            color: Colors.white.withValues(alpha: 0.2),
            width: 0.5,
          ),
        );
      } else {
        return baseStyle.copyWith(
          depth: themeDepth * (baseStyle.depth! > 0 ? 1 : -1),
          intensity: themeIntensity,
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                width: 100,
                child: Text(
                  widget.title!,
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                padding: const EdgeInsets.all(20),
                style: getStyle(widget.firstStyle!).copyWith(
                  boxShape: const NeumorphicBoxShape.circle(),
                ),
                child: Neumorphic(
                  isGlassMode: widget.isGlassMode,
                  style: getStyle(widget.secondStyle!).copyWith(
                    boxShape: const NeumorphicBoxShape.circle(),
                  ),
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),
                width: 100,
                child: Text(
                  "opposite\nchild\nlightsource",
                  style: TextStyle(
                      color: NeumorphicTheme.defaultTextColor(context)),
                ),
              ),
              Neumorphic(
                isGlassMode: widget.isGlassMode,
                padding: const EdgeInsets.all(20),
                style: getStyle(widget.firstStyle!).copyWith(
                  boxShape: const NeumorphicBoxShape.circle(),
                ),
                child: Neumorphic(
                  isGlassMode: widget.isGlassMode,
                  style: getStyle(widget.secondStyle!).copyWith(
                    boxShape: const NeumorphicBoxShape.circle(),
                    oppositeShadowLightSource: true,
                  ),
                  child: const SizedBox(
                    height: 100,
                    width: 100,
                  ),
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
