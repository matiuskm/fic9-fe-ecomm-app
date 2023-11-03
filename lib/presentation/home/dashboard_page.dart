import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/colors.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/account/account_page.dart';
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
    const Center(
      child: Text('Explore Page'),
    ),
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
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.homeIcon)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.searchIcon)),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.cartIcon)),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Images.userIcon)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
