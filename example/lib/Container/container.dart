import 'package:example/Container/Module/accessibility/neumorphic_accessibility.dart';
import 'package:example/Container/Module/playground/text_playground.dart';
import 'package:example/Container/Module/samples/sample_home.dart';
import 'package:example/Container/Module/tips/tips_home.dart';
import 'package:example/Container/Module/widgets/widgets_home.dart';
import 'package:flutter_components/flutter_component.dart';

class NeumorphicContainer extends StatefulWidget {
  @override
  _ButtonsPageState createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<NeumorphicContainer> {
  Widget _buildButton({String? text, VoidCallback? onClick}) {
    return NeumorphicButton(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      child: Center(child: Text(text!)),
      onPressed: onClick,
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
        theme: NeumorphicThemeData(depth: 8),
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
                    SizedBox(height: 24),
                    _buildButton(
                      text: "Text Playground",
                      onClick: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return NeumorphicTextPlayground();
                        }));
                      },
                    ),
                    SizedBox(height: 24),
                    _buildButton(
                        text: "Samples",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return SamplesHome();
                          }));
                        }),
                    SizedBox(height: 24),
                    _buildButton(
                        text: "Widgets",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return WidgetsHome();
                          }));
                        }),
                    SizedBox(height: 24),
                    _buildButton(
                        text: "Tips",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return TipsHome();
                          }));
                        }),
                    SizedBox(height: 24),
                    _buildButton(
                        text: "Accessibility",
                        onClick: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return NeumorphicAccessibility();
                          }));
                        }),
                    SizedBox(height: 12),
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
