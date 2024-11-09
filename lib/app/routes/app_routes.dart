/*
 * @Author: dfh
 * @Date: 2024-09-20 16:35:57
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const ELEMENT_MANAGER = _Paths.ELEMENT_MANAGER;
  static const CATEGORY_MANAGER = _Paths.CATEGORY_MANAGER;
  static const DISH_MANAGER = _Paths.DISH_MANAGER;
  static const SETMEAL_MANAGER = _Paths.SETMEAL_MANAGER;
  static const ORDER_MANAGER = _Paths.ORDER_MANAGER;
  static const STATIS_MANAGER = _Paths.STATIS_MANAGER;
  static const SHOP_MANAGER = _Paths.SHOP_MANAGER;
  static const STATISTICS_MANAGER = _Paths.STATISTICS_MANAGER;
}

abstract class _Paths {
  _Paths._();

  static const LOGIN = '/login';
  static const HOME = '/home';
  static const ELEMENT_MANAGER = '/element-manager';
  static const CATEGORY_MANAGER = '/category-manager';
  static const DISH_MANAGER = '/dish-manager';
  static const SETMEAL_MANAGER = '/setmeal-manager';
  static const ORDER_MANAGER = '/order-manager';
  static const STATIS_MANAGER = '/statis-manager';
  static const SHOP_MANAGER = '/shop-manager';
  static const STATISTICS_MANAGER = '/statistics-manager';
}
