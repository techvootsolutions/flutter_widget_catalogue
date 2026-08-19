import 'package:flutter/material.dart';

class FlutterSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onToggle;
  final String? activeText;
  final String? inactiveText;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final FontWeight activeTextFontWeight;
  final FontWeight inactiveTextFontWeight;
  final Color toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double width;
  final double height;
  final double toggleSize;
  final double valueFontSize;
  final double borderRadius;
  final double padding;
  final bool showOnOff;
  final Duration duration;
  final bool disabled;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final BoxBorder? switchBorder;
  final BoxBorder? toggleBorder;

  const FlutterSwitch({
    super.key,
    required this.value,
    required this.onToggle,
    this.activeText = "On",
    this.inactiveText = "Off",
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.activeTextFontWeight = FontWeight.w900,
    this.inactiveTextFontWeight = FontWeight.w900,
    this.toggleColor = Colors.white,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleSize = 25.0,
    this.valueFontSize = 12.0,
    this.borderRadius = 20.0,
    this.padding = 4.0,
    this.showOnOff = false,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
    this.activeIcon,
    this.inactiveIcon,
    this.switchBorder,
    this.toggleBorder,
  });

  @override
  State<FlutterSwitch> createState() => _FlutterSwitchState();
}

class _FlutterSwitchState extends State<FlutterSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Alignment> _toggleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didUpdateWidget(FlutterSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color toggleColor = Colors.white;
    Color switchColor = Colors.white;
    BorderRadius switchBorderRadius =
        BorderRadius.circular(widget.borderRadius);
    BorderRadius toggleBorderRadius =
        BorderRadius.circular(widget.borderRadius);

    if (widget.value) {
      toggleColor = widget.activeToggleColor ?? widget.toggleColor;
      switchColor = widget.activeColor;
    } else {
      toggleColor = widget.inactiveToggleColor ?? widget.toggleColor;
      switchColor = widget.inactiveColor;
    }

    double textSpace = widget.width - widget.toggleSize;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Align(
          child: GestureDetector(
            onTap: () {
              if (!widget.disabled) {
                if (widget.value) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                widget.onToggle(!widget.value);
              }
            },
            child: Opacity(
              opacity: widget.disabled ? 0.6 : 1,
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  borderRadius: switchBorderRadius,
                  color: switchColor,
                  border: widget.switchBorder,
                ),
                child: Stack(
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: widget.value ? 1.0 : 0.0,
                      duration: widget.duration,
                      child: Container(
                        width: textSpace,
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        alignment: Alignment.centerLeft,
                        child: _activeText,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedOpacity(
                        opacity: !widget.value ? 1.0 : 0.0,
                        duration: widget.duration,
                        child: Container(
                          width: textSpace,
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          alignment: Alignment.centerRight,
                          child: _inactiveText,
                        ),
                      ),
                    ),
                    Align(
                      alignment: _toggleAnimation.value,
                      child: Container(
                        width: widget.toggleSize,
                        height: widget.toggleSize,
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: toggleColor,
                          borderRadius: toggleBorderRadius,
                          border: widget.toggleBorder,
                        ),
                        child: FittedBox(
                          child: Stack(
                            children: [
                              Center(
                                child: AnimatedOpacity(
                                  opacity: widget.value ? 1.0 : 0.0,
                                  duration: widget.duration,
                                  child: widget.activeIcon ??
                                      const SizedBox.shrink(),
                                ),
                              ),
                              Center(
                                child: AnimatedOpacity(
                                  opacity: !widget.value ? 1.0 : 0.0,
                                  duration: widget.duration,
                                  child: widget.inactiveIcon ??
                                      const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get _activeText {
    if (widget.showOnOff) {
      return Text(
        widget.activeText ?? "On",
        style: TextStyle(
          color: widget.activeTextColor,
          fontWeight: widget.activeTextFontWeight,
          fontSize: widget.valueFontSize,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget get _inactiveText {
    if (widget.showOnOff) {
      return Text(
        widget.inactiveText ?? "Off",
        style: TextStyle(
          color: widget.inactiveTextColor,
          fontWeight: widget.inactiveTextFontWeight,
          fontSize: widget.valueFontSize,
        ),
        textAlign: TextAlign.right,
      );
    }
    return const SizedBox.shrink();
  }
}
