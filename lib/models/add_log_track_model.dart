// To parse this JSON data, do
//
//     final addLogTrackModel = addLogTrackModelFromJson(jsonString);

import 'dart:convert';

AddLogTrackModel addLogTrackModelFromJson(String str) => AddLogTrackModel.fromJson(json.decode(str));

String addLogTrackModelToJson(AddLogTrackModel data) => json.encode(data.toJson());

class AddLogTrackModel {
  AddLogTrackModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory AddLogTrackModel.fromJson(Map<String, dynamic> json) => AddLogTrackModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
