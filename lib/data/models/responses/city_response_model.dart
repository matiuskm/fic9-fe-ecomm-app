// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/city_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/status_model.dart';

class CityResponseModel {
  final Rajaongkir rajaongkir;

  CityResponseModel({
    required this.rajaongkir,
  });

  factory CityResponseModel.fromJson(String str) =>
      CityResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityResponseModel.fromMap(Map<String, dynamic> json) =>
      CityResponseModel(
        rajaongkir: Rajaongkir.fromMap(json["rajaongkir"]),
      );

  Map<String, dynamic> toMap() => {
        "rajaongkir": rajaongkir.toMap(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final List<City> results;

  Rajaongkir({
    required this.query,
    required this.status,
    required this.results,
  });

  factory Rajaongkir.fromJson(String str) =>
      Rajaongkir.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Rajaongkir.fromMap(Map<String, dynamic> json) => Rajaongkir(
        query: Query.fromMap(json["query"]),
        status: Status.fromMap(json["status"]),
        results: List<City>.from(json["results"].map((x) => City.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "query": query.toMap(),
        "status": status.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Query {
  final String province;

  Query({
    required this.province,
  });

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
        province: json["province"],
      );

  Map<String, dynamic> toMap() => {
        "province": province,
      };
}