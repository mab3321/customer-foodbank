// To parse this JSON data, do
//
//     final restaurantByCuisine = restaurantByCuisineFromJson(jsonString);

import 'dart:convert';

RestaurantByCuisine restaurantByCuisineFromJson(String str) => RestaurantByCuisine.fromJson(json.decode(str));

String restaurantByCuisineToJson(RestaurantByCuisine data) => json.encode(data.toJson());

class RestaurantByCuisine {
  RestaurantByCuisine({
    this.data,
  });

  RestaurantByCuisineData? data;

  factory RestaurantByCuisine.fromJson(Map<String, dynamic> json) => RestaurantByCuisine(
    data: RestaurantByCuisineData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class RestaurantByCuisineData {
  RestaurantByCuisineData({
    this.status,
    this.data,
  });

  int? status;
  DataData? data;

  factory RestaurantByCuisineData.fromJson(Map<String, dynamic> json) => RestaurantByCuisineData(
    status: json["status"],
    data: DataData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class DataData {
  DataData({
    this.siteTitle,
    this.cuisine,
    this.restaurants,
  });

  String? siteTitle;
  Cuisine? cuisine;
  List<Restaurant>? restaurants;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    siteTitle: json["siteTitle"],
    cuisine: Cuisine.fromJson(json["cuisine"]),
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "siteTitle": siteTitle,
    "cuisine": cuisine!.toJson(),
    "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
  };
}

class Cuisine {
  Cuisine({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.description,
  });

  int? id;
  String? name;
  String? slug;
  String? image;
  String? description;

  factory Cuisine.fromJson(Map<String, dynamic> json) => Cuisine(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "description": description,
  };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.address,
    this.image,
    this.avgRating,
    this.avgRatingUser,
  });

  int? id;
  String? name;
  String? description;
  String? address;
  String? image;
  int? avgRating;
  int? avgRatingUser;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    address: json["address"],
    image: json["image"],
    avgRating: json["avgRating"],
    avgRatingUser: json["avgRatingUser"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "address": address,
    "image": image,
    "avgRating": avgRating,
    "avgRatingUser": avgRatingUser,
  };
}
