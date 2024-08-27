import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.afterPressIcon,
    this.obscureText,
    this.transparentColor,
    this.clickSound,
    this.onChanged,
  });
  String hintText;
  IconData icon;
  IconData? afterPressIcon;
  bool? obscureText;
  Color? transparentColor;
  bool? clickSound;
  Function(String)? onChanged;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // ignore: body_might_complete_normally_nullable
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field is required !';
        }
      },
      onChanged: widget.onChanged,
      style: TextStyle(
        color: Colors.grey.shade100,
      ),
      obscureText: widget.obscureText ?? false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: IconButton(
          splashColor: widget.transparentColor,
          highlightColor: widget.transparentColor,
          hoverColor: widget.transparentColor,
          enableFeedback: widget.clickSound,
          onPressed: toggleObscureText,
          icon: Icon(
            getIcon(),
            color: Colors.grey.shade400,
          ),
          color: Colors.grey.shade400,
        ),
      ),
      cursorColor: Colors.grey.shade400,
    );
  }

  IconData getIcon() {
    if (widget.obscureText == true) {
      return widget.icon;
    } else {
      return widget.afterPressIcon ?? widget.icon;
    }
  }

  void toggleObscureText() {
    setState(() {
      if (widget.obscureText != null) {
        widget.obscureText = !widget.obscureText!;
      }
    });
  }
}
