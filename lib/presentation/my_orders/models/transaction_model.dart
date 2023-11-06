import 'package:flutter_fic9_ecommerce_app/core.dart';

class TransactionModel {
  final String awb;
  final String status;
  final int qty;
  final int price;

  TransactionModel({
    required this.awb,
    required this.status,
    required this.qty,
    required this.price,
  });

  String get item => '$qty item yang dibeli.';
  String get priceFormat => price.currencyFormatIdr;
}
