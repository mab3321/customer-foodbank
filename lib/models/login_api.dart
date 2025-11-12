class LoginApi {
  LoginApi({
    this.status,
    this.message,
    this.data,
    this.token,
    this.restaurant,
  });

  LoginApi.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    token = json['token'];
    if (json['restaurant'] != null) {
      restaurant = [];
      json['restaurant'].forEach((v) {
        // restaurant?.add(dynamic.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  Data? data;
  String? token;
  List<dynamic>? restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['token'] = token;
    if (restaurant != null) {
      map['restaurant'] = restaurant?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.image,
    this.address,
    this.status,
    this.applied,
    this.myrole,
    this.mystatus,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    username = json['username'];
    image = json['image'];
    address = json['address'];
    status = json['status'];
    applied = json['applied'];
    myrole = json['myrole'];
    mystatus = json['mystatus'];
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? image;
  dynamic address;
  int? status;
  int? applied;
  String? myrole;
  String? mystatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['username'] = username;
    map['image'] = image;
    map['address'] = address;
    map['status'] = status;
    map['applied'] = applied;
    map['myrole'] = myrole;
    map['mystatus'] = mystatus;
    return map;
  }
}
