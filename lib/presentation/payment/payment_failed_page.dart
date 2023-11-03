import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Pembayaran Gagal',
        desc: 'Maaf proses pembayaran tidak berhasil.',
        btnOkOnPress: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const DashboardPage()));
        },
        btnOkColor: Colors.red,
        btnOkText: 'Close',
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
