// To parse this JSON data, do
//
//     final orderByIdModel = orderByIdModelFromJson(jsonString);

import 'dart:convert';

OrderByIdModel orderByIdModelFromJson(String str) => OrderByIdModel.fromJson(json.decode(str));

String orderByIdModelToJson(OrderByIdModel data) => json.encode(data.toJson());

class OrderByIdModel {
    OrderByIdModel({
        this.mainCode,
        this.code,
        this.data,
        this.error,
    });

    int mainCode;
    int code;
    List<Datum> data;
    List<Error> error;

    factory OrderByIdModel.fromJson(Map<String, dynamic> json) => OrderByIdModel(
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
        this.userId,
        this.user,
        this.photo,
        this.rate,
        this.state,
        this.driver,
        this.notes,
        this.categoryId,
        this.category,
        this.cityId,
    });

    int id;
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
    int userId;
    String user;
    String photo;
    int rate;
    String state;
    List<Driver> driver;
    String notes;
    int categoryId;
    String category;
    int cityId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
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
        userId: json["user_id"] == null ? null : json["user_id"],
        user: json["user"] == null ? null : json["user"],
        photo: json["photo"] == null ? null : json["photo"],
        rate: json["rate"] == null ? null : json["rate"],
        state: json["state"] == null ? null : json["state"],
        driver: json["driver"] == null ? null : List<Driver>.from(json["driver"].map((x) => Driver.fromJson(x))),
        notes: json["notes"] == null ? null : json["notes"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        category: json["category"] == null ? null : json["category"],
        cityId: json["city_id"] == null ? null : json["city_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
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
        "user_id": userId == null ? null : userId,
        "user": user == null ? null : user,
        "photo": photo == null ? null : photo,
        "rate": rate == null ? null : rate,
        "state": state == null ? null : state,
        "driver": driver == null ? null : List<dynamic>.from(driver.map((x) => x.toJson())),
        "notes": notes == null ? null : notes,
        "category_id": categoryId == null ? null : categoryId,
        "category": category == null ? null : category,
        "city_id": cityId == null ? null : cityId,
    };
}

class Driver {
    Driver({
        this.id,
        this.driver,
        this.photo,
        this.rate,
    });

    int id;
    String driver;
    String photo;
    int rate;

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"] == null ? null : json["id"],
        driver: json["driver"] == null ? null : json["driver"],
        photo: json["photo"] == null ? null : json["photo"],
        rate: json["rate"] == null ? null : json["rate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "driver": driver == null ? null : driver,
        "photo": photo == null ? null : photo,
        "rate": rate == null ? null : rate,
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
