import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

import 'color_selector.dart';

class ThemeColorSelector extends StatefulWidget {
  final BuildContext? customContext;

  const ThemeColorSelector({super.key, this.customContext});

  @override
  ThemeColorSelectorState createState() => ThemeColorSelectorState();
}

class ThemeColorSelectorState extends State<ThemeColorSelector> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: GlassModeManager.instance.isGlassMode,
      builder: (context, isGlassMode, _) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                'Base Color',
                style: TextStyle(
                  color: isGlassMode
                      ? Colors.white70
                      : NeumorphicTheme.defaultTextColor(context),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.1),
                  // borderRadius: BorderRadius.circular(8),
                ),
                child: ColorSelector(
                  color: NeumorphicTheme.baseColor(
                      widget.customContext ?? context),
                  onColorChanged: (color) {
                    setState(() {
                      NeumorphicTheme.update(
                        widget.customContext ?? context,
                        (current) => current!.copyWith(baseColor: color),
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LiquidGlassDialog extends StatelessWidget {
  final String title;
  final double height;
  final Widget child;

  const LiquidGlassDialog({
    super.key,
    required this.title,
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            // ① Blurred background (frosted glass)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.01),
                ),
              ),
            ),

            // ② Animated liquid background
            SizedBox(
              height: height,
              width: double.infinity,
              child: const LiquidBackground(),
            ),

            // ③ Dark tint overlay — like iOS frosted panel
            Container(
              height: height,
              decoration: BoxDecoration(
                // Subtle gradient for depth (top lighter → bottom darker)
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.35),
                  ],
                ),
                // White border glow — key iOS glass detail
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.18),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withValues(alpha: 0.92),
                          letterSpacing: -0.3,
                        ),
                      ),
                      GlassIconButton(
                        icon: Icons.close_rounded,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Subtle divider
                  Container(
                    height: 0.5,
                    color: Colors.white.withValues(alpha: 0.2),
                    margin: const EdgeInsets.only(bottom: 16),
                  ),

                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Glass-style close / action button (circular frosted)
class GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const GlassIconButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: Icon(icon, color: Colors.white70, size: 18),
          ),
        ),
      ),
    );
  }
}

/// iOS-style slider row with label + value, glass-aware
class LiquidSliderRow extends StatelessWidget {
  final String label;
  final double value;
  final String displayValue;
  final double min;
  final double max;
  final bool isGlassMode;
  final ValueChanged<double> onChanged;

  const LiquidSliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.displayValue,
    required this.min,
    required this.max,
    required this.isGlassMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: isGlassMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withValues(alpha: 0.07),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isGlassMode
                      ? Colors.white70
                      : NeumorphicTheme.defaultTextColor(context),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              Text(
                displayValue,
                style: TextStyle(
                  color: isGlassMode
                      ? Colors.white
                      : NeumorphicTheme.defaultTextColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          NeumorphicSlider(
            isGlassMode: isGlassMode,
            min: min,
            max: max,
            value: value,
            style: isGlassMode
                ? SliderStyle(
                    accent: Colors.white.withValues(alpha: 0.9),
                    variant: Colors.white.withValues(alpha: 0.25),
                  )
                : const SliderStyle(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

/// iOS-style toggle row (label + switch), glass-aware
class GlassControlRow extends StatelessWidget {
  final String label;
  final bool isGlassMode;
  final bool value;
  final ValueChanged<bool> onChanged;

  const GlassControlRow({
    super.key,
    required this.label,
    required this.isGlassMode,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: isGlassMode
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withValues(alpha: 0.07),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.12),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isGlassMode
                  ? Colors.white70
                  : NeumorphicTheme.defaultTextColor(context),
              fontSize: 13,
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: GlassModeManager.instance.isGlassMode,
            builder: (context, glassMode, _) {
              return NeumorphicSwitch(
                height: 24,
                isGlassMode: glassMode,
                value: glassMode,
                onChanged: onChanged,
              );
            },
          ),
        ],
      ),
    );
  }
}
