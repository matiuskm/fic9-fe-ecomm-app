import 'dart:convert';

class Status {
    final int code;
    final String description;

    Status({
        required this.code,
        required this.description,
    });

    factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "description": description,
    };
}
