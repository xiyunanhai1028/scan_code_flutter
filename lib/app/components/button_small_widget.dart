/*
 * @Author: dfh
 * @Date: 2024-10-11 08:40:12
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

class ButtonSmallWidget extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final Color color;

  final Color backgroundColor;

  final double? width;
  final double? height;

  const ButtonSmallWidget(
      {super.key,
      required this.text,
      this.onPressed,
      this.color = Colors.black,
      this.backgroundColor = GlobalColor.primaryColor,
      this.width = 80,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ),
    );
  }
}
