// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

SignUpModel registerModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String registerModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    SignUpModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        mainCode: json["mainCode"] == null ? null : json["mainCode"],
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"] == null ? null : List<Error>.from(json["error"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mainCode": mainCode == null ? null : mainCode,
        "code": code == null ? null : code,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error == null ? null : List<dynamic>.from(error.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.countryId,
        this.truckleId,
        this.identity,
        this.license,
        this.carForm,
        this.transportationCard,
        this.insurance,
        this.active,
        this.type,
        this.countRate,
        this.apiToken,
        this.createdAt,
    });

    int id;
    String name;
    String lastName;
    String email;
    String phoneNumber;
    String countryId;
    String truckleId;
    String identity;
    String license;
    String carForm;
    String transportationCard;
    String insurance;
    int active;
    int type;
    int countRate;
    String apiToken;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        countryId: json["country_id"] == null ? null : json["country_id"],
        truckleId: json["truckle_id"] == null ? null : json["truckle_id"],
        identity: json["identity"] == null ? null : json["identity"],
        license: json["license"] == null ? null : json["license"],
        carForm: json["car_form"] == null ? null : json["car_form"],
        transportationCard: json["transportation_card"] == null ? null : json["transportation_card"],
        insurance: json["insurance"] == null ? null : json["insurance"],
        active: json["active"] == null ? null : json["active"],
        type: json["type"] == null ? null : json["type"],
        countRate: json["count_rate"] == null ? null : json["count_rate"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "country_id": countryId == null ? null : countryId,
        "truckle_id": truckleId == null ? null : truckleId,
        "identity": identity == null ? null : identity,
        "license": license == null ? null : license,
        "car_form": carForm == null ? null : carForm,
        "transportation_card": transportationCard == null ? null : transportationCard,
        "insurance": insurance == null ? null : insurance,
        "active": active == null ? null : active,
        "type": type == null ? null : type,
        "count_rate": countRate == null ? null : countRate,
        "api_token": apiToken == null ? null : apiToken,
        "created_at": createdAt == null ? null : "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    };
}


class Error {
    Error({
        this.key,
        this.value,
    });

    String key;
    String value;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        key: json["key"] == null ? null : json["key"],
        value: json["value"] == null ? null : json["value"],
    );

    Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "value": value == null ? null : value,
    };
}
