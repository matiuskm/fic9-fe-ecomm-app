import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/add_address_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/default_address_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/add_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/my_orders_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/order_detail_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/single_address_response_model.dart';
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

  Future<Either<String, MyOrdersResponseModel>> getMyOrders() async {
    final token = await AuthLocalDatasource().getToken();
    final user = await AuthLocalDatasource().getUser();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders?filters[user_id][\$eq]=${user.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return right(MyOrdersResponseModel.fromJson(response.body));
    } else {
      return left('Gagal mengambil data.');
    }
  }

  // Address
  Future<Either<String, AddAddressResponseModel>> addAddress(
      AddAddressRequestModel req) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/addresses'),
      headers: headers,
      body: req.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, AddAddressResponseModel>> updateAddress(
      String id, AddAddressRequestModel req) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/addresses/$id'),
      headers: headers,
      body: req.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, AddAddressResponseModel>> setAsDefaultAddress(
      int addressId, DefaultAddressRequestModel req) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/addresses/$addressId'),
      headers: headers,
      body: req.toJson(),
    );

    if (response.statusCode == 200) {
      return right(AddAddressResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, GetAddressResponseModel>> getAddress() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    final userId = (await AuthLocalDatasource().getUser()).id;

    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/addresses?filters[user_id][\$eq]=$userId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(GetAddressResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  Future<Either<String, SingleAddressResponseModel>> deleteAddress(
      int addressId) async {
    final token = await AuthLocalDatasource().getToken();
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/addresses/$addressId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(SingleAddressResponseModel.fromJson(response.body));
    } else {
      return left('Terjadi kesalahan. Silakan coba lagi.');
    }
  }
}
