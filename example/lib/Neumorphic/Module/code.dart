import 'package:flutter/material.dart';

class Code extends StatelessWidget {
  final String text;

  const Code(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey.withValues(
        alpha: (0.2 * 255).toDouble(), // Convert opacity (0.0 - 1.0) to alpha (0 - 255)
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black.withValues(
          alpha: (0.8 * 255).toDouble(), // Convert opacity (0.0 - 1.0) to alpha (0 - 255)
        )),
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
