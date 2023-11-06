// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_app/common/extensions/date_time_ext.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

import 'package:flutter_fic9_ecommerce_app/data/models/responses/my_orders_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/widgets/order_product_tile.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/widgets/order_status.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({
    Key? key,
    required this.myOrder,
  }) : super(key: key);
  final MyOrder myOrder;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    int totalItem = 0;
    int item = 0;
    List<String> status = [];
    widget.myOrder.attributes.items.forEach((e) {
      totalItem += e.qty * e.price;
      item += e.qty;
    });
    if (widget.myOrder.attributes.status == 'processing') status = ['Dikemas'];
    if (widget.myOrder.attributes.status == 'shipped') {
      status = ['Dikemas', 'Dikirim'];
    }
    if (['delivered', 'completed'].contains(widget.myOrder.attributes.status)) {
      status = ['Dikemas', 'Dikirim', 'Diterima'];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pesanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          OrderStatus(
            status: status,
          ),
          const SpaceHeight(24.0),
          const Text(
            'Produk',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(14.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.myOrder.attributes.items.length,
            itemBuilder: (context, index) => OrderProductTile(
              item: widget.myOrder.attributes.items[index],
            ),
          ),
          const SpaceHeight(24.0),
          const Text(
            'Detail Pengiriman',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(14.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                RowText(
                  label: 'Waktu Pengiriman',
                  value: widget.myOrder.attributes.createdAt
                      .toFormattedDateWithDay(),
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Ekspedisi Pengiriman',
                  value: widget.myOrder.attributes.shippingCourier,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'No. Resi',
                  value: widget.myOrder.attributes.awb,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Alamat',
                  value: widget.myOrder.attributes.shippingAddress,
                ),
              ],
            ),
          ),
          const SpaceHeight(24.0),
          const Text(
            'Detail Pembayaran',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(14.0),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              border: Border.all(color: ColorName.border),
            ),
            child: Column(
              children: [
                RowText(
                  label: 'Total Item ($item) ',
                  value: totalItem.currencyFormatIdr,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Ongkir',
                  value:
                      widget.myOrder.attributes.shippingFee.currencyFormatIdr,
                ),
                const SpaceHeight(12.0),
                RowText(
                  label: 'Total ',
                  value: widget.myOrder.attributes.total.currencyFormatIdr,
                  valueColor: ColorName.primary,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
