import 'package:flutter/material.dart';
import 'package:flutter_widget_catalogue/flutter_widget_catalogue.dart';

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});
  @override
  SwitchPageState createState() => SwitchPageState();
}

class SwitchPageState extends State<MySwitch> {
  bool status1 = false;
  bool status2 = true;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  bool status7 = false;
  bool status8 = false;
  bool isSwitchOn = false;

  Color _textColor = Colors.black;
  Color _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(color: _textColor),
          titleSmall: TextStyle(color: _textColor),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "Switch",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text("Default"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      value: status1,
                      onToggle: (val) {
                        setState(() {
                          status1 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status1",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Custom Colors with Border"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status2,
                      borderRadius: 30.0,
                      padding: 2.0,
                      toggleColor: const Color.fromRGBO(225, 225, 225, 1),
                      switchBorder: Border.all(
                        color: const Color.fromRGBO(2, 107, 206, 1),
                        width: 6.0,
                      ),
                      toggleBorder: Border.all(
                        color: const Color.fromRGBO(2, 107, 206, 1),
                        width: 5.0,
                      ),
                      activeColor: const Color.fromRGBO(51, 226, 255, 1),
                      inactiveColor: Colors.black38,
                      onToggle: (val) {
                        setState(() {
                          status2 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status2",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("With 'On' and 'Off' text and custom text colors"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      showOnOff: true,
                      activeTextColor: Colors.black,
                      inactiveTextColor: Colors.blue.shade50,
                      value: status3,
                      onToggle: (val) {
                        setState(() {
                          status3 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status3",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Custom size"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 55.0,
                      height: 25.0,
                      valueFontSize: 12.0,
                      toggleSize: 18.0,
                      value: status4,
                      onToggle: (val) {
                        setState(() {
                          status4 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status4",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Custom border radius and padding"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 125.0,
                      height: 55.0,
                      valueFontSize: 25.0,
                      toggleSize: 45.0,
                      value: status5,
                      borderRadius: 30.0,
                      padding: 8.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status5 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status5",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Custom text"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      activeText: "All Good. Negative.",
                      inactiveText: "Under Quarantine.",
                      value: status6,
                      valueFontSize: 10.0,
                      width: 110,
                      borderRadius: 30.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status6 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Value: $status6",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Icon in toggle"),
                const Text(
                  "Inspired by the colors from Github Dark Mode switch",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status7,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: const Color(0xFF6E40C9),
                      inactiveToggleColor: const Color(0xFF2F363D),
                      activeSwitchBorder: Border.all(
                        color: const Color(0xFF3C1E70),
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: const Color(0xFFD1D5DA),
                        width: 6.0,
                      ),
                      activeColor: const Color(0xFF271052),
                      inactiveColor: Colors.white,
                      activeIcon: const Icon(
                        Icons.nightlight_round,
                        color: Color(0xFFF8E3A1),
                      ),
                      inactiveIcon: const Icon(
                        Icons.wb_sunny,
                        color: Color(0xFFFFDF5D),
                      ),
                      onToggle: (val) {
                        setState(() {
                          status7 = val;

                          if (val) {
                            _textColor = Colors.white;
                            _appBarColor = const Color.fromRGBO(22, 27, 34, 1);
                            _scaffoldBgColor = const Color(0xFF0D1117);
                          } else {
                            _textColor = Colors.black;
                            _appBarColor = const Color.fromRGBO(36, 41, 46, 1);
                            _scaffoldBgColor = Colors.white;
                          }
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("Value: $status7"),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Text("Image as toggle icon"),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 100.0,
                      height: 55.0,
                      toggleSize: 45.0,
                      value: status8,
                      borderRadius: 30.0,
                      padding: 2.0,
                      activeToggleColor: const Color(0xFF0082C8),
                      inactiveToggleColor: const Color(0xFF01579B),
                      activeSwitchBorder: Border.all(
                        color: const Color(0xFF00D2B8),
                        width: 6.0,
                      ),
                      inactiveSwitchBorder: Border.all(
                        color: const Color(0xFF29B6F6),
                        width: 6.0,
                      ),
                      activeColor: const Color(0xFF55DDCA),
                      inactiveColor: const Color(0xFF54C5F8),
                      activeIcon: Image.network(
                        "https://img2.pngio.com/functional-bits-in-flutter-flutter-community-medium-flutter-png-1000_1000.png",
                      ),
                      inactiveIcon: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                      ),
                      onToggle: (val) {
                        setState(() {
                          status8 = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text("Value: $status8"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
