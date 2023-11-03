import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/login_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/register_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel req) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local/register'),
      body: req.toJson(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel req) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/auth/local'),
      body: req.toJson(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left('Email/password salah.');
    }
  }
}
