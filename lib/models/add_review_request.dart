import 'dart:convert';

AddReviewRequest addReviewRequestFromJson(String str) => AddReviewRequest.fromJson(json.decode(str));

String addReviewRequestToJson(AddReviewRequest data) => json.encode(data.toJson());

class AddReviewRequest {
    AddReviewRequest({
        this.rating,
        this.review,
        this.userId,
        this.restaurantId,
    });

    double? rating;
    String? review;
    int? userId;
    int? restaurantId;

    factory AddReviewRequest.fromJson(Map<String, dynamic> json) => AddReviewRequest(
        rating: json["rating"],
        review: json["review"],
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
    );

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "review": review,
        "user_id": userId,
        "restaurant_id": restaurantId,
    };
}
