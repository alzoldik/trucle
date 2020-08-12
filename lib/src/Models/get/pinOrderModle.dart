// To parse this JSON data, do
//
//     final pinOrderModel = pinOrderModelFromJson(jsonString);

import 'dart:convert';

PinOrderModel pinOrderModelFromJson(String str) => PinOrderModel.fromJson(json.decode(str));

String pinOrderModelToJson(PinOrderModel data) => json.encode(data.toJson());

class PinOrderModel {
    PinOrderModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory PinOrderModel.fromJson(Map<String, dynamic> json) => PinOrderModel(
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
        this.userId,
        this.user,
        this.rate,
        this.photo,
        this.size,
        this.detials,
        this.arrivalTime,
        this.arrivalDate,
        this.travelTime,
        this.travelDate,
        this.code,
        this.travelLongitude,
        this.travelLatitude,
        this.travelAddress,
        this.arrivalLongitude,
        this.arrivalLatitude,
        this.arrivalAddress,
        this.state,
        this.discountPercentage,
        this.categoryId,
        this.cityId,
        this.createdAt,
    });

    int id;
    int userId;
    String user;
    int rate;
    String photo;
    int size;
    String detials;
    String arrivalTime;
    DateTime arrivalDate;
    String travelTime;
    DateTime travelDate;
    String code;
    String travelLongitude;
    String travelLatitude;
    String travelAddress;
    String arrivalLongitude;
    String arrivalLatitude;
    String arrivalAddress;
    String state;
    String discountPercentage;
    int categoryId;
    int cityId;
    DateTime createdAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        rate: json["rate"] == null ? null : json["rate"],
        photo: json["photo"] == null ? null : json["photo"],
        size: json["size"] == null ? null : json["size"],
        detials: json["detials"] == null ? null : json["detials"],
        arrivalTime: json["arrival_time"] == null ? null : json["arrival_time"],
        arrivalDate: json["arrival_date"] == null ? null : DateTime.parse(json["arrival_date"]),
        travelTime: json["travel_time"] == null ? null : json["travel_time"],
        travelDate: json["travel_date"] == null ? null : DateTime.parse(json["travel_date"]),
        code: json["code"] == null ? null : json["code"],
        travelLongitude: json["travel_longitude"] == null ? null : json["travel_longitude"],
        travelLatitude: json["travel_latitude"] == null ? null : json["travel_latitude"],
        travelAddress: json["travel_address"] == null ? null : json["travel_address"],
        arrivalLongitude: json["arrival_longitude"] == null ? null : json["arrival_longitude"],
        arrivalLatitude: json["arrival_latitude"] == null ? null : json["arrival_latitude"],
        arrivalAddress: json["arrival_address"] == null ? null : json["arrival_address"],
        state: json["state"] == null ? null : json["state"],
        discountPercentage: json["discount_percentage"] == null ? null : json["discount_percentage"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        cityId: json["city_id"] == null ? null : json["city_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "rate": rate == null ? null : rate,
        "photo": photo == null ? null : photo,
        "size": size == null ? null : size,
        "detials": detials == null ? null : detials,
        "arrival_time": arrivalTime == null ? null : arrivalTime,
        "arrival_date": arrivalDate == null ? null : "${arrivalDate.year.toString().padLeft(4, '0')}-${arrivalDate.month.toString().padLeft(2, '0')}-${arrivalDate.day.toString().padLeft(2, '0')}",
        "travel_time": travelTime == null ? null : travelTime,
        "travel_date": travelDate == null ? null : "${travelDate.year.toString().padLeft(4, '0')}-${travelDate.month.toString().padLeft(2, '0')}-${travelDate.day.toString().padLeft(2, '0')}",
        "code": code == null ? null : code,
        "travel_longitude": travelLongitude == null ? null : travelLongitude,
        "travel_latitude": travelLatitude == null ? null : travelLatitude,
        "travel_address": travelAddress == null ? null : travelAddress,
        "arrival_longitude": arrivalLongitude == null ? null : arrivalLongitude,
        "arrival_latitude": arrivalLatitude == null ? null : arrivalLatitude,
        "arrival_address": arrivalAddress == null ? null : arrivalAddress,
        "state": state == null ? null : state,
        "discount_percentage": discountPercentage == null ? null : discountPercentage,
        "category_id": categoryId == null ? null : categoryId,
        "city_id": cityId == null ? null : cityId,
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
