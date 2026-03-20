import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/color_selector.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class SliderWidgetPage extends StatefulWidget {
  const SliderWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<SliderWidgetPage> {
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
          isGlassMode: isGlassMode,
          child: Scaffold(
            appBar: const TopBar(
              title: "Slider",
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
                      _ThumbIconWidget(isGlassMode: isGlassMode),
                      _FeedbackWidget(isGlassMode: isGlassMode),
                      _MoodFeedbackWidget(isGlassMode: isGlassMode),
                      _ColorWidget(isGlassMode: isGlassMode),
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
  double age = 20;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double age = 20;  

Expanded(
  child: NeumorphicSlider(
      value: age,
      min: 18,
      max: 90,
      onChanged: (value) {
        setState(() {
          age = value;
        });
      },
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
          Expanded(
            child: NeumorphicSlider(
              isGlassMode: widget.isGlassMode,
              value: age,
              min: 18,
              max: 90,
              style: widget.isGlassMode
                  ? SliderStyle(
                      accent: Colors.white.withValues(alpha: 0.3),
                      variant: Colors.white.withValues(alpha: 0.1),
                    )
                  : const SliderStyle(),
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "${age.round()}",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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
  double age = 50;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double age = 50;  

Expanded(
  child: NeumorphicSlider(
      style: SliderStyle(
           accent: Colors.green,
           variant: Colors.purple,
      ),
      value: age,
      min: 18,
      max: 90,
      onChanged: (value) {
        setState(() {
          age = value;
        });
      },
  ),
),
""");
  }

  Color accent = Colors.green;
  Color variant = Colors.purple;

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              const Text("Accent : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    accent = color;
                  });
                },
                color: accent,
              ),
              const SizedBox(width: 12),
              const Text("Variant : "),
              ColorSelector(
                onColorChanged: (color) {
                  setState(() {
                    variant = color;
                  });
                },
                color: variant,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Text(
                "Default",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NeumorphicSlider(
                  isGlassMode: widget.isGlassMode,
                  style: SliderStyle(
                    accent: widget.isGlassMode
                        ? accent.withValues(alpha: 0.3)
                        : accent,
                    variant: widget.isGlassMode
                        ? variant.withValues(alpha: 0.2)
                        : variant,
                  ),
                  value: age,
                  min: 18,
                  max: 90,
                  onChanged: (value) {
                    setState(() {
                      age = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "${age.round()}",
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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

class _ThumbIconWidget extends StatefulWidget {
  final bool isGlassMode;

  const _ThumbIconWidget({this.isGlassMode = false});

  @override
  createState() => _ThumbIconWidgetState();
}

class _ThumbIconWidgetState extends State<_ThumbIconWidget> {
  double seekValue = 50;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double seekValue = 50;

NeumorphicSlider(
  value: seekValue,
  min: 0,
  max: 100,
  thumb: Neumorphic(
    style: NeumorphicStyle(
      shape: NeumorphicShape.concave,
      boxShape: NeumorphicBoxShape.circle(),
    ),
    child: Icon(
      Icons.star,
      color: Colors.white,
      size: 20,
    ),
  ),
  onChanged: (value) {
    setState(() {
      seekValue = value;
    });
  },
)
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: <Widget>[
          Text(
            "Icon Thumb",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicSlider(
              isGlassMode: widget.isGlassMode,
              value: seekValue,
              min: 0,
              max: 100,
              thumb: Neumorphic(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: const NeumorphicBoxShape.circle(),
                  color: widget.isGlassMode
                      ? Colors.white.withValues(alpha: 0.2)
                      : null,
                ),
                child: const SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  seekValue = value;
                });
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            "${seekValue.round()}",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
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

class _FeedbackWidget extends StatefulWidget {
  final bool isGlassMode;

  const _FeedbackWidget({this.isGlassMode = false});

  @override
  createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<_FeedbackWidget> {
  double value = 5;

  Widget _buildCode(BuildContext context) {
    return const Code("""
double value = 5;

NeumorphicSlider(
  value: value,
  min: 1,
  max: 10,
  height: 20,
  style: SliderStyle(
    colors: [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.lightGreen,
      Colors.green,
    ],
  ),
  onChanged: (newValue) {
    setState(() {
      value = newValue;
    });
  },
)
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Feedback Scale (1-10)",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: NeumorphicSlider(
                  isGlassMode: widget.isGlassMode,
                  value: value,
                  min: 1,
                  max: 10,
                  height: 25,
                  style: SliderStyle(
                    borderRadius: BorderRadius.circular(15),
                    colors: [
                      Colors.red,
                      Colors.orange,
                      Colors.yellow,
                      Colors.lightGreen,
                      Colors.green,
                    ],
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                ),
              ),
              // Labels
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(10, (index) {
                      int val = index + 1;
                      return Text(
                        "$val",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Current Value: ${value.toStringAsFixed(1)}",
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

class _MoodFeedbackWidget extends StatefulWidget {
  final bool isGlassMode;

  const _MoodFeedbackWidget({this.isGlassMode = false});

  @override
  createState() => _MoodFeedbackWidgetState();
}

class _MoodFeedbackWidgetState extends State<_MoodFeedbackWidget> {
  double value = 2;

  final List<Map<String, dynamic>> moods = [
    {
      "label": "Worst",
      "icon": Icons.sentiment_very_dissatisfied,
      "color": Colors.red
    },
    {
      "label": "Poor",
      "icon": Icons.sentiment_dissatisfied,
      "color": Colors.orangeAccent
    },
    {
      "label": "Average",
      "icon": Icons.sentiment_neutral,
      "color": Colors.amber
    },
    {
      "label": "Good",
      "icon": Icons.sentiment_satisfied,
      "color": Colors.lightGreen
    },
    {
      "label": "Excellent",
      "icon": Icons.sentiment_very_satisfied,
      "color": Colors.green
    },
  ];

  Widget _buildCode(BuildContext context) {
    return const Code("""
double value = 2;

Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: moods.map((mood) => Column(
        children: [
          Icon(mood['icon'], color: mood['color'], size: 40),
          Text(mood['label']),
        ],
      )).toList(),
    ),
    NeumorphicSlider(
      value: value,
      min: 0,
      max: 4,
      onChanged: (newValue) {
        setState(() {
          value = newValue;
        });
      },
    ),
  ],
)
""");
  }

  Widget _buildWidget(BuildContext context) {
    int activeIndex = value.round();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Mood Feedback Slider",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(moods.length, (index) {
              bool isActive = index == activeIndex;
              var mood = moods[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    value = index.toDouble();
                  });
                },
                child: AnimatedScale(
                  scale: isActive ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Column(
                    children: [
                      Neumorphic(
                        isGlassMode: widget.isGlassMode,
                        style: NeumorphicStyle(
                          shape: isActive
                              ? NeumorphicShape.concave
                              : NeumorphicShape.flat,
                          boxShape: const NeumorphicBoxShape.circle(),
                          depth: isActive ? 5 : 2,
                          color: isActive
                              ? mood['color']
                              : (widget.isGlassMode
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : null),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            mood['icon'],
                            color: isActive ? Colors.white : mood['color'],
                            size: 35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mood['label'],
                        style: TextStyle(
                          color: isActive
                              ? mood['color']
                              : NeumorphicTheme.defaultTextColor(context)
                                  .withValues(alpha: 0.6),
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NeumorphicSlider(
              isGlassMode: widget.isGlassMode,
              value: value,
              min: 0,
              max: 4,
              height: 15,
              style: SliderStyle(
                colors: [
                  Colors.red,
                  Colors.orange,
                  Colors.amber,
                  Colors.lightGreen,
                  Colors.green,
                ],
              ),
              thumb: Neumorphic(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: const NeumorphicBoxShape.circle(),
                  color: moods[activeIndex]['color'],
                ),
                child: const SizedBox(
                  height: 30,
                  width: 30,
                ),
              ),
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
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
