import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/province_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/status_model.dart';
import 'dart:convert';

class SingleProvinceResponseModel {
  final Rajaongkir rajaongkir;

  SingleProvinceResponseModel({
    required this.rajaongkir,
  });

  factory SingleProvinceResponseModel.fromJson(String str) =>
      SingleProvinceResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SingleProvinceResponseModel.fromMap(Map<String, dynamic> json) =>
      SingleProvinceResponseModel(
        rajaongkir: Rajaongkir.fromMap(json["rajaongkir"]),
      );

  Map<String, dynamic> toMap() => {
        "rajaongkir": rajaongkir.toMap(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final Province results;

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
        results: Province.fromMap(json["results"]),
      );

  Map<String, dynamic> toMap() => {
        "query": query.toMap(),
        "status": status.toMap(),
        "results": results.toMap(),
      };
}

class Query {
  final String id;

  Query({
    required this.id,
  });

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
      };
}
