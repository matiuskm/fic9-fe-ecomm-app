import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';

class ProductInfoWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Product product;
  final void Function(bool isWishList) onWishlistTap;

  const ProductInfoWidget(
      {Key? key,
      required this.padding,
      required this.product,
      required this.onWishlistTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWishList = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  product.attributes.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  return IconButton(
                    onPressed: () {
                      isWishList = !isWishList;
                      setState(() {});
                      onWishlistTap(isWishList);
                    },
                    icon: isWishList
                        ? const Icon(Icons.favorite, color: ColorName.red)
                        : const Icon(Icons.favorite_border),
                    iconSize: 24.0,
                  );
                },
              ),
            ],
          ),
        ),
        const SpaceHeight(4.0),
        Padding(
          padding: padding,
          child: Text(
            int.parse(product.attributes.price).currencyFormatIdr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: ColorName.primary,
            ),
          ),
        ),
      ],
    );
  }
}
