/*
 * @Author: dfh
 * @Date: 2024-10-16 08:26:35
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserWidget extends StatefulWidget {
  final List<String> dataX;

  final List<String> dataY;
  final List<String> data2Y;

  const UserWidget(
      {super.key,
      required this.dataX,
      required this.dataY,
      required this.data2Y});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  late final TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  LineSeries<SalesData, String> _getUserTotal() {
    List<SalesData> list = [];
    for (int i = 0; i < widget.dataY.length; i++) {
      list.add(SalesData(widget.dataX[i], double.parse(widget.dataY[i])));
    }
    return LineSeries<SalesData, String>(
      legendItemText: '用户总数',
      dataSource: list,
      xValueMapper: (SalesData sales, _) => sales.year,
      yValueMapper: (SalesData sales, _) => sales.sales,
      // Enable data label
      dataLabelSettings: DataLabelSettings(isVisible: true),
    );
  }

  LineSeries<SalesData, String> _getNewUser() {
    List<SalesData> list = [];
    for (int i = 0; i < widget.dataY.length; i++) {
      list.add(SalesData(widget.dataX[i], double.parse(widget.data2Y[i])));
    }
    return LineSeries<SalesData, String>(
      legendItemText: '新增用户',
      dataSource: list,
      xValueMapper: (SalesData sales, _) => sales.year,
      yValueMapper: (SalesData sales, _) => sales.sales,
      // Enable data label
      dataLabelSettings: DataLabelSettings(isVisible: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        title: ChartTitle(text: "用户统计"),
        // Enable legend
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        // Enable tooltip
        tooltipBehavior: _tooltipBehavior,
        series: <LineSeries<SalesData, String>>[_getUserTotal(), _getNewUser()],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
