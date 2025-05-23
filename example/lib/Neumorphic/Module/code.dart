import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  final String text;

  const Code(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xffD3D3D3),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class MyIntWidget extends StatefulWidget {
  final int? value;

  const MyIntWidget({super.key, this.value});

  @override
  MyIntWidgetState createState() => MyIntWidgetState();
}

class MyIntWidgetState extends State<MyIntWidget>
    with TickerProviderStateMixin {
  int? _value;
  AnimationController? _controller;
  Animation<int>? _valueAnimation;

  @override
  void initState() {
    _value = widget.value;
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void didUpdateWidget(MyIntWidget oldWidget) {
    if (oldWidget.value != widget.value) {
      _controller!.reset();
      _valueAnimation =
          Tween(begin: _value, end: widget.value).animate(_controller!)
            ..addListener(() {
              _value = _valueAnimation!.value;
            });
      _controller!.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text("current : $_value");
  }
}
