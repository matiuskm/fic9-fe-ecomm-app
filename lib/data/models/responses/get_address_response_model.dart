import 'package:meta/meta.dart';
import 'dart:convert';

class GetAddressResponseModel {
    final List<GetAddress> data;
    final Meta meta;

    GetAddressResponseModel({
        required this.data,
        required this.meta,
    });

    factory GetAddressResponseModel.fromJson(String str) => GetAddressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAddressResponseModel.fromMap(Map<String, dynamic> json) => GetAddressResponseModel(
        data: List<GetAddress>.from(json["data"].map((x) => GetAddress.fromMap(x))),
        meta: Meta.fromMap(json["meta"]),
    );

    Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "meta": meta.toMap(),
    };
}

class GetAddress {
    final int id;
    final Address attributes;

    GetAddress({
        required this.id,
        required this.attributes,
    });

    factory GetAddress.fromJson(String str) => GetAddress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAddress.fromMap(Map<String, dynamic> json) => GetAddress(
        id: json["id"],
        attributes: Address.fromMap(json["attributes"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "attributes": attributes.toMap(),
    };
}

class Address {
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

    Address({
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

    factory Address.fromJson(String str) => Address.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Address.fromMap(Map<String, dynamic> json) => Address(
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
    final Pagination pagination;

    Meta({
        required this.pagination,
    });

    factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromMap(json["pagination"]),
    );

    Map<String, dynamic> toMap() => {
        "pagination": pagination.toMap(),
    };
}

class Pagination {
    final int page;
    final int pageSize;
    final int pageCount;
    final int total;

    Pagination({
        required this.page,
        required this.pageSize,
        required this.pageCount,
        required this.total,
    });

    factory Pagination.fromJson(String str) => Pagination.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
