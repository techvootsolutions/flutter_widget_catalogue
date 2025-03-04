import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';
import 'background/widget_background.dart';
import 'button/widget_button.dart';
import 'container/widget_container.dart';
import 'icon/widget_icon.dart';
import 'indeterminate_progress/widget_indeterminate_progress.dart';
import 'indicator/widget_indicator.dart';
import 'progress/widget_progress.dart';
import 'radiobutton/widget_radio_button.dart';
import 'range_slider/widget_range_slider.dart';
import 'slider/widget_slider.dart';
import 'switch/widget_switch.dart';
import 'toggle/widget_toggle.dart';

class WidgetsHome extends StatelessWidget {
  const WidgetsHome({super.key});

  Widget _buildButton({
    required String text,
    required VoidCallback onClick,
    required IconData icon,
  }) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        depth: 4,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
        color: NeumorphicColors.background,
        shadowLightColor: Colors.white,
        shadowDarkColor: Colors.grey.shade500,
      ),
      onPressed: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blueGrey.shade800, size: 22),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(
        depth: 4,
        baseColor: NeumorphicColors.background,
        lightSource: LightSource.topLeft,
        intensity: 0.8,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade600,
          elevation: 4,
          title: const Text(
            "Neumorphic Widgets",
            style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Choose a Widget",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
            
                  _buildButton(
                    text: "Container",
                    icon: Icons.crop_square,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ContainerWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Button",
                    icon: Icons.touch_app,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ButtonWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Icon",
                    icon: Icons.insert_emoticon,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IconWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "RadioButton",
                    icon: Icons.radio_button_checked,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RadioButtonWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Checkbox",
                    icon: Icons.check_box,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CheckboxWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Switch",
                    icon: Icons.toggle_on,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SwitchWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Toggle",
                    icon: Icons.toggle_off,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ToggleWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Slider",
                    icon: Icons.linear_scale,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SliderWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Range Slider",
                    icon: Icons.tune,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RangeSliderWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Indicator",
                    icon: Icons.speed,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const IndicatorWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Progress",
                    icon: Icons.hourglass_top,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProgressWidgetPage(),
                      ));
                    },
                  ),
                  _buildButton(
                    text: "Background",
                    icon: Icons.wallpaper,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BackgroundWidgetPage(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
