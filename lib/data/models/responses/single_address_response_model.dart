import 'package:meta/meta.dart';
import 'dart:convert';

class SingleAddressResponseModel {
    final Data data;
    final Meta meta;

    SingleAddressResponseModel({
        required this.data,
        required this.meta,
    });

    factory SingleAddressResponseModel.fromJson(String str) => SingleAddressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SingleAddressResponseModel.fromMap(Map<String, dynamic> json) => SingleAddressResponseModel(
        data: Data.fromMap(json["data"]),
        meta: Meta.fromMap(json["meta"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
        "meta": meta.toMap(),
    };
}

class Data {
    final int id;
    final Attributes attributes;

    Data({
        required this.id,
        required this.attributes,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        attributes: Attributes.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class Attributes {
    final String name;
    final String street;
    final String phone;
    final String provinceId;
    final String cityId;
    final String subdistrictId;
    final String zipcode;
    final String userId;
    final String createdAt;
    final String updatedAt;
    final String publishedAt;
    final bool isDefault;

    Attributes({
        required this.name,
        required this.street,
        required this.phone,
        required this.provinceId,
        required this.cityId,
        required this.subdistrictId,
        required this.zipcode,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.publishedAt,
        required this.isDefault,
    });

    factory Attributes.fromJson(String str) => Attributes.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Attributes.fromMap(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        street: json["street"],
        phone: json["phone"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        zipcode: json["zipcode"],
        userId: json["user_id"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        publishedAt: json["publishedAt"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "street": street,
        "phone": phone,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "zipcode": zipcode,
        "user_id": userId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "publishedAt": publishedAt,
        "is_default": isDefault,
    };
}

class Meta {
    Meta();

    factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    );

    Map<String, dynamic> toMap() => {
    };
}
