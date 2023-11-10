import 'dart:convert';

class Province {
    final String provinceId;
    final String province;

    Province({
        required this.provinceId,
        required this.province,
    });

    factory Province.fromJson(String str) => Province.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Province.fromMap(Map<String, dynamic> json) => Province(
        provinceId: json["province_id"],
        province: json["province"],
    );

    Map<String, dynamic> toMap() => {
        "province_id": provinceId,
        "province": province,
    };

  @override
  String toString() => province;
}
