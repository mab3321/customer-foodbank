import 'dart:convert';

RestaurantSearch restaurantSearchFromJson(String str) =>
    RestaurantSearch.fromJson(json.decode(str));

String restaurantSearchToJson(RestaurantSearch data) =>
    json.encode(data.toJson());

class RestaurantSearch {
  RestaurantSearch({
    this.data,
  });

  Data? data;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
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
  List<Restaurant>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        data: List<Restaurant>.from(
            json["data"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Restaurant {
  Restaurant({
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

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
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
