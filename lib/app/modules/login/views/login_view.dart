import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final GlobalKey _formKey = GlobalKey<FormState>();

  void _loginHandle() {
    if ((_formKey.currentState as FormState).validate()) {
      //验证通过提交数据
      controller.fetchLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(1920, 1080));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(255, 190, 233, 191),
        child: Center(
          child: Container(
            width: 1400.w,
            height: 574.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    child: Image.asset(
                      'images/login_bg.jpeg',
                      fit: BoxFit.cover,
                      height: 574.h,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/logo2.png',
                        fit: BoxFit.contain,
                        width: 139.w,
                        height: 139.w,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Form(
                          key: _formKey, //设置globalKey，用于后面获取FormState
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: '账号',
                                  hintText: "请输入您的账号",
                                  prefixIcon: Icon(
                                    Icons.person,
                                    size: 24,
                                  ),
                                ),
                                validator: (v) {
                                  return v!.trim().isNotEmpty ? null : "账号不能为空";
                                },
                                onChanged: (v) {
                                  controller.loginDTO.value.username = v;
                                },
                              ),
                              const SizedBox(height: 20,),
                              TextFormField(
                                obscureText:true,
                                decoration: const InputDecoration(
                                  labelText: '密码',
                                  hintText: "请输入您的密码",
                                  
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: 24,
                                  ),
                                ),
                                validator: (v) {
                                  return v!.trim().isNotEmpty ? null : "账号密码为空";
                                },
                                onChanged: (v) {
                                  controller.loginDTO.value.password = v;
                                },
                              ),
                              Container(
                                height: 50.h,
                                margin: EdgeInsets.only(top: 40.h),
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _loginHandle,
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.h))),
                                    textStyle:
                                        MaterialStateProperty.all<TextStyle>(
                                            const TextStyle(fontSize: 16)),
                                  ),
                                  child: const Text("登 录"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
