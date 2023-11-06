import 'package:flutter_fic9_ecommerce_app/core.dart';

class OrderProductModel {
  final String imagePath;
  final String name;
  final int price;

  OrderProductModel({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  String get priceFormat => price.currencyFormatIdr;
}
