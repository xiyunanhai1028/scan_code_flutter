/*
 * @Author: dfh
 * @Date: 2024-10-15 10:13:14
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/order_widget.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/statistics_search.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/top10_widget.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/turnover_widget.dart';
import 'package:flutter_pc_manager/app/modules/statistics_manager/views/user_widget.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../controllers/statistics_manager_controller.dart';

class StatisticsManagerView extends StatefulWidget {
  const StatisticsManagerView({super.key});

  @override
  State<StatisticsManagerView> createState() => _StatisticsManagerViewState();
}

class _StatisticsManagerViewState extends State<StatisticsManagerView> {
  final StatisticsManagerController _controller = StatisticsManagerController();

  @override
  void initState() {
    super.initState();
    _controller.fetchTurnoverData(0);
    _controller.fetchUserData(0);
    _controller.fetchOrderData(0);
    _controller.fetchTop10Data(0);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: StatisticsSearch(controller: _controller),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TurnoverWidget(
                        dataX: _controller.turnoverX.value,
                        dataY: _controller.turnoverY.value),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: UserWidget(
                        dataX: _controller.userX.value,
                        dataY: _controller.totalUserY.value,
                        data2Y: _controller.newUserY.value),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OrderWidget(
                      dataX: _controller.orderX.value,
                      dataY: _controller.totalOrderY.value,
                      data2Y: _controller.validOrderY.value,
                      totalOrder: _controller.totalOrder.value,
                      validOrder: _controller.validOrder.value,
                      orderCompleteRate: _controller.orderCompleteRate.value,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Top10Widget(
                      dataX: _controller.top10X.value,
                      dataY: _controller.top10Y.value,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // return Obx(
    //   () => GridView.count(
    //     crossAxisCount: 2,
    //     children: [
    //       TurnoverWidget(
    //           dataX: _controller.turnoverX.value,
    //           dataY: _controller.turnoverY.value),
    //       UserWidget(
    //           dataX: _controller.userX.value,
    //           dataY: _controller.totalUserY.value,
    //           data2Y: _controller.newUserY.value),
    //       TurnoverWidget(
    //           dataX: _controller.turnoverX.value,
    //           dataY: _controller.turnoverY.value),
    //       UserWidget(
    //           dataX: _controller.userX.value,
    //           dataY: _controller.totalUserY.value,
    //           data2Y: _controller.newUserY.value)
    //     ],
    //   ),
    // );
  }
}
