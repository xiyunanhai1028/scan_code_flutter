<!--
 * @Author: dfh
 * @Date: 2024-09-20 16:22:57
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
-->
flutter pub add shared_preferences
flutter run --no-sound-null-safety

lib
├── app
│   ├── components                                      公共组件部分
│   ├── modules                                         页面Get框架的MVC结构，以login页为列
│   │   ├── login
│   │   │   ├── bindings                                
│   │   │   │   └── login_binding.dart
│   │   │   ├── controllers                             
│   │   │   │   └── login_controller.dart
│   │   │   ├── models
│   │   │   │   ├── login_dto.dart
│   │   │   │   └── login_model.dart
│   │   │   ├── providers
│   │   │   │   └── login_provider.dart
│   │   │   └── views
│   │   │       └── login_view.dart
│   └── routes                                          路由配置
│       ├── app_pages.dart
│       └── app_routes.dart
├── config                                              公共样式
│   ├── GlobalColor.dart
│   └── GlobalThemeData.dart
├── main.dart                                           入口文件
├── network                                             网络层
│   ├── http.dart
│   ├── http_exception.dart
│   ├── http_interceptor.dart
│   ├── http_options.dart
│   └── http_request.dart
└── utils                                               工具包
    ├── nau_icon.dart
    └── shared_preferences_utils.dart