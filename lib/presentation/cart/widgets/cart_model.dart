import 'package:flutter_fic9_ecommerce_app/common/extensions/string_ext.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';

class CartModel {
  final Product product;
  int qty;

  CartModel({
    required this.product,
    this.qty = 0,
  });

  String get priceFormat => product.attributes.price.currencyFormatIdr;
}
