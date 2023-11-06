import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/row_text.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/my_orders_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/manifest_delivery_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/order_detail_page.dart';

class MyOrderCard extends StatelessWidget {
  final MyOrder data;
  const MyOrderCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OrderDetailPage(myOrder: data)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: ColorName.border),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No Resi: ${data.attributes.awb}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Button.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ManifestDeliveryPage(myOrder: data)),
                    );
                  },
                  label: 'Lacak',
                  height: 20.0,
                  width: 94.0,
                  fontSize: 11.0,
                  disabled: (data.attributes.awb).isEmpty,
                ),
              ],
            ),
            const SpaceHeight(24.0),
            RowText(label: 'Status', value: data.attributes.status),
            const SpaceHeight(12.0),
            // RowText(label: 'Item', value: data.item);
            const SpaceHeight(12.0),
            RowText(
                label: 'Total Bayar',
                value: data.attributes.total.currencyFormatIdr),
          ],
        ),
      ),
    );
  }
}
