import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/components/my_chip.dart';
import 'package:flutter_fic9_ecommerce_app/common/extensions/date_time_ext.dart';
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
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: ColorName.border),
          color: Colors.grey,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    const SpaceWidth(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Belanja',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        Text(
                          data.attributes.createdAt.toFormattedDateOnly(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                if (['paid'].contains(data.attributes.status))
                  const MyChip(
                    text: 'Menunggu Konfirmasi',
                    textColor: Colors.black,
                    backgroundColor: Colors.white,
                  )
                else if (['processing'].contains(data.attributes.status))
                  MyChip(
                      text: 'Diproses',
                      textColor: Colors.yellow.shade200,
                      backgroundColor: Colors.orange.shade700)
                else if (['shipped'].contains(data.attributes.status))
                  MyChip(
                      text: 'Sedang Dikirim',
                      textColor: Colors.orange.shade700,
                      backgroundColor: Colors.yellow.shade200)
                else if (['delivered', 'completed']
                    .contains(data.attributes.status))
                  MyChip(
                      text: 'Selesai',
                      textColor: Colors.green.shade800,
                      backgroundColor: Colors.green.shade50)
                else if (['canceled'].contains(data.attributes.status))
                  MyChip(
                      text: 'Dibatalkan',
                      textColor: Colors.red.shade800,
                      backgroundColor: Colors.red.shade50)
              ],
            ),
            const Divider(),
            SizedBox(
              height: 110,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.attributes.items.first.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${data.attributes.items.first.qty} barang',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  const SpaceHeight(10),
                  if (data.attributes.items.length > 1)
                    Text(
                      '+${data.attributes.items.length - 1} produk lainnya',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    )
                  else
                    const Text(''),
                  const SpaceHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Belanja:',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data.attributes.total.currencyFormatIdr,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      if (data.attributes.awb.isNotEmpty)
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
                          height: 30.0,
                          width: 94.0,
                          fontSize: 11.0,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
