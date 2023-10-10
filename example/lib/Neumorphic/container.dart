import 'package:example/Neumorphic/Module/accessibility/neumorphic_accessibility.dart';
import 'package:example/Neumorphic/Module/playground/text_playground.dart';
import 'package:example/Neumorphic/Module/samples/sample_home.dart';
import 'package:example/Neumorphic/Module/tips/tips_home.dart';
import 'package:example/Neumorphic/Module/widgets/widgets_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class NeumorphicContainer extends StatefulWidget {
  const NeumorphicContainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<NeumorphicContainer> {
  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return NeumorphicButton(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      onPressed: onClick,
      child: Center(child: Text(text!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          "Neumorphic Container Widgets",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: NeumorphicTheme(
        theme: const NeumorphicThemeData(depth: 8),
        child: Scaffold(
          backgroundColor: NeumorphicColors.background,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text("Neumorphic Simple Buttons",
                        style: TextStyle(color: Colors.black, fontSize: 20.0)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    _buildButton(
                      text: "Submit",
                      onClick: () {
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(builder: (context) {
                        //   return NeumorphicPlayground();
                        // }));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildButton(
                      text: "Text Playground",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const NeumorphicTextPlayground();
                        }));
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: "Samples",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const SamplesHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: "Widgets",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const WidgetsHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: "Tips",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const TipsHome();
                          }));
                        }),
                    const SizedBox(height: 24),
                    _buildButton(
                        text: "Accessibility",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const NeumorphicAccessibility();
                          }));
                        }),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
