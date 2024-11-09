/*
 * @Author: dfh
 * @Date: 2024-10-11 13:54:37
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';

class DefaultDialogWidget extends StatelessWidget {
  final String title;

  final double width;

  final double height;

  final String content;

  final Function? onCancel;
  final Function? onConfirm;

  const DefaultDialogWidget(
      {super.key,
      this.width = 400,
      this.height = 200,
      required this.title,
      required this.content,
      this.onCancel,
      this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                content,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonSmallWidget(
                  text: '取消',
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    }
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                ButtonSmallWidget(
                  text: '确定',
                  onPressed: () {
                    if (onConfirm != null) {
                      onConfirm!();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
