import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_fic9_ecommerce_app/common/constants/variables.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/cart_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/banners/banners_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/categories/categories_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/blocs/products/products_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;
  final List<ProductModel> products = [
    ProductModel(
      images: [Images.productImg1],
      name: "Bayam Sayur Hidroponik",
      price: 11000,
    ),
    ProductModel(
      images: [Images.productImg2],
      name: "Kangkung Sayur Hidroponik",
      price: 12000,
    ),
    ProductModel(
      images: [Images.productImg3],
      name: "Sawi Pakcoy / Pak Choy / Bok Choy Sayur Hidroponik",
      price: 13000,
    ),
    ProductModel(
      images: [Images.productImg4],
      name: "Selada Merah / Lolorossa Sayur Hidroponik",
      price: 15000,
    ),
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(20.0),
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat Pengiriman',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: ColorName.grey,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Jakarta Pusat, DKI Jakarta',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorName.primary,
                        ),
                      ),
                      SpaceWidth(5.0),
                      Icon(
                        Icons.expand_more,
                        size: 18.0,
                        color: ColorName.grey,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  badges.Badge(
                    badgeContent: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () {
                            return const Text(
                              '0',
                              style: TextStyle(color: Colors.white),
                            );
                          },
                          loaded: (carts) {
                            int totalQty = 0;
                            for (var cart in carts) {
                              totalQty += cart.qty;
                            }
                            return Text(
                              totalQty.toString(),
                              style: const TextStyle(color: Colors.white),
                            );
                          },
                        );
                      },
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()),
                        );
                      },
                      icon: Image.asset(
                        Images.buyIcon,
                        height: 24.0,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SizedBox()),
                      );
                    },
                    icon: Image.asset(
                      Images.notificationIcon,
                      height: 24.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SpaceHeight(16.0),
          SearchInput(
            controller: searchController,
            onChanged: (keyword) {},
          ),
          const SpaceHeight(16.0),
          BlocBuilder<BannersBloc, BannersState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (model) {
                  List<String> bannerImages = [];
                  for (var e in model.data) {
                    bannerImages = [
                      ...bannerImages,
                      '${Variables.baseUrl}${e.attributes.gambar.data.attributes.url}'
                    ];
                  }
                  return ImageSlider(
                    items: bannerImages,
                  );
                },
                error: (message) {
                  return const Text('Gagal memuat data');
                },
              );
            },
          ),
          const SpaceHeight(12.0),
          const Text(
            'Kategori',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorName.primary,
            ),
          ),
          const SpaceHeight(12.0),
          BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (model) {
                  return SizedBox(
                    height: 125,
                    child: ListView.builder(
                      itemCount: model.data.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return CategoryButton(
                          imagePath:
                              '${Variables.baseUrl}${model.data[index].attributes.categoryIcon.data.attributes.url}',
                          label: model.data[index].attributes.name,
                          onPressed: () {},
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
          const SpaceHeight(16.0),
          const Text(
            'Produk',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ColorName.primary,
            ),
          ),
          const SpaceHeight(8.0),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (model) {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 55.0,
                    ),
                    itemCount: model.data.length,
                    itemBuilder: (context, index) => ProductCard(
                      data: model.data[index],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
