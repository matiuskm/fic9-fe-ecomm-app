import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/product_detail/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                    product: data,
                  )),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          // boxShadow: [
          //   BoxShadow(
          //     color: ColorName.black.withOpacity(0.05),
          //     blurRadius: 7.0,
          //     spreadRadius: 0,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${Variables.baseUrl}${data.attributes.images.data.first.attributes.url}',
              width: 170.0,
              height: 112.0,
              fit: BoxFit.contain,
            ),
            const SpaceHeight(14.0),
            Flexible(
              child: Text(
                data.attributes.name,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SpaceHeight(10.0),
            Text(
              int.parse(data.attributes.price).currencyFormatIdr,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
