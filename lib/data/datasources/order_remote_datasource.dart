import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/order_detail_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/order_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/order_response_model.dart';

class OrderRemoteDatasource {
  Future<Either<String, OrderResponseModel>> createOrder(
      OrderRequestModel req) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/orders'),
      body: req.toRawJson(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(OrderResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, OrderDetailResponseModel>> getOrderById(
      String orderId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?filters[order_number][\$eq]=$orderId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(OrderDetailResponseModel.fromRawJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }
}
