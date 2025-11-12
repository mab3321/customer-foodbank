import 'dart:convert';

PopularRestaurant popularRestaurantFromJson(String str) => PopularRestaurant.fromJson(json.decode(str));

String popularRestaurantToJson(PopularRestaurant data) => json.encode(data.toJson());

class PopularRestaurant {
  PopularRestaurant({
    this.data,
  });

  Data? data;

  factory PopularRestaurant.fromJson(Map<String, dynamic> json) => PopularRestaurant(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.status,
    this.data,
  });

  int? status;
  List<Datum>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    this.name,
    this.slug,
    this.description,
    this.address,
    this.image,
    this.avgRating,
    this.avgRatingUser,
  });

  int? id;
  String? name;
  String? slug;
  String? description;
  String? address;
  String? image;
  int? avgRating;
  int? avgRatingUser;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    address: json["address"],
    image: json["image"],
    avgRating: json["avgRating"],
    avgRatingUser: json["avgRatingUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "address": address,
    "image": image,
    "avgRating": avgRating,
    "avgRatingUser": avgRatingUser,
  };
}
