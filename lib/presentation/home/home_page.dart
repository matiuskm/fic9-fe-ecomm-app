import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

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
    final List<String> images = [
      Images.banner1,
      Images.banner2,
      Images.banner3,
    ];

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
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SizedBox()),
                      );
                    },
                    icon: Image.asset(
                      Images.buyIcon,
                      height: 24.0,
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
          ImageSlider(items: images),
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
          Row(
            children: [
              Flexible(
                child: CategoryButton(
                  imagePath: Images.fruitsIcon,
                  label: 'Buah',
                  onPressed: () {},
                ),
              ),
              Flexible(
                child: CategoryButton(
                  imagePath: Images.vegetableIcon,
                  label: 'Sayur',
                  onPressed: () {},
                ),
              ),
              Flexible(
                child: CategoryButton(
                  imagePath: Images.organicIcon,
                  label: 'Organik',
                  onPressed: () {},
                ),
              ),
              Flexible(
                child: CategoryButton(
                  imagePath: Images.hydrophonicIcon,
                  label: 'Hidroponik',
                  onPressed: () {},
                ),
              ),
            ],
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 55.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => ProductCard(
              data: products[index],
            ),
          ),
        ],
      ),
    );
  }
}
