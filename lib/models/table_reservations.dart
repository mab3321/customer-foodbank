class TableReservation {
  TableReservation({
    this.data,
  });

  TableReservation.fromJson(dynamic json) {
    data = json['data'] != null
        ? TableReservationData.fromJson(json['data'])
        : null;
  }
  TableReservationData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class TableReservationData {
  TableReservationData({
    this.status,
    this.data,
  });

  TableReservationData.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ReservationDatum.fromJson(v));
      });
    }
  }
  int? status;
  List<ReservationDatum>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ReservationDatum {
  ReservationDatum({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.statusName,
    this.createdAt,
    this.slot,
    this.table,
    this.guest,
    this.restaurantAddress,
    this.restaurantName,
    this.restaurantPhone,
    this.restaurantEmail,
    this.restaurantOpeningTime,
    this.restaurantClosingTime,
  });

  ReservationDatum.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
    statusName = json['status_name'];
    createdAt = json['reservation_date'];
    slot = json['slot'];
    table = json['table'];
    guest = json['guest'];
    restaurantAddress = json['restaurant_address'];
    restaurantName = json['restaurant_name'];
    restaurantPhone = json['restaurant_phone'];
    restaurantEmail = json['restaurant_email'];
    restaurantOpeningTime = json['restaurant_opening_time'];
    restaurantClosingTime = json['restaurant_closing_time'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  int? status;
  String? statusName;
  String? createdAt;
  String? slot;
  String? table;
  int? guest;
  String? restaurantAddress;
  String? restaurantName;
  String? restaurantPhone;
  String? restaurantEmail;
  String? restaurantOpeningTime;
  String? restaurantClosingTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['status'] = status;
    map['status_name'] = statusName;
    map['reservation_date'] = createdAt;
    map['slot'] = slot;
    map['table'] = table;
    map['guest'] = guest;
    map['restaurant_address'] = restaurantAddress;
    map['restaurant_name'] = restaurantName;
    map['restaurant_phone'] = restaurantPhone;
    map['restaurant_email'] = restaurantEmail;
    map['restaurant_opening_time'] = restaurantOpeningTime;
    map['restaurant_closing_time'] = restaurantClosingTime;
    return map;
  }
}
