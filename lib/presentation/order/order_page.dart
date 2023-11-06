import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order_detail/order_detail_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/payment/payment_failed_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/payment/payment_success_page.dart';
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
      context
          .read<OrderDetailBloc>()
          .add(OrderDetailEvent.getOrderDetail(widget.orderId));
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
                if (order.data[0].attributes.status == 'paid') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentSuccessPage()));
                } else if (order.data[0].attributes.status == 'canceled') {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const PaymentFailedPage()));
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
