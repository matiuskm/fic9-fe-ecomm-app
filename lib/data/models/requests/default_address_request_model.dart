import 'dart:convert';

class DefaultAddressRequestModel {
    final Data data;

    DefaultAddressRequestModel({
        required this.data,
    });

    factory DefaultAddressRequestModel.fromJson(String str) => DefaultAddressRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DefaultAddressRequestModel.fromMap(Map<String, dynamic> json) => DefaultAddressRequestModel(
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "data": data.toMap(),
    };
}

class Data {
    final int userId;
    final bool isDefault;

    Data({
        required this.userId,
        required this.isDefault,
    });

    factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        isDefault: json["is_default"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "is_default": isDefault,
    };
}
