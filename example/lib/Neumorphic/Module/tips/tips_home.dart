import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';

import 'border/tips_border.dart';
import 'border/tips_emboss_inside_emboss.dart';

class TipsHome extends StatelessWidget {
  const TipsHome({super.key});

  Widget _buildButton({
    String? text,
    VoidCallback? onClick,
    bool isGlassMode = false,
  }) {
    return NeumorphicButton(
      isGlassMode: isGlassMode,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: isGlassMode
          ? NeumorphicStyle(
              shape: NeumorphicShape.concave,
              surfaceIntensity: 0.5,
              color: Colors.white.withValues(alpha: 0.1),
              border: NeumorphicBorder(
                isEnabled: true,
                color: Colors.white.withValues(alpha: 0.2),
                width: 0.5,
              ),
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12),
              ),
            )
          : NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(12),
              ),
            ),
      onPressed: onClick,
      child: Center(
        child: Text(
          text!,
          style: isGlassMode ? const TextStyle(color: Colors.white) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (context, isGlassMode, _) {
        return NeumorphicTheme(
          themeMode: isGlassMode ? ThemeMode.dark : ThemeMode.light,
          theme: const NeumorphicThemeData(depth: 8),
          child: NeumorphicBackground(
            child: Scaffold(
              backgroundColor: isGlassMode
                  ? Colors.transparent
                  : NeumorphicColors.neumorphicScreenBg,
              body: Stack(
                children: [
                  if (isGlassMode)
                    const Positioned.fill(
                      child: LiquidBackground(),
                    ),
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const TopBar(
                              title: "Tips",
                              actions: <Widget>[
                                ThemeConfigurator(),
                              ],
                            ),
                            const SizedBox(height: 40),
                            _buildButton(
                                text: "Border",
                                isGlassMode: isGlassMode,
                                onClick: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const TipsBorderPage();
                                  }));
                                }),
                            const SizedBox(height: 20),
                            _buildButton(
                                text: "Recursive Emboss",
                                isGlassMode: isGlassMode,
                                onClick: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return const TipsRecursiveeEmbossPage();
                                  }));
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
