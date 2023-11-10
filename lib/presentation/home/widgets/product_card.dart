import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/product_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/widgets/cart_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/product_detail/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  Widget checkDiscount() {
    if (data.attributes.isDiscount) {
      return Row(
        children: [
          Text(
            int.parse(data.attributes.price).currencyFormatIdr,
            maxLines: 1,
            overflow: TextOverflow.clip,
            softWrap: false,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            int.parse(data.attributes.specialPrice).currencyFormatIdr,
            maxLines: 1,
            overflow: TextOverflow.clip,
            softWrap: false,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      );
    }
    return Text(
      int.parse(data.attributes.price).currencyFormatIdr,
      maxLines: 1,
      overflow: TextOverflow.clip,
      softWrap: false,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.orange,
      ),
    );
  }

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
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                        '${Variables.baseUrl}${data.attributes.images.data.first.attributes.url}',
                        alignment: Alignment.center,
                        fit: BoxFit.contain)),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              child: Text(
                data.attributes.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            if (data.attributes.stock > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  checkDiscount(),
                  IconButton(
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(CartEvent.add(CartModel(product: data, qty: 1)));
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: ColorName.primary,
                    ),
                  ),
                ],
              )
            else
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(
                  'Stok Kosong',
                  style: TextStyle(
                    color: ColorName.grey,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
