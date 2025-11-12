
class CategoryData {
  int? status;
  List<CategoryDataModel>? categoriesList;

  CategoryData({
      this.status, 
      this.categoriesList});

  CategoryData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      categoriesList = <CategoryDataModel>[];
      json['data'].forEach((v) {
        categoriesList!.add(CategoryDataModel.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['status'] = status;
    if (this.categoriesList != null) {
      map['data'] = this.categoriesList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class CategoryDataModel {
  CategoryDataModel({
      this.id, 
      this.title, 
      this.slug, 
      this.description, 
      this.image,});

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
  }
  int? id;
  String? title;
  String? slug;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    return map;
  }

}