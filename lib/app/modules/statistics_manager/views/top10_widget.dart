/*
 * @Author: dfh
 * @Date: 2024-10-16 08:26:35
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Top10Widget extends StatelessWidget {
  final List<String> dataX;

  final List<String> dataY;

  const Top10Widget({super.key, required this.dataX, required this.dataY});

  List<SalesData> _getRowItem() {
    List<SalesData> list = [];
    for (int i = 0; i < dataX.length; i++) {
      list.add(SalesData(dataX[i], double.parse(dataY[i])));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: SfCartesianChart(
        title: ChartTitle(text: "销量排名TOP10"),
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
              dataSource: _getRowItem(),
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
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
