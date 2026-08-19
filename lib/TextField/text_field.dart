import 'package:flutter/material.dart';

class FlutterTextField extends StatefulWidget {
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Widget? customTextFieldIcon;
  final Color? leadingIconColor;
  final TextStyle? hintStyling;
  final double? leadingIconSize;
  final String? hintText;
  final TextEditingController? textEditingController;
  final TextStyle? textFieldTextStyle;
  final TextStyle? labelNameTextStyle;
  final bool? isNumber;
  final bool? isPasswordField;
  final Widget? trailingWidget;
  final IconData? customLeadingIcon;
  final bool? isIconShow;
  final bool? readOnly;
  final Color? borderColor;
  final Color? fillColor;
  final Color? cursorColor;
  final String? labelName;
  final String? Function(String?)? validator;

  const FlutterTextField({
    super.key,
    this.width,
    this.backgroundColor,
    this.borderRadius,
    this.iconBackgroundColor,
    this.customTextFieldIcon,
    this.leadingIconColor,
    this.leadingIconSize,
    this.hintText,
    this.textEditingController,
    this.hintStyling,
    this.textFieldTextStyle,
    this.labelNameTextStyle,
    this.isNumber,
    this.isPasswordField,
    this.trailingWidget,
    this.customLeadingIcon,
    this.isIconShow,
    this.readOnly,
    this.borderColor,
    this.fillColor,
    this.cursorColor,
    this.labelName,
    this.validator,
  });

  @override
  State<FlutterTextField> createState() => _FlutterTextFieldState();
}

class _FlutterTextFieldState extends State<FlutterTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPasswordField ?? false;
  }

  @override
  void didUpdateWidget(covariant FlutterTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPasswordField != oldWidget.isPasswordField) {
      _obscureText = widget.isPasswordField ?? false;
    }
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double radius = widget.borderRadius ?? 10.0;
    final double iconSize = widget.leadingIconSize ?? 25.0;
    final bool isReadOnly = widget.readOnly ?? false;
    final Color borderSideColor = isReadOnly
        ? (widget.borderColor ?? const Color(0xffF0F0F0))
        : (widget.borderColor ?? const Color(0xffF0F0F0));

    return SizedBox(
      width: widget.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.labelName?.isNotEmpty ?? false)
              ? Column(
                  children: [
                    Text(
                      widget.labelName!,
                      style: widget.labelNameTextStyle ??
                          const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                )
              : Container(),
          TextFormField(
            obscureText: (widget.isPasswordField == true) ? _obscureText : false,
            readOnly: isReadOnly,
            controller: widget.textEditingController,
            cursorColor: widget.cursorColor ?? Colors.blue,
            keyboardType: widget.isNumber == true
                ? TextInputType.number
                : TextInputType.text,
            style: widget.textFieldTextStyle ??
                const TextStyle(
                  decoration: TextDecoration.none,
                ),
            decoration: InputDecoration(
              fillColor: widget.fillColor,
              filled: widget.fillColor != null,
              prefixIcon: widget.isIconShow == true
                  ? widget.customTextFieldIcon ??
                      Icon(
                        widget.customLeadingIcon ?? Icons.add,
                        color: widget.leadingIconColor ?? Colors.white,
                        size: iconSize,
                      )
                  : null,
              suffixIcon: widget.isPasswordField == true
                  ? IconButton(
                      onPressed: _toggleObscureText,
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : widget.trailingWidget,
              hintText: widget.hintText ?? "",
              hintStyle: widget.hintStyling ??
                  const TextStyle(
                    color: Color(0xffABABAB),
                    fontSize: 16,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderSideColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: borderSideColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(
                  width: 1,
                  color: borderSideColor,
                ),
              ),
            ),
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
