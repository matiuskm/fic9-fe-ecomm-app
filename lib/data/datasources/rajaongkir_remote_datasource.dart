import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/city_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/cost_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/province_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/single_province_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/subdistrict_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/waybill_failed_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/waybill_success_response_model.dart';
import 'package:http/http.dart' as http;

class RajaOngkirRemoteDatasource {
  Future<Either<String, ProvinceResponseModel>> getProvinces() async {
    final url = Uri.parse('${Variables.roBaseUrl}/province');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.roApiKey,
      },
    );

    if (response.statusCode == 200) {
      return right(ProvinceResponseModel.fromJson(response.body));
    } else {
      return left('Gagal mengambil data.');
    }
  }

  Future<Either<String, CityResponseModel>> getCities(String provinceId) async {
    final url = Uri.parse('${Variables.roBaseUrl}/city?province=$provinceId');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.roApiKey,
      },
    );

    if (response.statusCode == 200) {
      return right(CityResponseModel.fromJson(response.body));
    } else {
      return left('Gagal mengambil data.');
    }
  }

  Future<Either<String, SubdistrictResponseModel>> getSubdistricts(
      String cityId) async {
    final url = Uri.parse('${Variables.roBaseUrl}/subdistrict?city=$cityId');
    final response = await http.get(
      url,
      headers: {
        'key': Variables.roApiKey,
      },
    );

    if (response.statusCode == 200) {
      return right(SubdistrictResponseModel.fromJson(response.body));
    } else {
      return left('Gagal mengambil data.');
    }
  }

  Future<Either<String, CostResponseModel>> getCost(
    String origin,
    String destination,
    String courier,
    String weight,
  ) async {
    final url = Uri.parse('https://pro.rajaongkir.com/api/cost');
    final response = await http.post(
      url,
      headers: {
        'key': Variables.roApiKey,
        'content-type': 'application/x-www-form-urlencoded',
      },
      body: {
        'origin': origin,
        'originType': 'subdistrict',
        'destination': destination,
        'destinationType': 'subdistrict',
        'weight': weight,
        'courier': courier,
      },
    );
    if (response.statusCode == 200) {
      return right(CostResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }

  Future<Either<WaybillFailedResponseModel, WaybillSuccessResponseModel>>
      cekResi(
    String awb,
    String courier,
  ) async {
    final url = Uri.parse('${Variables.roBaseUrl}/waybill');
    final response = await http.post(url, headers: {
      'key': Variables.roApiKey,
      'content-type': 'application/x-www-form-urlencoded',
    }, body: {
      'waybill': awb,
      'courier': courier,
    });
    if (response.statusCode == 200) {
      return right(WaybillSuccessResponseModel.fromJson(response.body));
    } else {
      return left(WaybillFailedResponseModel.fromJson(response.body));
    }
  }

  Future<Either<String, SingleProvinceResponseModel>> getProvinceById(
      int provinceId) async {
    final url = Uri.parse('${Variables.roBaseUrl}/province?id=$provinceId');
    final response = await http.post(url, headers: {
      'key': Variables.roApiKey,
    });
    if (response.statusCode == 200) {
      return right(SingleProvinceResponseModel.fromJson(response.body));
    } else {
      return left('Error');
    }
  }
}
