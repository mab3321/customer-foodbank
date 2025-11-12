class Profile {
  Profile({
      this.data,});

  Profile.fromJson(dynamic json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }
  ProfileData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class ProfileData {
  ProfileData({
      this.status, 
      this.data,});

  ProfileData.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.email, 
      this.username, 
      this.phone, 
      this.address, 
      this.name, 
      this.status, 
      this.applied, 
      this.totalOrders, 
      this.totalReservations, 
      this.image, 
      this.myrole, 
      this.balance, 
      this.depositAmount, 
      this.limitAmount, 
      this.mystatus,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    address = json['address'];
    name = json['name'];
    status = json['status'];
    applied = json['applied'];
    totalOrders = json['totalOrders'];
    totalReservations = json['totalReservations'];
    image = json['image'];
    myrole = json['myrole'];
    balance = json['balance'];
    depositAmount = json['deposit_amount'];
    limitAmount = json['limit_amount'];
    mystatus = json['mystatus'];
  }
  int? id;
  String? email;
  String? username;
  String? phone;
  dynamic address;
  String? name;
  int? status;
  int? applied;
  int? totalOrders;
  int? totalReservations;
  String? image;
  String? myrole;
  String? balance;
  String? depositAmount;
  String? limitAmount;
  String? mystatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['phone'] = phone;
    map['address'] = address;
    map['name'] = name;
    map['status'] = status;
    map['applied'] = applied;
    map['totalOrders'] = totalOrders;
    map['totalReservations'] = totalReservations;
    map['image'] = image;
    map['myrole'] = myrole;
    map['balance'] = balance;
    map['deposit_amount'] = depositAmount;
    map['limit_amount'] = limitAmount;
    map['mystatus'] = mystatus;
    return map;
  }

}