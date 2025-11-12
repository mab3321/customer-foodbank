import 'dart:convert';

AddReview addReviewFromJson(String str) => AddReview.fromJson(json.decode(str));

String addReviewToJson(AddReview data) => json.encode(data.toJson());

class AddReview {
    AddReview({
        this.status,
        this.message,
    });

    int? status;
    String? message;

    factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
