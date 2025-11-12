import 'dart:convert';

Banner bannerFromJson(String str) => Banner.fromJson(json.decode(str));

String bannerToJson(Banner data) => json.encode(data.toJson());

class Banner {
  Banner({
    this.data,
  });

  Data? data;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.success,
    this.data,
  });

  int? success;
  List<BannerData>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        data: List<BannerData>.from(
            json["data"].map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BannerData {
  BannerData({
    this.id,
    this.restaurantId,
    this.title,
    this.link,
    this.sort,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  int? id;
  int? restaurantId;
  String? title;
  String? link;
  int? sort;
  int? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? image;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        title: json["title"],
        link: json["link"] == null ? null : json["link"],
        sort: int.parse(json["sort"]),
        status: json["status"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "restaurant_id": restaurantId,
        "title": title,
        "link": link == null ? null : link,
        "sort": sort,
        "status": status,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "image": image,
      };
}
