import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'package:example/Neumorphic/Module/theme_configurator.dart';
import 'package:example/Neumorphic/Module/top_bar.dart';
import 'package:example/Neumorphic/Module/code.dart';

class ToggleWidgetPage extends StatefulWidget {
  const ToggleWidgetPage({super.key});

  @override
  createState() => _WidgetPageState();
}

class _WidgetPageState extends State<ToggleWidgetPage> {
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
      isGlassMode: widget.isGlassMode,
      child: Scaffold(
        appBar: const TopBar(
          title: "Toggle",
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
                  _PremiumWidget(isGlassMode: widget.isGlassMode),
                  _SmallWidget(isGlassMode: widget.isGlassMode),
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
  int _selectedIndex = 0;

  Widget _buildCode(BuildContext context) {
    return Code("""
Expanded(
  child: NeumorphicToggle(
    height: 50,
    selectedIndex: _selectedIndex,
    displayForegroundOnlyIfSelected: true,
    children: [
      ToggleElement(
        background: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This week", style: TextStyle(fontWeight: FontWeight.w700),)),
      ),
      ToggleElement(
        background: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This month", style: TextStyle(fontWeight: FontWeight.w700),)),
      ),
      ToggleElement(
        background: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w500),)),
        foreground: Center(child: Text("This year", style: TextStyle(fontWeight: FontWeight.w700),)),
      )
    ],
    thumb: Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    onChanged: (value) {
      setState(() {
        _selectedIndex = value;
        print("_firstSelected: $_selectedIndex");
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
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Default",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NeumorphicToggle(
              isGlassMode: widget.isGlassMode,
              height: 50,
              selectedIndex: _selectedIndex,
              displayForegroundOnlyIfSelected: true,
              children: [
                ToggleElement(
                  background: const Center(
                      child: Text(
                    "This week",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: const Center(
                      child: Text(
                    "This week",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                ToggleElement(
                  background: const Center(
                      child: Text(
                    "This month",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: const Center(
                      child: Text(
                    "This month",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                ),
                ToggleElement(
                  background: const Center(
                      child: Text(
                    "This year",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  foreground: const Center(
                      child: Text(
                    "This year",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  )),
                )
              ],
              thumb: Neumorphic(
                isGlassMode: widget.isGlassMode,
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                      const BorderRadius.all(Radius.circular(12))),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
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

class _SmallWidget extends StatefulWidget {
  final bool isGlassMode;
  const _SmallWidget({this.isGlassMode = false});

  @override
  createState() => _SmallWidgetState();
}

class _SmallWidgetState extends State<_SmallWidget> {
  int _selectedIndex = 1;
  Widget _buildCode(BuildContext context) {
    return Code("""
NeumorphicToggle(
  height: 45,
  width: 100,
  selectedIndex: _selectedIndex,
  children: [
    ToggleElement(
      background: Center(child: Icon(Icons.arrow_back, color: Colors.grey[800],)),
    ),
    ToggleElement(),
  ],
  thumb: Neumorphic(
    boxShape: NeumorphicBoxShape.roundRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    child: Icon(Icons.blur_on, color: Colors.grey,),
  ),
  onAnimationChangedFinished: (value){
    if(value == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('on back !')));
      print("onAnimationChangedFinished: $_selectedIndex");
    }
  },
  onChanged: (value) {
    setState(() {
      _selectedIndex = value;
      print("_firstSelected: $_selectedIndex");
    });
  },
),
""");
  }

  Widget _buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Small",
            style: TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
          ),
          const SizedBox(width: 12),
          NeumorphicToggle(
            isGlassMode: widget.isGlassMode,
            height: 45,
            width: 100,
            selectedIndex: _selectedIndex,
            children: [
              ToggleElement(
                background: Center(
                    child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[800],
                )),
              ),
              ToggleElement(),
            ],
            thumb: Neumorphic(
              isGlassMode: widget.isGlassMode,
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  const BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: const Icon(
                Icons.blur_on,
                color: Colors.grey,
              ),
            ),
            onAnimationChangedFinished: (value) {
              if (value == 0) {}
            },
            onChanged: (value) {
              setState(() {
                _selectedIndex = value;
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

// The instruction implies that the global GlassWrap is now imported and used.

class _PremiumWidget extends StatefulWidget {
  final bool isGlassMode;
  const _PremiumWidget({this.isGlassMode = false});

  @override
  createState() => _PremiumWidgetState();
}

class _PremiumWidgetState extends State<_PremiumWidget> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Icon Mode",
            style: TextStyle(
                color: NeumorphicTheme.defaultTextColor(context),
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: NeumorphicToggle(
                  isGlassMode: widget.isGlassMode,
                  height: 60,
                  selectedIndex: _selectedIndex,
                  displayForegroundOnlyIfSelected: true,
                  style: NeumorphicToggleStyle(
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: widget.isGlassMode
                        ? Colors.white.withValues(alpha: 0.05)
                        : null,
                    border: widget.isGlassMode
                        ? NeumorphicBorder(
                            isEnabled: true,
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          )
                        : const NeumorphicBorder.none(),
                  ),
                  children: [
                    ToggleElement(
                      background: const Center(
                          child: Icon(Icons.wb_sunny_outlined, size: 20)),
                      foreground: const Center(
                          child: Icon(Icons.wb_sunny,
                              color: Colors.orange, size: 24)),
                    ),
                    ToggleElement(
                      background: const Center(
                          child:
                              Icon(Icons.nightlight_round_outlined, size: 20)),
                      foreground: const Center(
                          child: Icon(Icons.nightlight_round,
                              color: Colors.blueAccent, size: 24)),
                    ),
                    ToggleElement(
                      background: const Center(
                          child: Icon(Icons.auto_awesome_outlined, size: 20)),
                      foreground: const Center(
                          child: Icon(Icons.auto_awesome,
                              color: Colors.purpleAccent, size: 24)),
                    )
                  ],
                  thumb: Neumorphic(
                    isGlassMode: widget.isGlassMode,
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15)),
                      shape: NeumorphicShape.concave,
                      depth: widget.isGlassMode ? 10 : 4,
                      intensity: 1.0,
                      color: widget.isGlassMode
                          ? Colors.white.withValues(alpha: 0.15)
                          : null,
                      border: widget.isGlassMode
                          ? NeumorphicBorder(
                              isEnabled: true,
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            )
                          : const NeumorphicBorder.none(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedIndex = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Code("""
NeumorphicToggle(
  isGlassMode: true,
  height: 60,
  style: NeumorphicToggleStyle(
    borderRadius: BorderRadius.circular(20),
    backgroundColor: Colors.white.withValues(alpha: 0.05),
  ),
  thumb: Neumorphic(
     isGlassMode: true,
     style: NeumorphicStyle(
       color: Colors.white.withValues(alpha: 0.15),
       border: NeumorphicBorder(isEnabled: true, color: Colors.white.withValues(alpha: 0.4)),
     ),
  ),
  ...
)
"""),
        ],
      ),
    );
  }
}
