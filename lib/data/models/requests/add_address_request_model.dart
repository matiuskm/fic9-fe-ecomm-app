import 'dart:convert';

class AddAddressRequestModel {
  final AddAddress data;

  AddAddressRequestModel({
    required this.data,
  });

  factory AddAddressRequestModel.fromJson(String str) =>
      AddAddressRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddAddressRequestModel.fromMap(Map<String, dynamic> json) =>
      AddAddressRequestModel(
        data: AddAddress.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class AddAddress {
  final String name;
  final String street;
  final String phone;
  final String provinceId;
  final String cityId;
  final String subdistrictId;
  final String zipcode;
  final int userId;
  final bool isDefault;
  final String label;
  final String completeAddress;

  AddAddress({
    required this.name,
    required this.street,
    required this.phone,
    required this.provinceId,
    required this.cityId,
    required this.subdistrictId,
    required this.zipcode,
    required this.userId,
    required this.isDefault,
    required this.label,
    required this.completeAddress,
  });

  factory AddAddress.fromJson(String str) =>
      AddAddress.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddAddress.fromMap(Map<String, dynamic> json) => AddAddress(
        name: json["name"],
        street: json["street"],
        phone: json["phone"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        subdistrictId: json["subdistrict_id"],
        zipcode: json["zipcode"],
        userId: json["user_id"],
        isDefault: json["is_default"],
        label: json["label"] ?? '',
        completeAddress: json["complete_address"] ?? '',
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
        "is_default": isDefault,
        "label": label,
        "complete_address": completeAddress,
      };
}
