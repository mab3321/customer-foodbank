import 'dart:convert';

RestaurantDetails restaurantDetailsFromJson(String str) =>
    RestaurantDetails.fromJson(json.decode(str));

String restaurantDetailsToJson(RestaurantDetails data) =>
    json.encode(data.toJson());

class RestaurantDetails {
  RestaurantDetails({this.data});

  RestaurantDetailsData? data;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(data: RestaurantDetailsData.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"data": data!.toJson()};
}

class RestaurantDetailsData {
  RestaurantDetailsData({this.status, this.data});

  int? status;
  RestaurantData? data;

  factory RestaurantDetailsData.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailsData(
        status: json["status"],
        data: RestaurantData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data!.toJson()};
}

class RestaurantData {
  RestaurantData({
    this.siteTitle,
    this.restaurant,
    this.menuItems,
    this.reviews,
    this.vouchers,
    this.countUser,
    this.avgRating,
    this.orderStatus,
  });

  String? siteTitle;
  Restaurant? restaurant;
  List<MenuItemData>? menuItems;
  List<Review>? reviews;
  List<Vouchers>? vouchers;
  int? countUser;
  int? avgRating;
  bool? orderStatus;

  factory RestaurantData.fromJson(Map<String, dynamic> json) => RestaurantData(
    siteTitle: json["siteTitle"],
    restaurant: Restaurant.fromJson(json["restaurant"]),
    menuItems: List<MenuItemData>.from(
      json["menuItems"].map((x) => MenuItemData.fromJson(x)),
    ),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    vouchers: List<Vouchers>.from(
      json["vouchers"].map((x) => Vouchers.fromJson(x)),
    ),
    countUser: json["countUser"],
    avgRating: json["avgRating"],
    orderStatus: json["order_status"],
  );

  Map<String, dynamic> toJson() => {
    "siteTitle": siteTitle,
    "restaurant": restaurant!.toJson(),
    "menuItems": List<dynamic>.from(menuItems!.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "vouchers": List<dynamic>.from(vouchers!.map((x) => x.toJson())),
    "countUser": countUser,
    "avgRating": avgRating,
    "order_status": orderStatus,
  };
}

class MenuItemData {
  MenuItemData({
    this.id,
    this.name,
    this.slug,
    this.unitPrice,
    this.discountPrice,
    this.currencyCode,
    this.image,
    this.description,
  });

  int? id;
  String? name;
  String? slug;
  String? unitPrice;
  String? discountPrice;
  CurrencyCode? currencyCode;
  String? image;
  String? description;

  factory MenuItemData.fromJson(Map<String, dynamic> json) => MenuItemData(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    unitPrice: json["unit_price"],
    discountPrice: json["discount_price"],
    currencyCode: currencyCodeValues.map![json["currency_code"]],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "unit_price": unitPrice,
    "discount_price": discountPrice,
    "currency_code": currencyCodeValues.reverse[currencyCode],
    "image": image,
    "description": description,
  };
}

enum CurrencyCode { EMPTY }

final currencyCodeValues = EnumValues({"\u0024": CurrencyCode.EMPTY});

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.userId,
    this.description,
    this.deliveryCharge,
    this.freeDeliveryRadius,
    this.chargePerKilo,
    this.lat,
    this.long,
    this.deliveryStatus,
    this.pickupStatus,
    this.openingTime,
    this.closingTime,
    this.address,
    this.status,
    this.currentStatus,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.logo,
    this.cuisines,
    this.tableStatus,
  });

  int? id;
  String? name;
  int? userId;
  String? description;
  String? deliveryCharge;
  String? freeDeliveryRadius;
  String? chargePerKilo;
  String? lat;
  String? long;
  int? deliveryStatus;
  int? pickupStatus;
  String? openingTime;
  String? closingTime;
  String? address;
  String? status;
  String? currentStatus;
  String? createdAt;
  String? updatedAt;
  String? image;
  String? logo;
  int? tableStatus;
  List<dynamic>? cuisines;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    tableStatus: json["table_status"],
    name: json["name"],
    userId: json["user_id"],
    description: json["description"],
    deliveryCharge: json["delivery_charge"],
    freeDeliveryRadius: json["free_delivery_radius"],
    chargePerKilo: json["charge_per_kilo"],
    lat: json["lat"],
    long: json["long"],
    deliveryStatus: json["delivery_status"],
    pickupStatus: json["pickup_status"],
    openingTime: json["opening_time"],
    closingTime: json["closing_time"],
    address: json["address"],
    status: json["status"],
    currentStatus: json["current_status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    image: json["image"],
    logo: json["logo"],
    cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["id"] = id;
    map["table_status"] = tableStatus;
    map["name"] = name;
    map["user_id"] = userId;
    map["description"] = description;
    map["delivery_charge"] = deliveryCharge;
    map["free_delivery_radius"] = freeDeliveryRadius;
    map["charge_per_kilo"] = chargePerKilo;
    map["lat"] = lat;
    map["long"] = long;
    map["delivery_status"] = deliveryStatus;
    map["pickup_status"] = pickupStatus;
    map["opening_time"] = openingTime;
    map["closing_time"] = closingTime;
    map["address"] = address;
    map["status"] = status;
    map["current_status"] = currentStatus;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["image"] = image;
    map["logo"] = logo;
    map["cuisine"] = List<dynamic>.from(cuisines!.map((x) => x));
    return map;
  }
}

class Review {
  Review({
    this.id,
    this.restaurantId,
    this.rating,
    this.userId,
    this.user,
    this.userImage,
    this.image,
    this.review,
    this.createdAt,
  });

  int? id;
  int? restaurantId;
  int? rating;
  int? userId;
  String? user;
  String? userImage;
  dynamic image;
  String? review;
  String? createdAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    restaurantId: json["restaurant_id"],
    rating: json["rating"],
    userId: json["user_id"],
    user: json["user"],
    userImage: json["userImage"],
    image: json["image"],
    review: json["review"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "restaurant_id": restaurantId,
    "rating": rating,
    "user_id": userId,
    "user": user,
    "userImage": userImage,
    "image": image,
    "review": review,
    "created_at": createdAt,
  };
}

class Vouchers {
  Vouchers({
    this.id,
    this.branchId,
    this.discountType,
    this.couponType,
    this.couponTypeName,
    this.name,
    this.slug,
    this.minimumOrderAmount,
    this.amount,
  });

  Vouchers.fromJson(dynamic json) {
    id = json['id'];
    branchId = json['branch_id'].toString();
    discountType = json['discount_type'].toString();
    couponType = json['coupon_type'].toString();
    couponTypeName = json['coupon_type_name'].toString();
    name = json['name'].toString();
    slug = json['slug'];
    minimumOrderAmount = json['minimum_order_amount'].toString();
    amount = json['amount'].toString();
  }
  int? id;
  String? branchId;
  String? discountType;
  String? couponType;
  String? couponTypeName;
  String? name;
  String? slug;
  String? minimumOrderAmount;
  String? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['branch_id'] = branchId;
    map['discount_type'] = discountType;
    map['coupon_type'] = couponType;
    map['coupon_type_name'] = couponTypeName;
    map['name'] = name;
    map['slug'] = slug;
    map['minimum_order_amount'] = minimumOrderAmount;
    map['amount'] = amount;
    return map;
  }
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
