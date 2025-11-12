// To parse this JSON data, do
//
//     final restaurantByCategory = restaurantByCategoryFromJson(jsonString);

import 'dart:convert';

RestaurantByCategory restaurantByCategoryFromJson(String str) => RestaurantByCategory.fromJson(json.decode(str));

String restaurantByCategoryToJson(RestaurantByCategory data) => json.encode(data.toJson());

class RestaurantByCategory {
  RestaurantByCategory({
    this.data,
  });

  RestaurantByCategoryData? data;

  factory RestaurantByCategory.fromJson(Map<String, dynamic> json) => RestaurantByCategory(
    data: RestaurantByCategoryData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class RestaurantByCategoryData {
  RestaurantByCategoryData({
    this.status,
    this.data,
  });

  int? status;
  DataData? data;

  factory RestaurantByCategoryData.fromJson(Map<String, dynamic> json) => RestaurantByCategoryData(
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
    this.category,
    this.restaurants,
  });

  String? siteTitle;
  Category? category;
  List<Restaurant>? restaurants;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    siteTitle: json["siteTitle"],
    category: Category.fromJson(json["category"]),
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "siteTitle": siteTitle,
    "category": category!.toJson(),
    "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.image,
  });

  int? id;
  String? title;
  String? slug;
  String? description;
  String? image;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "image": image,
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
    "id":id,
    "name": name,
    "description": description,
    "address": address,
    "image": image,
    "avgRating": avgRating,
    "avgRatingUser": avgRatingUser,
  };
}
