/*
 * @Author: dfh
 * @Date: 2024-10-11 11:16:20
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/bean/options_model.dart';
import 'package:get/get.dart';

class TextFormFieldSelectedWidget extends StatefulWidget {
  final String label;

  final bool required;

  final Function callback;
  final List<OptionsBean> options;
  final String text;

  const TextFormFieldSelectedWidget(
      {super.key,
      required this.label,
      this.required = false,
      required this.callback,
      required this.options,
      this.text = ''});

  @override
  State<TextFormFieldSelectedWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldSelectedWidget> {
  final TextEditingController _controller = TextEditingController();
  String selectedId = '';

  @override
  void initState() {
    if (widget.text.isNotEmpty) {
      for (var element in widget.options) {
        if (element.value == widget.text) {
          _controller.text = element.label;
        }
      }
    }
  }

  List<Widget> _getListItem() {
    List<Widget> list = [];
    for (var element in widget.options) {
      list.add(ListTile(
        onTap: () {
          _controller.text = element.label;
          widget.callback(element.value);
          setState(() {
            selectedId = element.value;
          });
          Get.back();
        },
        title: Text(element.label),
        trailing: Icon(
          selectedId == element.value
              ? Icons.radio_button_checked
              : Icons.radio_button_off,
          color: selectedId == element.value ? Colors.amber[600] : Colors.grey,
        ),
      ));
    }
    return list;
  }

  void showSelectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
          child: Container(
        width: 320,
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 40,
                child: Text(
                  "请选择${widget.label}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [..._getListItem()],
            ))
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onTap: () {
        showSelectedDialog(context);
      },
      textAlignVertical: TextAlignVertical.bottom,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.label,
        hintText: "请选择${widget.label}",
        suffixIcon: Icon(
          Icons.star,
          color: Colors.red,
          size: widget.required ? 12 : 0,
        ),
      ),
      validator: (v) {
        if (widget.required) {
          return v!.trim().isNotEmpty ? null : "${widget.label}不能为空";
        }
      },
    );
  }
}
