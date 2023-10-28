import 'package:dartz/dartz.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/banner_response_model.dart';
import 'package:http/http.dart' as http;

class BannerRemoteDatasource {
  Future<Either<String, BannerResponseModel>> getAllBanners() async {
    final response = await http
        .get(Uri.parse('${Variables.baseUrl}/api/banners?populate=*'));
    if (response.statusCode == 200) {
      return Right(BannerResponseModel.fromJson(response.body));
    } else {
      return const Left('Gagal mengambil data.');
    }
  }
}