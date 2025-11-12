class Menu{
  int? id;
  String? title;
  String? description;
  String? price;
  double? rating;
  String? image;
  String? reviews;


  Menu({this.id, this.title, this.description, this.price, this.rating,
      this.image, this.reviews});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title = json['description'];
    title = json['price'];

    rating = json['rating'];
    image = json['image'];
   reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['price'] = this.price;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['reviews'] = this.reviews;
    return data;
  }
}
