import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Pembayaran Sukses',
          desc: 'Selamat! Pembayaran berhasil.',
          btnOkOnPress: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const DashboardPage()));
          }).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
