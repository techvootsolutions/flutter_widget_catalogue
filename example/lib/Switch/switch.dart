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

  Color textColor = Colors.black;
  Color appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color scaffoldBgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        elevation: 4,
        title: const Text(
          "Switch UI",
          style: TextStyle(
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            buildSwitchCard("Default Switch", status1, (val) {
              setState(() => status1 = val);
            }),
            buildSwitchCard("Custom Colors & Border", status2, (val) {
              setState(() => status2 = val);
            },
                switchWidget: FlutterSwitch(
                  width: 90.0,
                  height: 45.0,
                  toggleSize: 38.0,
                  value: status2,
                  borderRadius: 24.0,
                  padding: 2.0,
                  toggleColor: Colors.white,
                  switchBorder:
                      Border.all(color: Colors.blueAccent, width: 3.0),
                  activeColor: Colors.cyan,
                  inactiveColor: Colors.grey.shade400,
                  onToggle: (val) {
                    setState(() {
                      status2 = val;
                    });
                  },
                )),
            buildSwitchCard("Text On/Off", status3, (val) {
              setState(() => status3 = val);
            },
                switchWidget: FlutterSwitch(
                  showOnOff: true,
                  activeTextColor: Colors.black,
                  inactiveTextColor: Colors.white,
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                  value: status3,
                  onToggle: (val) {
                    setState(() {
                      status3 = val;
                    });
                  },
                )),
            buildSwitchCard("Custom Size", status4, (val) {
              setState(() => status4 = val);
            },
                switchWidget: FlutterSwitch(
                  width: 60.0,
                  height: 30.0,
                  toggleSize: 22.0,
                  valueFontSize: 12.0,
                  value: status4,
                  onToggle: (val) {
                    setState(() {
                      status4 = val;
                    });
                  },
                )),
            buildSwitchCard("Rounded & Padding", status5, (val) {
              setState(() => status5 = val);
            },
                switchWidget: FlutterSwitch(
                  width: 120.0,
                  height: 50.0,
                  valueFontSize: 20.0,
                  toggleSize: 40.0,
                  borderRadius: 30.0,
                  padding: 6.0,
                  showOnOff: true,
                  activeColor: Colors.blue.shade700,
                  inactiveColor: Colors.grey.shade600,
                  value: status5,
                  onToggle: (val) {
                    setState(() {
                      status5 = val;
                    });
                  },
                )),
            buildSwitchCard("Custom Labels", status6, (val) {
              setState(() => status6 = val);
            },
                switchWidget: FlutterSwitch(
                  activeText: "Enabled",
                  inactiveText: "Disabled",
                  value: status6,
                  valueFontSize: 12.0,
                  width: 100,
                  borderRadius: 20.0,
                  showOnOff: true,
                  activeColor: Colors.greenAccent.shade700,
                  inactiveColor: Colors.redAccent.shade400,
                  onToggle: (val) {
                    setState(() {
                      status6 = val;
                    });
                  },
                )),
            buildSwitchCard("Icon in Toggle", status7, (val) {
              setState(() {
                status7 = val;
                textColor = val ? Colors.white : Colors.black;
                appBarColor = val ? Colors.black87 : Colors.blueAccent;
                scaffoldBgColor = val ? Colors.black : Colors.white;
              });
            },
                switchWidget: FlutterSwitch(
                  width: 90.0,
                  height: 45.0,
                  toggleSize: 38.0,
                  borderRadius: 24.0,
                  padding: 2.0,
                  activeToggleColor: Colors.deepPurpleAccent,
                  inactiveToggleColor: Colors.grey.shade600,
                  activeIcon: const Icon(Icons.dark_mode, color: Colors.yellow),
                  inactiveIcon:
                      const Icon(Icons.light_mode, color: Colors.orange),
                  activeColor: Colors.black,
                  inactiveColor: Colors.white,
                  value: status7,
                  onToggle: (val) {
                    setState(() {
                      status7 = val;
                    });
                  },
                )),
            buildSwitchCard("Image as Toggle Icon", status8, (val) {
              setState(() => status8 = val);
            },
                switchWidget: FlutterSwitch(
                  width: 100.0,
                  height: 50.0,
                  toggleSize: 40.0,
                  borderRadius: 30.0,
                  padding: 5,
                  activeToggleColor: Colors.blue,
                  inactiveToggleColor: Colors.grey,
                  activeIcon: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
                    width: 30,
                  ),
                  inactiveIcon: Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/7/7e/Dart-logo.png",
                    width: 20,
                  ),
                  activeColor: Colors.lightBlue,
                  inactiveColor: Colors.grey.shade400,
                  value: status8,
                  onToggle: (val) {
                    setState(() {
                      status8 = val;
                    });
                  },
                )),
          ],
        ),
      ),
    );
  }

  /// 📌 **Reusable Switch Card UI**
  Widget buildSwitchCard(String title, bool status, Function(bool) onToggle,
      {Widget? switchWidget}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            switchWidget ??
                FlutterSwitch(
                  value: status,
                  onToggle: onToggle,
                  activeColor: Colors.teal,
                  inactiveColor: Colors.redAccent,
                ),
          ],
        ),
      ),
    );
  }
}
