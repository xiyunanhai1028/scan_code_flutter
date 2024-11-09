/*
 * @Author: dfh
 * @Date: 2024-09-19 21:56:36
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  CustomInputWidget(
      {super.key,
      this.controller,
      required this.prefixIcon,
      required this.labelText,
      this.validator,
      this.size = 24});

  TextEditingController? controller;
  IconData prefixIcon;
  String labelText;
  String? Function(String?)? validator;
  double size;

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: "请输入您的${widget.labelText}",
        prefixIcon: Icon(
          widget.prefixIcon,
          size: widget.size,
        ),
      ),
      validator: widget.validator,
    );
  }
}
