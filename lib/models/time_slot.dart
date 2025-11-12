import 'dart:convert';

TimeSlot timeSlotFromJson(String str) => TimeSlot.fromJson(json.decode(str));

String timeSlotToJson(TimeSlot data) => json.encode(data.toJson());

class TimeSlot {
  TimeSlot({
    this.data,
  });

  Data? data;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
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
  List<TimeSlotList>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        data: List<TimeSlotList>.from(
            json["data"].map((x) => TimeSlotList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TimeSlotList {
  TimeSlotList({
    this.id,
    this.datumStartTime,
    this.datumEndTime,
    this.startTime,
    this.endTime,
  });

  int? id;
  String? datumStartTime;
  String? datumEndTime;
  String? startTime;
  String? endTime;

  factory TimeSlotList.fromJson(Map<String, dynamic> json) => TimeSlotList(
        id: json["id"],
        datumStartTime: json["start_time"],
        datumEndTime: json["end_time"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": datumStartTime,
        "end_time": datumEndTime,
        "startTime": startTime,
        "endTime": endTime,
      };
}
