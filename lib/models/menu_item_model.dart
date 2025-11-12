class MenuItem {
  MenuItem({this.data});

  MenuItem.fromJson(dynamic json) {
    data = json['data'] != null ? MenuItemData.fromJson(json['data']) : null;
  }
  MenuItemData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class MenuItemData {
  MenuItemData({this.status, this.data});

  MenuItemData.fromJson(dynamic json) {
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
    this.name,
    this.slug,
    this.unitPrice,
    this.discountPrice,
    this.currencyCode,
    this.image,
    this.description,
    this.variations,
    this.options,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    unitPrice = json['unit_price'];
    discountPrice = json['discount_price'];
    currencyCode = json['currency_code'];
    image = json['image'];
    description = json['description'];
    if (json['variations'] != null) {
      variations = [];
      json['variations'].forEach((v) {
        variations?.add(Variations.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = [];
      json['options'].forEach((v) {
        options?.add(Options.fromJson(v));
      });
    }
  }
  int? id;
  String? name;
  String? slug;
  String? unitPrice;
  String? discountPrice;
  String? currencyCode;
  String? image;
  String? description;
  List<Variations>? variations;
  List<Options>? options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['unit_price'] = unitPrice;
    map['discount_price'] = discountPrice;
    map['currency_code'] = currencyCode;
    map['image'] = image;
    map['description'] = description;
    if (variations != null) {
      map['variations'] = variations?.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      map['options'] = options?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Options {
  Options({this.id, this.name, this.price, this.currencyCode});

  Options.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['unit_price'];
    currencyCode = json['currency_code'];
  }
  int? id;
  String? name;
  String? price;
  String? currencyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['currency_code'] = currencyCode;
    return map;
  }
}

class Variations {
  Variations({
    this.id,
    this.name,
    this.unitPrice,
    this.currencyCode,
    this.discountPrice,
  });

  Variations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    unitPrice = json['unit_price'];
    currencyCode = json['currency_code'];
    discountPrice = json['discount_price'];
  }
  int? id;
  String? name;
  String? unitPrice;
  String? currencyCode;
  String? discountPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['unit_price'] = unitPrice;
    map['currency_code'] = currencyCode;
    map['discount_price'] = discountPrice;
    return map;
  }
}
