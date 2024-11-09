/*
 * @Author: dfh
 * @Date: 2024-10-11 11:16:20
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String label;

  final bool required;

  final void Function(String)? onChange;

  final String text;

  final int? maxLines;
  final bool readOnly;
  final Function()? onTap;

  const TextFormFieldWidget(
      {super.key,
      required this.label,
      this.required = false,
      this.onChange,
      this.text = '',
      this.maxLines = 1,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(text: text),
      onTap: onTap,
      textAlignVertical: TextAlignVertical.bottom,
      maxLines: maxLines,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: "请输入$label",
        suffixIcon: Icon(
          Icons.star,
          color: Colors.red,
          size: required ? 12 : 0,
        ),
      ),
      validator: (v) {
        if (required) {
          return v!.trim().isNotEmpty ? null : "$label不能为空";
        }
      },
      onChanged: (v) {
        if (onChange != null) {
          onChange!(v);
        }
      },
    );
  }
}
