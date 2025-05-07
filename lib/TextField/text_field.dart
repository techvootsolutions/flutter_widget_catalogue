import 'package:flutter/material.dart';

class FlutterTextField extends StatefulWidget {
  final int? width;
  final int? borderRadius;
  final Color? backgroundColor;
  final Color? iconBackgroundColor;
  final Widget? customTextFieldIcon;
  final Color? leadingIconColor;
  final TextStyle? hintStyling;
  final int? leadingIconSize;
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

  const FlutterTextField(
      {super.key,
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
      this.labelName});

  @override
  State<FlutterTextField> createState() => _FlutterTextFieldState();
}

class _FlutterTextFieldState extends State<FlutterTextField> {
  bool showPassword = false;

  void showHidePassword() {
    if (showPassword == true) {
      setState(() {
        showPassword = false;
      });
    } else if (showPassword == false) {
      setState(() {
        showPassword = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
            obscureText: showPassword,
            readOnly: widget.readOnly!,
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
              filled: widget.fillColor == null ? false : true,
              prefixIcon: widget.isIconShow == true
                  ? widget.customTextFieldIcon ??
                      Icon(
                        widget.customLeadingIcon ?? Icons.add,
                        color: widget.leadingIconColor ?? Colors.white,
                        size: widget.leadingIconSize != null
                            ? double.parse(widget.leadingIconSize.toString())
                            : 25,
                      )
                  : null,
              suffixIcon: widget.isPasswordField == true
                  ? IconButton(
                      onPressed: showHidePassword,
                      icon: Icon(
                        showPassword == true
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                    )
                  : widget.trailingWidget ?? const SizedBox(),
              hintText: widget.hintText ?? "",
              hintStyle: widget.hintStyling ??
                  const TextStyle(
                    color: Color(0xffABABAB),
                    fontSize: 16,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? double.parse(widget.borderRadius.toString())
                      : 10,
                ),
                borderSide: BorderSide(
                    color: widget.readOnly! == true
                        ? (widget.borderColor == null)
                            ? const Color(0xffF0F0F0)
                            : widget.borderColor!
                        : widget.borderColor!),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? double.parse(widget.borderRadius.toString())
                      : 10,
                ),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.red,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? double.parse(widget.borderRadius.toString())
                      : 10,
                ),
                borderSide: BorderSide(
                    color: widget.readOnly! == true
                        ? (widget.borderColor == null)
                            ? const Color(0xffF0F0F0)
                            : widget.borderColor!
                        : widget.borderColor!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  widget.borderRadius != null
                      ? double.parse(widget.borderRadius.toString())
                      : 10,
                ),
                borderSide: BorderSide(
                    width: 1,
                    color: widget.readOnly! == true
                        ? (widget.borderColor == null)
                            ? const Color(0xffF0F0F0)
                            : widget.borderColor!
                        : widget.borderColor!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
