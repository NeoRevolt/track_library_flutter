// To parse this JSON data, do
//
//     final addLogRequestModel = addLogRequestModelFromJson(jsonString);

import 'dart:convert';

AddLogRequestModel addLogRequestModelFromJson(String str) => AddLogRequestModel.fromJson(json.decode(str));

String addLogRequestModelToJson(AddLogRequestModel data) => json.encode(data.toJson());

class AddLogRequestModel {
  AddLogRequestModel({
    required this.nameAction,
    required this.action,
  });

  String nameAction;
  String action;

  factory AddLogRequestModel.fromJson(Map<String, dynamic> json) => AddLogRequestModel(
    nameAction: json["nameAction"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "nameAction": nameAction,
    "action": action,
  };
}
