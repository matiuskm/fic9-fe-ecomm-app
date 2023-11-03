// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order/order_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/order_page.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/order_request_model.dart'
    as order_request;
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int shippingFee = 9000;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (carts) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SpaceHeight(16.0),
                    itemCount: carts.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        data: carts[index],
                      );
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(70.0),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return Column(
                          children: [
                            Image.asset(Images.emptyCartIcon),
                            RowText(
                              label: 'Total Harga',
                              value: 0.currencyFormatIdr,
                            ),
                          ],
                        );
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var element in carts) {
                          totalPrice +=
                              int.parse(element.product.attributes.price) *
                                  element.qty;
                        }
                        return RowText(
                          label: 'Total Harga',
                          value: totalPrice.currencyFormatIdr,
                        );
                      },
                    );
                  },
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Biaya Pengiriman',
                  value: shippingFee.currencyFormatIdr,
                ),
                const SpaceHeight(40.0),
                const Divider(
                  color: ColorName.border,
                ),
                const SpaceHeight(12.0),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return RowText(
                          label: 'Total Harus Dibayar',
                          value: 0.currencyFormatIdr,
                          valueColor: ColorName.primary,
                          fontWeight: FontWeight.w700,
                        );
                      },
                      loaded: (carts) {
                        int totalPrice = 0;
                        for (var element in carts) {
                          totalPrice +=
                              int.parse(element.product.attributes.price) *
                                  element.qty;
                        }
                        totalPrice += shippingFee;
                        return RowText(
                          label: 'Total Harus Dibayar',
                          value: totalPrice.currencyFormatIdr,
                          valueColor: ColorName.primary,
                          fontWeight: FontWeight.w700,
                        );
                      },
                    );
                  },
                ),
                const SpaceHeight(16.0),
                BlocListener<OrderBloc, OrderState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      success: (model) {
                        context.read<CartBloc>().add(const CartEvent.started());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage(
                                      url: model.invoiceUrl,
                                      orderId: model.externalId,
                                    )));
                      },
                    );
                  },
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Text('Aku ngapain ya?');
                        },
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        loaded: (model) {
                          return Button.filled(
                            onPressed: () {
                              final DateTime now = DateTime.now();
                              final DateFormat formatter = DateFormat('yMdHms');
                              final total = model.fold(
                                      0,
                                      (sum, item) =>
                                          sum +
                                          item.qty *
                                              int.parse(item
                                                  .product.attributes.price)) +
                                  shippingFee;
                              final orderNumber =
                                  'LZCDR-${formatter.format(now)}';
                              final data = order_request.Data(
                                items: model
                                    .map((e) => order_request.Item(
                                        id: e.product.id,
                                        productName: e.product.attributes.name,
                                        price: int.parse(
                                            e.product.attributes.price),
                                        qty: e.qty))
                                    .toList(),
                                total: total,
                                shippingAddress: 'Jakarta Pusat',
                                shippingCourier: 'JNE',
                                shippingFee: shippingFee,
                                status: 'pending_payment',
                                orderNumber: orderNumber,
                              );
                              final requestModel =
                                  order_request.OrderRequestModel(data: data);
                              context
                                  .read<OrderBloc>()
                                  .add(OrderEvent.createOrder(requestModel));
                            },
                            label: 'Bayar Sekarang',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
