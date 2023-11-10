// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/province_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/status_model.dart';

class ProvinceResponseModel {
    final Rajaongkir rajaongkir;

    ProvinceResponseModel({
        required this.rajaongkir,
    });

    factory ProvinceResponseModel.fromJson(String str) => ProvinceResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProvinceResponseModel.fromMap(Map<String, dynamic> json) => ProvinceResponseModel(
        rajaongkir: Rajaongkir.fromMap(json["rajaongkir"]),
    );

    Map<String, dynamic> toMap() => {
        "rajaongkir": rajaongkir.toMap(),
    };
}
class Rajaongkir {
    final List<dynamic> query;
    final Status status;
    final List<Province> results;

    Rajaongkir({
        required this.query,
        required this.status,
        required this.results,
    });

    factory Rajaongkir.fromJson(String str) => Rajaongkir.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Rajaongkir.fromMap(Map<String, dynamic> json) => Rajaongkir(
        query: List<dynamic>.from(json["query"].map((x) => x)),
        status: Status.fromMap(json["status"]),
        results: List<Province>.from(json["results"].map((x) => Province.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "query": List<dynamic>.from(query.map((x) => x)),
        "status": status.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}
