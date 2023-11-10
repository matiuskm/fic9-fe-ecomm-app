import 'dart:convert';

class AddAddressResponseModel {
    final Data data;

    AddAddressResponseModel({
        required this.data,
    });

    factory AddAddressResponseModel.fromJson(String str) => AddAddressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddAddressResponseModel.fromMap(Map<String, dynamic> json) => AddAddressResponseModel(
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
    };
}

class Data {
    final int id;
    final String name;
    final String street;
    final String phone;
    final String provinceId;
    final String cityId;
    final String subdistrictId;
    final String zipcode;
    final String userId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final DateTime publishedAt;
    final bool isDefault;
    final String completeAddress;
    final String label;

    Data({
        required this.id,
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
        required this.completeAddress,
        required this.label,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        street: json["street"],
        phone: json["phone"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        zipcode: json["zipcode"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
        isDefault: json["is_default"],
        completeAddress: json["complete_address"],
        label: json["label"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "street": street,
        "phone": phone,
        "province_id": provinceId,
        "city_id": cityId,
        "subdistrict_id": subdistrictId,
        "zipcode": zipcode,
        "user_id": userId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "publishedAt": publishedAt.toIso8601String(),
        "is_default": isDefault,
        "complete_address": completeAddress,
        "label": label,
    };
}
