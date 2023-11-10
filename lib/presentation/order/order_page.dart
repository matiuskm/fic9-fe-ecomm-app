import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/products/products_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order_detail/order_detail_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/payment/payment_failed_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/payment/payment_success_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
    required this.url,
    required this.orderId,
  }) : super(key: key);
  final String url;
  final String orderId;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  WebViewController? controller;
  Timer? _timer;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ))
      ..loadRequest(
        Uri.parse(widget.url),
      );
    const oneSec = Duration(seconds: 8);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (!isShown) {
        context
            .read<OrderDetailBloc>()
            .add(OrderDetailEvent.getOrderDetail(widget.orderId));
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OrderDetailBloc, OrderDetailState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              success: (order) {
                if (order.data[0].attributes.status == 'paid' && !isShown) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentSuccessPage()));
                  if (context.mounted) {
                    context
                        .read<ProductsBloc>()
                        .add(const ProductsEvent.getAll());
                  }
                  isShown = true;
                } else if (order.data[0].attributes.status == 'canceled' &&
                    !isShown) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentFailedPage()));
                  isShown = true;
                }
              });
        },
        child: WebViewWidget(
          controller: controller!,
        ),
      ),
    );
  }
}
