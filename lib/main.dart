import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/auth/blocs/login/login_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/auth/blocs/register/register_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/get_cost/get_cost_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/banners/banners_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/categories/categories_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/products/products_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/blocs/cek_resi/cek_resi_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/blocs/my_order/my_order_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order/order_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/order/bloc/order_detail/order_detail_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/add_address/add_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/city/city_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/province/province_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/subdistrict/subdistrict_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) =>
              ProductsBloc()..add(const ProductsEvent.getAll()),
        ),
        BlocProvider(
          create: (context) =>
              BannersBloc()..add(const BannersEvent.getAllBanners()),
        ),
        BlocProvider(
          create: (context) =>
              CategoriesBloc()..add(const CategoriesEvent.getAllCategories()),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => OrderDetailBloc(),
        ),
        BlocProvider(
          create: (context) => ProvinceBloc(),
        ),
        BlocProvider(
          create: (context) => CityBloc(),
        ),
        BlocProvider(
          create: (context) => SubdistrictBloc(),
        ),
        BlocProvider(
          create: (context) => AddAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetAddressBloc(),
        ),
        BlocProvider(
          create: (context) => GetCostBloc(),
        ),
        BlocProvider(
          create: (context) => MyOrderBloc(),
        ),
        BlocProvider(
          create: (context) => CekResiBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.navigatorKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isLogin(),
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data!) {
                return const DashboardPage();
              } else {
                return const LoginPage();
              }
            }),
      ),
    );
  }
}
