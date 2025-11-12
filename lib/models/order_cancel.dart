import 'dart:convert';

OrderCancel orderCancelFromJson(String str) => OrderCancel.fromJson(json.decode(str));

String orderCancelToJson(OrderCancel data) => json.encode(data.toJson());

class OrderCancel {
    OrderCancel({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory OrderCancel.fromJson(Map<String, dynamic> json) => OrderCancel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
