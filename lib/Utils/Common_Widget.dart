import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextInputBox extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final List<TextInputFormatter>? formatter;
  final Widget? suffixWidget;
  const TextInputBox({super.key,required this.controller,required this.hintText,required this.type,this.formatter,this.suffixWidget});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     controller: controller,
      decoration: InputDecoration(
          labelText: hintText,
        suffixIcon: suffixWidget
      ),
      keyboardType: type,
      inputFormatters: formatter,
    );
  }
}


class CustomRadioButton extends StatelessWidget {
  final bool isSelected;
  final Color fillColor;
  final Color borderColor;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.isSelected,
    required this.fillColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 3.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? fillColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
