// To parse this JSON data, do
//
//     final orderVo = orderVoFromJson(jsonString);

import 'dart:convert';

OrderVo orderVoFromJson(String str) => OrderVo.fromJson(json.decode(str));

String orderVoToJson(OrderVo data) => json.encode(data.toJson());

class OrderVo {
    int total;
    List<OrderItem> records;

    OrderVo({
        required this.total,
        required this.records,
    });

    factory OrderVo.fromJson(Map<String, dynamic> json) => OrderVo(
        total: json["total"],
        records: List<OrderItem>.from(json["records"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "records": List<dynamic>.from(records.map((x) => x.toJson())),
    };
}

class OrderItem {
    int id;
    int sitNum;
    String number;
    int status;
    int userId;
    int addressBookId;
    String orderTime;
    dynamic checkoutTime;
    int payMethod;
    int payStatus;
    double amount;
    String remark;
    dynamic userName;
    String phone;
    String address;
    String consignee;
    dynamic cancelReason;
    dynamic rejectionReason;
    dynamic cancelTime;
    String estimatedDeliveryTime;
    int deliveryStatus;
    dynamic deliveryTime;
    int packAmount;
    int tablewareNumber;
    int tablewareStatus;
    String orderDishes;
    dynamic orderDetailList;

    OrderItem({
        required this.id,
        required this.sitNum,
        required this.number,
        required this.status,
        required this.userId,
        required this.addressBookId,
        required this.orderTime,
        required this.checkoutTime,
        required this.payMethod,
        required this.payStatus,
        required this.amount,
        required this.remark,
        required this.userName,
        required this.phone,
        required this.address,
        required this.consignee,
        required this.cancelReason,
        required this.rejectionReason,
        required this.cancelTime,
        required this.estimatedDeliveryTime,
        required this.deliveryStatus,
        required this.deliveryTime,
        required this.packAmount,
        required this.tablewareNumber,
        required this.tablewareStatus,
        required this.orderDishes,
        required this.orderDetailList,
    });

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        sitNum: json["sitNum"],
        number: json["number"],
        status: json["status"],
        userId: json["userId"],
        addressBookId: json["addressBookId"],
        orderTime: json["orderTime"],
        checkoutTime: json["checkoutTime"],
        payMethod: json["payMethod"],
        payStatus: json["payStatus"],
        amount: json["amount"],
        remark: json["remark"],
        userName: json["userName"],
        phone: json["phone"],
        address: json["address"],
        consignee: json["consignee"],
        cancelReason: json["cancelReason"],
        rejectionReason: json["rejectionReason"],
        cancelTime: json["cancelTime"],
        estimatedDeliveryTime: json["estimatedDeliveryTime"],
        deliveryStatus: json["deliveryStatus"],
        deliveryTime: json["deliveryTime"],
        packAmount: json["packAmount"],
        tablewareNumber: json["tablewareNumber"],
        tablewareStatus: json["tablewareStatus"],
        orderDishes: json["orderDishes"],
        orderDetailList: json["orderDetailList"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "isitNumd": sitNum,
        "number": number,
        "status": status,
        "userId": userId,
        "addressBookId": addressBookId,
        "orderTime": orderTime,
        "checkoutTime": checkoutTime,
        "payMethod": payMethod,
        "payStatus": payStatus,
        "amount": amount,
        "remark": remark,
        "userName": userName,
        "phone": phone,
        "address": address,
        "consignee": consignee,
        "cancelReason": cancelReason,
        "rejectionReason": rejectionReason,
        "cancelTime": cancelTime,
        "estimatedDeliveryTime": estimatedDeliveryTime,
        "deliveryStatus": deliveryStatus,
        "deliveryTime": deliveryTime,
        "packAmount": packAmount,
        "tablewareNumber": tablewareNumber,
        "tablewareStatus": tablewareStatus,
        "orderDishes": orderDishes,
        "orderDetailList": orderDetailList,
    };
}
