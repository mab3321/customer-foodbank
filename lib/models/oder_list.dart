import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  OrderList({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.orderCode,
    this.userId,
    this.total,
    this.subTotal,
    this.deliveryCharge,
    this.status,
    this.platform,
    this.deviceId,
    this.ip,
    this.paymentStatus,
    this.paidAmount,
    this.address,
    this.mobile,
    this.lat,
    this.long,
    this.misc,
    this.invoiceId,
    this.orderType,
    this.orderTypeName,
    this.restaurantId,
    this.deliveryBoyId,
    this.productReceived,
    this.paymentMethod,
    this.paymentMethodName,
    this.createdAt,
    this.updatedAt,
    this.statusName,
    this.createdAtConvert,
    this.updatedAtConvert,
    this.items,
  });

  int? id;
  String? orderCode;
  int? userId;
  String? total;
  String? subTotal;
  String? deliveryCharge;
  int? status;
  dynamic platform;
  dynamic deviceId;
  dynamic ip;
  int? paymentStatus;
  String? paidAmount;
  String? address;
  String? mobile;
  String? lat;
  String? long;
  String? misc;
  String? invoiceId;
  String? orderType;
  String? orderTypeName;
  String? paymentMethodName;
  int? restaurantId;
  int? deliveryBoyId;
  int? productReceived;
  int? paymentMethod;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusName;
  String? createdAtConvert;
  String? updatedAtConvert;
  List<Item>? items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderCode: json["order_code"].toString(),
        total: json["total"],
        subTotal: json["sub_total"],
        deliveryCharge: json["delivery_charge"],
        status: json["status"],
        platform: json["platform"],
        deviceId: json["device_id"],
        ip: json["ip"],
        paymentStatus: json["payment_status"],
        paidAmount: json["paid_amount"],
        address: json["address"],
        mobile: json["mobile"],
        lat: json["lat"],
        long: json["long"],
        misc: json["misc"],
        invoiceId: json["invoice_id"],
        orderType: json["invoice_id"],
        orderTypeName: json["order_type_name"],
        restaurantId: json["restaurant_id"],
        deliveryBoyId:
            json["delivery_boy_id"] == null ? null : json["delivery_boy_id"],
        productReceived: json["product_received"],
        paymentMethodName: json["payment_method_name"],
        paymentMethod: json["payment_method"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        statusName: json["status_name"],
        createdAtConvert: json["created_at_convert"],
        updatedAtConvert: json["updated_at_convert"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_code": orderCode,
        "total": total,
        "sub_total": subTotal,
        "delivery_charge": deliveryCharge,
        "status": status,
        "platform": platform,
        "device_id": deviceId,
        "ip": ip,
        "payment_status": paymentStatus,
        "paid_amount": paidAmount,
        "address": address,
        "mobile": mobile,
        "lat": lat,
        "long": long,
        "misc": misc,
        "invoice_id": invoiceId,
        "order_type": orderType,
        "order_type_name": orderTypeName,
        "restaurant_id": restaurantId,
        "delivery_boy_id": deliveryBoyId == null ? null : deliveryBoyId,
        "product_received": productReceived,
        "payment_method": paymentMethod,
        "payment_method_name": paymentMethodName,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "status_name": statusName,
        "created_at_convert": createdAtConvert,
        "updated_at_convert": updatedAtConvert,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.orderId,
    this.restaurantId,
    this.menuItemId,
    this.quantity,
    this.unitPrice,
    this.discountedPrice,
    this.itemTotal,
    this.menuItemVariationId,
    this.options,
    this.optionsTotal,
    this.createdAt,
    this.updatedAt,
    this.createdAtConvert,
    this.updatedAtConvert,
    this.menuItem,
    this.restaurant,
  });

  int? id;
  int? orderId;
  int? restaurantId;
  int? menuItemId;
  int? quantity;
  String? unitPrice;
  String? discountedPrice;
  String? itemTotal;
  int? menuItemVariationId;
  String? options;
  int? optionsTotal;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdAtConvert;
  String? updatedAtConvert;
  MenuItem? menuItem;
  Restaurant? restaurant;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        restaurantId: json["restaurant_id"],
        menuItemId: json["menu_item_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        discountedPrice: json["discounted_price"],
        itemTotal: json["item_total"],
        menuItemVariationId: json["menu_item_variation_id"],
        options: json["options"],
        optionsTotal: json["options_total"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtConvert: json["created_at_convert"],
        updatedAtConvert: json["updated_at_convert"],
        menuItem: MenuItem.fromJson(json["menu_item"]),
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "restaurant_id": restaurantId,
        "menu_item_id": menuItemId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "discounted_price": discountedPrice,
        "item_total": itemTotal,
        "menu_item_variation_id": menuItemVariationId,
        "options": options,
        "options_total": optionsTotal,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_convert": createdAtConvert,
        "updated_at_convert": updatedAtConvert,
        "menu_item": menuItem!.toJson(),
        "restaurant": restaurant!.toJson(),
      };
}

class MenuItem {
  MenuItem({
    this.id,
    this.restaurantId,
    this.cuisineId,
    this.name,
    this.slug,
    this.description,
    this.unitPrice,
    this.discountPrice,
    this.quantity,
    this.counter,
    this.status,
    this.tags,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  int? id;
  int? restaurantId;
  dynamic cuisineId;
  String? name;
  String? slug;
  String? description;
  String? unitPrice;
  String? discountPrice;
  int? quantity;
  int? counter;
  int? status;
  dynamic tags;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? image;

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        cuisineId: json["cuisine_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        unitPrice: json["unit_price"],
        discountPrice: json["discount_price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        counter: json["counter"],
        status: json["status"],
        tags: json["tags"],
        order: json["order"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "cuisine_id": cuisineId,
        "name": name,
        "slug": slug,
        "description": description,
        "unit_price": unitPrice,
        "discount_price": discountPrice,
        "quantity": quantity == null ? null : quantity,
        "counter": counter,
        "status": status,
        "tags": tags,
        "order": order,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "image": image,
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.userId,
    this.name,
    this.slug,
    this.description,
    this.deliveryCharge,
    this.lat,
    this.long,
    this.openingTime,
    this.closingTime,
    this.address,
    this.status,
    this.currentStatus,
    this.deliveryStatus,
    this.pickupStatus,
    this.tableStatus,
    this.applied,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? name;
  String? slug;
  String? description;
  int? deliveryCharge;
  String? lat;
  String? long;
  String? openingTime;
  String? closingTime;
  String? address;
  int? status;
  int? currentStatus;
  int? deliveryStatus;
  int? pickupStatus;
  int? tableStatus;
  int? applied;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        deliveryCharge: json["delivery_charge"],
        lat: json["lat"],
        long: json["long"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        address: json["address"],
        status: json["status"],
        currentStatus: json["current_status"],
        deliveryStatus: json["delivery_status"],
        pickupStatus: json["pickup_status"],
        tableStatus: json["table_status"],
        applied: json["applied"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "slug": slug,
        "description": description,
        "delivery_charge": deliveryCharge,
        "lat": lat,
        "long": long,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "address": address,
        "status": status,
        "current_status": currentStatus,
        "delivery_status": deliveryStatus,
        "pickup_status": pickupStatus,
        "table_status": tableStatus,
        "applied": applied,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
