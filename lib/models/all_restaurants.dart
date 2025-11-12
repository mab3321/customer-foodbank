class AllRestaurants {
  int? id;
  String? title;
  String? description;
  double? rating;
  double? reviews;

  String? image;

  AllRestaurants({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.image,
    this.reviews,
  });

  AllRestaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    title = json['Description'];

    rating = json['rating'];
    image = json['image'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['Description'] = this.description;
    data['rating'] = this.rating;
    data['image'] = this.image;
    data['reviews'] = this.reviews;
    return data;
  }
}
