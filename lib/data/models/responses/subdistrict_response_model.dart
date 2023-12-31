// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/status_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/subdistrict_model.dart';

class SubdistrictResponseModel {
  final Rajaongkir rajaongkir;

  SubdistrictResponseModel({
    required this.rajaongkir,
  });

  factory SubdistrictResponseModel.fromJson(String str) =>
      SubdistrictResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubdistrictResponseModel.fromMap(Map<String, dynamic> json) =>
      SubdistrictResponseModel(
        rajaongkir: Rajaongkir.fromMap(json["rajaongkir"]),
      );

  Map<String, dynamic> toMap() => {
        "rajaongkir": rajaongkir.toMap(),
      };
}

class Rajaongkir {
  final Query query;
  final Status status;
  final List<Subdistrict> results;

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
        results: List<Subdistrict>.from(
            json["results"].map((x) => Subdistrict.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "query": query.toMap(),
        "status": status.toMap(),
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Query {
  final String city;

  Query({
    required this.city,
  });

  factory Query.fromJson(String str) => Query.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Query.fromMap(Map<String, dynamic> json) => Query(
        city: json["city"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
      };
}
