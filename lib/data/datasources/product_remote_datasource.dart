import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getAllProduct() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/products?populate=*'));
    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal mengambil data.');
    }
  }
}
