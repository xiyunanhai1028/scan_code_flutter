/*
 * @Author: dfh
 * @Date: 2024-10-05 15:59:45
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final int status;

  const StatusWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.circle,
        color: status == 1 ? Colors.green : Colors.grey,
        size: 8,
      ),
      label: Text(
        status == 1 ? '启动' : '禁用',
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
    );
  }
}
