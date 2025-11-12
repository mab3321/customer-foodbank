class AddressModel {
  AddressModel({
    this.status,
    this.data,
  });

  AddressModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(AddressData.fromJson(v));
      });
    }
  }
  dynamic status;
  List<AddressData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AddressData {
  AddressData({
    this.id,
    this.label,
    this.labelName,
    this.address,
    this.apartment,
    this.lat,
    this.long,
  });

  AddressData.fromJson(dynamic json) {
    id = json['id'];
    label = json['label'].toString();
    labelName = json['label_name'].toString();
    address = json['address'].toString();
    apartment = json['apartment'].toString();
    lat = json['lat'].toString();
    long = json['long'].toString();
  }
  int? id;
  String? label;
  String? labelName;
  String? address;
  String? apartment;
  String? lat;
  String? long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    map['label_name'] = labelName;
    map['address'] = address;
    map['apartment'] = apartment;
    map['lat'] = lat;
    map['long'] = long;
    return map;
  }
}
