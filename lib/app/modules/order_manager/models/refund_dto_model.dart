import 'dart:convert';

RefundDto refundDtoFromJson(String str) => RefundDto.fromJson(json.decode(str));

String refundDtoToJson(RefundDto data) => json.encode(data.toJson());

class RefundDto {
    int amount;
    String reason;
    String orderId;

    RefundDto({
        required this.amount,
        required this.reason,
        required this.orderId,
    });

    factory RefundDto.fromJson(Map<String, dynamic> json) => RefundDto(
        amount: json["amount"],
        reason: json["reason"],
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "reason": reason,
        "orderId": orderId,
    };
}

