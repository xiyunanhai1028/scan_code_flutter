/*
 * @Author: dfh
 * @Date: 2024-10-09 22:33:07
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bean/options_model.dart';

class SelectWidget extends StatefulWidget {
  final String label;
  final String? text;

  final Function callback;

  final List<OptionsBean> options;
  final bool onlyShow;

  const SelectWidget(
      {super.key,
      required this.label,
      required this.callback,
      required this.options,
      this.onlyShow = false,
      this.text = ''});

  @override
  State<SelectWidget> createState() => _SelectWidgetState();
}

class _SelectWidgetState extends State<SelectWidget> {
  final TextEditingController _controller = TextEditingController();
  String selectedId = '';

  @override
  void initState() {
    if (widget.text != null) {
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
          widget.callback(element.value);
          setState(() {
            _controller.text = element.label;
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
    // _controller.text = widget.text ?? '';
    return Stack(
      children: [
        Container(
          width: 250,
          height: 40,
          margin: const EdgeInsets.only(right: 10),
          child: TextField(
            controller: _controller,
            readOnly: true,
            onTap: () {
              if (widget.onlyShow) return;
              showSelectedDialog(context);
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                hintText: "请选择${widget.label}"),
          ),
        ),
        (selectedId.isNotEmpty && !widget.onlyShow)
            ? Positioned(
                right: 20,
                top: 10,
                child: GestureDetector(
                  onTap: () {
                    _controller.text = "";
                    widget.callback(null);
                    setState(() {
                      selectedId = '';
                    });
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              )
            : const SizedBox(
                width: 0,
                height: 0,
              )
      ],
    );
  }
}
