import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/cart_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/widgets/cart_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/product_detail/widgets/product_description_widget.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/product_detail/widgets/product_info_widget.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  EdgeInsets paddingHorizontal = const EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: ListView(
        children: [
          ImageSlider(
            items: [
              '${Variables.baseUrl}${widget.product.attributes.images.data.first.attributes.url}',
            ],
          ),
          const SpaceHeight(16.0),
          ProductInfoWidget(
            padding: paddingHorizontal,
            product: widget.product,
            onWishlistTap: (isWishList) {},
          ),
          const SpaceHeight(11.0),
          ProductDescriptionWidget(
            padding: paddingHorizontal,
            description: widget.product.attributes.description,
          ),
          const SpaceHeight(11.0),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.18)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Button.filled(
                onPressed: () {
                  context.read<CartBloc>().add(CartEvent.add(
                      CartModel(product: widget.product, qty: 1)));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartPage()));
                },
                label: "Add to Cart",
              ),
            ),
            const SpaceWidth(15.0),
            Flexible(
                child: Button.outlined(
              onPressed: () {},
              label: "Buy Now",
              color: ColorName.light,
            ))
          ],
        ),
      ),
    );
  }
}
