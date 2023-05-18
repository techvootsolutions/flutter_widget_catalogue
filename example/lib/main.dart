import 'package:example/Container/Module/widgets/widgets_home.dart';
import 'package:flutter/material.dart';

import 'Button/buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Widgets'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List items = [
    'Button',
    "Neumorphic Container Widgets",
    "Slider",
    "Text Field",
    "Segment"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Buttons()),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WidgetsHome()),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: listItem(items[index], index),
                ),
              );
            }),
      ),
    );
  }
}

Widget listItem(String title, int index) {
  return Container(
    height: 50,
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 13),
    decoration: BoxDecoration(
        color: Colors.cyan,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Text(title,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w700)),
  );
}
