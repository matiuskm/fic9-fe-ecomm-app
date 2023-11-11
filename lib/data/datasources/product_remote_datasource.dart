import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getAllProduct() async {
    final response = await http.get(Uri.parse(
        '${Variables.baseUrl}/api/products?populate=*&sort=stock:desc'));
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal mengambil data.');
    }
  }

  Future<Either<String, ProductResponseModel>> getAllProductsByCategory(
      String catId) async {
    final token = await AuthLocalDatasource().getToken();
    final response = await http.get(
        Uri.parse(
            '${Variables.baseUrl}/api/products?populate=*&filters[categories][id][\$eq]=$catId'),
        headers: <String, String>{
          "content-type": "application/json; charset=UTF-8",
          "Authentication": 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal mengambil data.');
    }
  }
}
