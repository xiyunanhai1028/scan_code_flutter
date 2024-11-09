/*
 * @Author: dfh
 * @Date: 2024-10-16 08:26:35
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OrderWidget extends StatefulWidget {
  final List<String> dataX;

  final List<String> dataY;
  final List<String> data2Y;
  final int totalOrder;
  final int validOrder;
  final double orderCompleteRate;
  const OrderWidget({
    super.key,
    required this.dataX,
    required this.dataY,
    required this.data2Y,
    required this.totalOrder,
    required this.validOrder,
    required this.orderCompleteRate,
  });

  @override
  State<OrderWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<OrderWidget> {
  late final TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  LineSeries<SalesData, String> _getOrderTotal() {
    List<SalesData> list = [];
    for (int i = 0; i < widget.dataY.length; i++) {
      list.add(SalesData(widget.dataX[i], double.parse(widget.dataY[i])));
    }
    return LineSeries<SalesData, String>(
      legendItemText: '订单总数（个）',
      dataSource: list,
      xValueMapper: (SalesData sales, _) => sales.year,
      yValueMapper: (SalesData sales, _) => sales.sales,
      dataLabelSettings: DataLabelSettings(isVisible: true),
    );
  }

  LineSeries<SalesData, String> _getValidOrder() {
    List<SalesData> list = [];
    for (int i = 0; i < widget.dataY.length; i++) {
      list.add(SalesData(widget.dataX[i], double.parse(widget.data2Y[i])));
    }
    return LineSeries<SalesData, String>(
      legendItemText: '有效订单（个）',
      dataSource: list,
      xValueMapper: (SalesData sales, _) => sales.year,
      yValueMapper: (SalesData sales, _) => sales.sales,
      // Enable data label
      dataLabelSettings: DataLabelSettings(isVisible: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('x-->${widget.dataX}');
    print('x-->${widget.dataY}');
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: "订单统计"),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: _tooltipBehavior,
        series: <LineSeries<SalesData, String>>[
          _getOrderTotal(),
          _getValidOrder()
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
