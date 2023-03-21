// To parse this JSON data, do
//
//     final actionValidationModel = actionValidationModelFromJson(jsonString);

import 'dart:convert';

ActionValidationModel actionValidationModelFromJson(String str) => ActionValidationModel.fromJson(json.decode(str));

String actionValidationModelToJson(ActionValidationModel data) => json.encode(data.toJson());

class ActionValidationModel {
  ActionValidationModel({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory ActionValidationModel.fromJson(Map<String, dynamic> json) => ActionValidationModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.validations,
  });

  List<Validation> validations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    validations: List<Validation>.from(json["validations"].map((x) => Validation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "validations": List<dynamic>.from(validations.map((x) => x.toJson())),
  };
}

class Validation {
  Validation({
    required this.idValidation,
    required this.nameAction,
    required this.action,
  });

  String idValidation;
  String nameAction;
  String action;

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
    idValidation: json["id_validation"],
    nameAction: json["nameAction"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "id_validation": idValidation,
    "nameAction": nameAction,
    "action": action,
  };
}
