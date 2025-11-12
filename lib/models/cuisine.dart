
class CuisineData {
  int? status;
  List<CuisineDataModel>? cuisineList;

  CuisineData({
    this.status,
    this.cuisineList});

  CuisineData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      cuisineList = <CuisineDataModel>[];
      json['data'].forEach((v) {
        cuisineList!.add(CuisineDataModel.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['status'] = status;
    if (this.cuisineList != null) {
      map['data'] = this.cuisineList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CuisineDataModel {
  CuisineDataModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,});

  CuisineDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
  }
  int? id;
  String? name;
  String? slug;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    return map;
  }

}