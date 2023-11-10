import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/account/account_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/blocs/cart/cart_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/cart/cart_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/home/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CartPage(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: ColorName.primary,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.homeIcon)),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
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
                        totalQty > 9 ? "9+" : totalQty.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      );
                    },
                  );
                },
              ),
              badgeStyle: const badges.BadgeStyle(
                padding: EdgeInsets.all(2),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartPage()),
                  );
                },
                icon: Image.asset(
                  Images.cartIcon,
                  height: 24.0,
                ),
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.userIcon)),
            label: "",
          ),
        ],
      ),
    );
  }
}
