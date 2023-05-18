import 'package:example/Container/Module/widgets/toggle/widget_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_components/flutter_component.dart';
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

class WidgetsHome extends StatelessWidget {
  const WidgetsHome({super.key});

  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        shape: NeumorphicShape.flat,
      ),
      onPressed: onClick,
      child: Center(child: Text(text!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: const NeumorphicThemeData(depth: 8),
      child: Scaffold(
        backgroundColor: NeumorphicColors.background,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "Neumorphic Container Widgets",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // TopBar(title: "Widgets"),
                  _buildButton(
                      text: "Container",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ContainerWidgetPage();
                        }));
                      }),
                  // _buildButton(
                  //     text: "App bar",
                  //     onClick: () {
                  //       Navigator.of(context)
                  //           .push(MaterialPageRoute(builder: (context) {
                  //         return AppBarWidgetPage();
                  //       }));
                  //     }),
                  _buildButton(
                      text: "Button",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ButtonWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Icon",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const IconWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "RadioButton",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const RadioButtonWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Checkbox",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const CheckboxWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Switch",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SwitchWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Toggle",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ToggleWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Slider",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const SliderWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Range slider",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const RangeSliderWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Indicator",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const IndicatorWidgetPage();
                        }));
                      }),
                  _buildButton(
                      text: "Progress",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const ProgressWidgetPage();
                        }));
                      }),
                  // _buildButton(
                  //     text: "IndeterminateProgress",
                  //     onClick: () {
                  //       Navigator.of(context)
                  //           .push(MaterialPageRoute(builder: (context) {
                  //         return IndeterminateProgressWidgetPage();
                  //       }));
                  //     }),
                  _buildButton(
                      text: "Background",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const BackgroundWidgetPage();
                        }));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
