/*
 * @Author: dfh
 * @Date: 2024-10-09 11:04:54
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../../bean/options_model.dart';
import '../../../components/button_small_widget.dart';
import '../../../components/text_form_field_selected_widget.dart';
import '../../../components/text_form_field_widget.dart';
import '../controllers/employee_manager_controller.dart';

class AddEditorEmployee extends StatelessWidget {
  final EmployeeManagerController controller;

  AddEditorEmployee({super.key, required this.controller});

  final GlobalKey _formKey = GlobalKey<FormState>();

  final List<OptionsBean> options = [
    OptionsBean(value: '0', label: '男'),
    OptionsBean(value: '1', label: '女'),
  ];

  final List<OptionsBean> roleOptions = [
    OptionsBean(value: '0', label: '普通用户'),
    OptionsBean(value: '1', label: '管理员'),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 440,
                      child: TextFormFieldWidget(
                        label: '员工账号',
                        text: controller.employeeDto.value.username ?? '',
                        required: true,
                        onChange: (String v) {
                          controller.employeeDto.value.username = v;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 440,
                      child: TextFormFieldWidget(
                        label: '员工姓名',
                        text: controller.employeeDto.value.name ?? '',
                        required: true,
                        onChange: (String v) {
                          controller.employeeDto.value.name = v;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 440,
                      child: TextFormFieldWidget(
                        label: '员工手机号',
                        text: controller.employeeDto.value.phone ?? '',
                        required: true,
                        onChange: (String v) {
                          controller.employeeDto.value.phone = v;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 440,
                      child: TextFormFieldWidget(
                        label: '员工身份证号',
                        text: controller.employeeDto.value.idNumber ?? '',
                        required: false,
                        onChange: (String v) {
                          controller.employeeDto.value.idNumber = v;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 440,
                      child: TextFormFieldSelectedWidget(
                        label: "员工性别",
                        text: controller.employeeDto.value.sex ?? '',
                        required: true,
                        options: options,
                        callback: (String? txt) {
                          controller.employeeDto.value.sex = txt!;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 440,
                      child: TextFormFieldSelectedWidget(
                        label: "员工角色",
                        text: controller.employeeDto.value.role == null
                            ? '1'
                            : '0',
                        required: true,
                        options: roleOptions,
                        callback: (String? txt) {
                          controller.employeeDto.value.role = int.parse(txt!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 360,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonSmallWidget(
                      text: '取消',
                      backgroundColor: Colors.grey,
                      color: Colors.white,
                      onPressed: () {
                        controller.isEditor.value = false;
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ButtonSmallWidget(
                      text: '确定',
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          controller.saveOrUpdateEmployee();
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
