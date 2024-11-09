/*
 * @Author: dfh
 * @Date: 2024-10-11 08:40:12
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

import '../../config/GlobalColor.dart';

class IconButtonSmallWidget extends StatelessWidget {
  final Function? onPressed;
  final String label;
  final Color color;
  final IconData? iconData;
  final double? width;
  final Color backgroundColor;

  const IconButtonSmallWidget(
      {super.key,
      required this.label,
      this.onPressed,
      this.color = Colors.black,
      required this.iconData,
      this.width = 80,
      this.backgroundColor = GlobalColor.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 40,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(backgroundColor),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        icon: Icon(
          iconData,
          color: color,
        ),
        label: Text(
          label,
          style: TextStyle(fontSize: 16, color: color),
        ),
      ),
    );
  }
}
