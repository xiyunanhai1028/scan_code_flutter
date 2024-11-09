/*
 * @Author: dfh
 * @Date: 2024-10-11 11:23:05
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/components/button_small_widget.dart';
import 'package:get/get.dart';

class DialogWidget extends StatelessWidget {
  final String title;

  final double width;

  final double height;

  final Widget child;

  final Function? onCancel;
  final Function? onConfirm;

  const DialogWidget(
      {super.key,
      required this.title,
      this.width = 500,
      this.height = 400,
      required this.child,
      this.onCancel,
      this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 40,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          child,
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonSmallWidget(
                  text: '取消',
                  onPressed: () {
                    if (onCancel != null) {
                      onCancel!();
                    }
                  },
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 20,
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
            ),
          )
        ],
      ),
    );
  }
}
