import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/my_orders_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/blocs/my_order/my_order_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/widgets/my_order_card.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  void initState() {
    context.read<MyOrderBloc>().add(const MyOrderEvent.getMyOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
      ),
      body: BlocBuilder<MyOrderBloc, MyOrderState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const SpaceHeight(0.0),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (orders) {
              if (orders.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      const Text('Belum ada pesanan'),
                      Button.filled(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const DashboardPage()));
                          },
                          label: 'Mulai belanja')
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: refreshdata,
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      MyOrderCard(data: orders[index]),
                  separatorBuilder: (context, index) => const SpaceHeight(16.0),
                  itemCount: orders.length,
                ),
              );
              // return _buildWidgetListDataAndroid(orders);
            },
          );
        },
      ),
    );
  }

  Future<void> refreshdata() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<MyOrderBloc>().add(const MyOrderEvent.getMyOrder());
    setState(() {});
  }
}
