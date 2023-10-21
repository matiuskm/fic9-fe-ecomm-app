import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/common/constants/images.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Image.asset(
          Images.logo,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
