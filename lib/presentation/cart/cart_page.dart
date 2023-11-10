// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/custom_dropdown.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/get_cost/get_cost_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/widgets/cart_item_widget.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order/order_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/order_page.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/order_request_model.dart'
    as order_request;
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/models/courier_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/shipping_address_page.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<GetAddressBloc>().add(const GetAddressEvent.getAddress());
    selectedCourier = courierOptions.first;
    super.initState();
  }

  GetAddress? selectedAddress;
  CourierModel? selectedCourier;
  int localTotal = 0;
  List<order_request.Item> items = [];

  final List<CourierModel> courierOptions = [
    CourierModel(value: 'jne', label: 'JNE'),
    CourierModel(value: 'pos', label: 'POS'),
    CourierModel(value: 'sicepat', label: 'SiCepat'),
  ];

  @override
  Widget build(BuildContext context) {
    int shippingFee = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (carts) {
              if (carts.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.emptyCartIcon),
                      const Text('Keranjang masih kosong.'),
                    ],
                  ),
                );
              }
              return ListView(
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
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: Button.filled(
                      width: 60,
                      onPressed: () async {
                        // GetAddress? temp = await Navigator.push(
                        selectedAddress = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShippingAddressPage(
                                  title: 'Alamat Pengiriman')),
                        );
                        setState(() {
                          // if (temp != null) selectedAddress = temp;
                        });
                      },
                      label: 'Pilih Alamat Pengiriman',
                    ),
                  ),
                  const SpaceHeight(16.0),
                  BlocBuilder<GetAddressBloc, GetAddressState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        loaded: (data) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('Alamat belum tersedia.'),
                            );
                          }
                          final address = selectedAddress ??
                              data.firstWhere((e) => e.attributes.isDefault,
                                  orElse: () => data.last);
                          selectedAddress = address;
                          context.read<GetCostBloc>().add(GetCostEvent.getCost(
                                origin: '2095',
                                destination: address.attributes.subdistrictId,
                                courier: selectedCourier!.value,
                              ));
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: ColorName.border),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Alamat Pengiriman',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SpaceHeight(16.0),
                                Text(
                                  address.attributes.name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  address.attributes.street,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  address.attributes.phone,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorName.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SpaceHeight(16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: ColorName.border),
                    ),
                    child: CustomDropdown<CourierModel>(
                      value: selectedCourier!,
                      items: courierOptions,
                      label: 'Kurir',
                      onChanged: (newVal) {
                        setState(() {
                          selectedCourier = newVal!;
                          context.read<GetCostBloc>().add(GetCostEvent.getCost(
                                origin: '2095',
                                destination:
                                    selectedAddress!.attributes.subdistrictId,
                                courier: selectedCourier!.value,
                              ));
                        });
                      },
                    ),
                  ),
                  const SpaceHeight(16.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: ColorName.border),
                    ),
                    child: Column(
                      children: [
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return RowText(
                                  label: 'Subtotal',
                                  value: 0.currencyFormatIdr,
                                );
                              },
                              loaded: (carts) {
                                int totalPrice = 0;
                                for (var element in carts) {
                                  totalPrice += int.parse(
                                          element.product.attributes.price) *
                                      element.qty;
                                }
                                localTotal = totalPrice;
                                items = carts
                                    .map((e) => order_request.Item(
                                          id: e.product.id,
                                          productName:
                                              e.product.attributes.name,
                                          qty: e.qty,
                                          price: int.parse(
                                              e.product.attributes.price),
                                        ))
                                    .toList();
                                return RowText(
                                  label: 'Subtotal',
                                  value: totalPrice.currencyFormatIdr,
                                );
                              },
                            );
                          },
                        ),
                        const SpaceHeight(12.0),
                        BlocBuilder<GetCostBloc, GetCostState>(
                          builder: (context, state) {
                            return state.maybeWhen(orElse: () {
                              return RowText(
                                label: 'Biaya Pengiriman',
                                value: 0.currencyFormatIdr,
                              );
                            }, loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }, loaded: (data) {
                              shippingFee = data.rajaongkir.results.first.costs
                                  .first.cost.first.value;
                              return RowText(
                                label: 'Biaya Pengiriman',
                                value: shippingFee.currencyFormatIdr,
                              );
                            });
                          },
                        ),
                        const SpaceHeight(40.0),
                        const Divider(
                          color: ColorName.border,
                        ),
                        const SpaceHeight(12.0),
                        BlocBuilder<GetCostBloc, GetCostState>(
                            builder: (context, stateCost) {
                          return BlocBuilder<CartBloc, CartState>(
                            builder: (context, stateCart) {
                              return stateCart.maybeWhen(
                                orElse: () {
                                  return RowText(
                                    label: 'Total Harus Dibayar',
                                    value: 0.currencyFormatIdr,
                                    valueColor: ColorName.primary,
                                    fontWeight: FontWeight.w700,
                                  );
                                },
                                loaded: (carts) {
                                  shippingFee = stateCost.maybeWhen(
                                    orElse: () => 0,
                                    loaded: (data) => data.rajaongkir.results
                                        .first.costs.first.cost.first.value,
                                  );
                                  int totalPrice = 0;
                                  for (var item in carts) {
                                    totalPrice += int.parse(
                                            item.product.attributes.price) *
                                        item.qty;
                                  }

                                  totalPrice += shippingFee;
                                  localTotal = totalPrice;

                                  return RowText(
                                    label: 'Total Harus Dibayar',
                                    value: totalPrice.currencyFormatIdr,
                                    valueColor: ColorName.primary,
                                    fontWeight: FontWeight.w700,
                                  );
                                },
                              );
                            },
                          );
                        }),
                        const SpaceHeight(16.0),
                        BlocConsumer<OrderBloc, OrderState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return Button.filled(
                                  onPressed: () async {
                                    final DateTime now = DateTime.now();
                                    final DateFormat formatter =
                                        DateFormat('yMdHms');
                                    final user =
                                        await AuthLocalDatasource().getUser();

                                    final orderNumber =
                                        'LZCDR-${formatter.format(now)}';
                                    final data = order_request.Data(
                                      items: items,
                                      total: localTotal,
                                      shippingAddress:
                                          selectedAddress!.attributes.street,
                                      shippingCourier: selectedCourier!.value,
                                      shippingFee: shippingFee,
                                      status: 'pending_payment',
                                      orderNumber: orderNumber,
                                      userId: user.id!,
                                      shippingReceiver:
                                          selectedAddress!.attributes.name,
                                    );
                                    final requestModel =
                                        order_request.OrderRequestModel(
                                            data: data);
                                    if (context.mounted) {
                                      context.read<OrderBloc>().add(
                                          OrderEvent.createOrder(requestModel));
                                    }
                                  },
                                  label: 'Bayar Sekarang',
                                );
                              },
                              loading: () {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          },
                          listener: (context, state) {
                            state.maybeWhen(
                                orElse: () {},
                                success: (model) {
                                  context
                                      .read<CartBloc>()
                                      .add(const CartEvent.started());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OrderPage(
                                        url: model.invoiceUrl,
                                        orderId: model.externalId,
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
