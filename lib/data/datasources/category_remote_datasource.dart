import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fic9_ecommerce_app/data/models/responses/category_response_model.dart';

class CategoryRemoteDatasource {
  Future<Either<String, CategoryResponseModel>> getAllCategories() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/categories?populate=category_icon'));
    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal mengambil data.');
    }
  }
}
