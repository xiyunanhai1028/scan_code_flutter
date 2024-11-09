/*
 * @Author: dfh
 * @Date: 2024-10-22 23:37:31
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/config/GlobalColor.dart';

class PaginationWidget extends StatefulWidget {
  final int page;
  final int total;
  final Function? onPageChange;
  const PaginationWidget(
      {super.key, required this.page, required this.total, this.onPageChange});

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int currentPage = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = widget.page;
    });
  }

  List<Widget> _rowItem() {
    List<Widget> rows = [];
    for (int i = 0; i < widget.total / 10; i++) {
      rows.add(GestureDetector(
        onTap: () {
          setState(() {
            currentPage = i + 1;
            widget.onPageChange!(i + 1);
          });
        },
        child: Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color:
                i + 1 == currentPage ? GlobalColor.primaryColor : Colors.grey,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '${i + 1}',
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ),
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _rowItem(),
      ),
    );
  }
}
