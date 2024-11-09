import 'package:get/route_manager.dart';

import '../modules/category_manager/bindings/category_manager_binding.dart';
import '../modules/category_manager/views/category_manager_view.dart';
import '../modules/dish_manager/bindings/dish_manager_binding.dart';
import '../modules/dish_manager/views/dish_manager_view.dart';
import '../modules/employee_manager/bindings/employee_manager_binding.dart';
import '../modules/employee_manager/views/employee_manager_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/order_manager/bindings/order_manager_binding.dart';
import '../modules/order_manager/views/order_manager_view.dart';
import '../modules/setmeal_manager/bindings/setmeal_manager_binding.dart';
import '../modules/setmeal_manager/views/setmeal_manager_view.dart';
import '../modules/shop_manager/bindings/shop_manager_binding.dart';
import '../modules/shop_manager/views/shop_manager_view.dart';
import '../modules/statistics_manager/bindings/statistics_manager_binding.dart';
import '../modules/statistics_manager/views/statistics_manager_view.dart';

/*
 * @Author: dfh
 * @Date: 2024-09-20 16:49:01
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ELEMENT_MANAGER,
      page: () => const EmployeeManagerView(),
      binding: EmployeeManagerBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_MANAGER,
      page: () => const CategoryManagerView(),
      binding: CategoryManagerBinding(),
    ),
    GetPage(
      name: _Paths.DISH_MANAGER,
      page: () => const DishManagerView(),
      binding: DishManagerBinding(),
    ),
    GetPage(
      name: _Paths.SETMEAL_MANAGER,
      page: () => const SetmealManagerView(),
      binding: SetmealManagerBinding(),
      children: [
        GetPage(
          name: _Paths.SETMEAL_MANAGER,
          page: () => const SetmealManagerView(),
          binding: SetmealManagerBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ORDER_MANAGER,
      page: () => const OrderManagerView(),
      binding: OrderManagerBinding(),
      children: [
        GetPage(
          name: _Paths.ORDER_MANAGER,
          page: () => const OrderManagerView(),
          binding: OrderManagerBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.STATIS_MANAGER,
      page: () => const StatisticsManagerView(),
      binding: StatisticsManagerBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_MANAGER,
      page: () => ShopManagerView(),
      binding: ShopManagerBinding(),
    ),
    GetPage(
      name: _Paths.STATISTICS_MANAGER,
      page: () => const StatisticsManagerView(),
      binding: StatisticsManagerBinding(),
    ),
  ];
}
