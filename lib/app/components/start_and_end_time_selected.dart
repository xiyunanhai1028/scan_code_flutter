/*
 * @Author: dfh
 * @Date: 2024-10-15 13:25:48
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'dart:io';

import 'package:flutter/material.dart';

import '../modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class StartAndEndTimeSelected extends StatefulWidget {
  final bool readOnly;
  const StartAndEndTimeSelected({super.key, required this.readOnly});

  @override
  State<StartAndEndTimeSelected> createState() =>
      _StartAndEndTimeSelectedState();
}

class _StartAndEndTimeSelectedState extends State<StartAndEndTimeSelected> {
  final controller = Get.find<HomeController>();
  final _beginTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _beginTimeController.text = controller.shopInfo.value.beginTime ?? '';
    _endTimeController.text = controller.shopInfo.value.endTime ?? '';
  }

  void showTimeSelected(BuildContext context, String type) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      cancelText: '取消',
      confirmText: '确定',
      helpText: '时间选择',
      hourLabelText: '小时',
      minuteLabelText: '分钟',
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (timePicked != null) {
      String hour = '0${timePicked.hour}'.length == 2
          ? '0${timePicked.hour}'
          : '${timePicked.hour}';
      String minute = '0${timePicked.minute}'.length == 2
          ? '0${timePicked.minute}'
          : '${timePicked.minute}';
      if (type == 'begin') {
        controller.shopInfo.value.beginTime = '$hour:$minute:00';
        _beginTimeController.text = '$hour:$minute:00';
      } else {
        controller.shopInfo.value.endTime = '$hour:$minute:00';
        _endTimeController.text = '$hour:$minute:00';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: _beginTimeController,
            onTap: () {
              if (!widget.readOnly) {
                showTimeSelected(context, 'begin');
              }
            },
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '营业开始时间',
              hintText: "开始时间",
              suffixIcon: Icon(
                Icons.star,
                color: Colors.red,
                size: 12,
              ),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "营业开始时间不能为空";
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text(
            ' 至 ',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: _endTimeController,
            onTap: () {
              if (!widget.readOnly) {
                showTimeSelected(context, 'end');
              }
            },
            textAlignVertical: TextAlignVertical.bottom,
            readOnly: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '营业结束时间',
              hintText: "结束时间",
              suffixIcon: Icon(
                Icons.star,
                color: Colors.red,
                size: 12,
              ),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "营业结束时间不能为空";
            },
          ),
        ),
      ],
    );
  }
}
