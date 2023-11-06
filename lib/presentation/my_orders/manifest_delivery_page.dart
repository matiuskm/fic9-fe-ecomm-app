// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/common/extensions/date_time_ext.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';

import 'package:flutter_fic9_ecommerce_app/data/models/responses/my_orders_responses_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/my_orders/blocs/cek_resi/cek_resi_bloc.dart';

class ManifestDeliveryPage extends StatefulWidget {
  const ManifestDeliveryPage({
    Key? key,
    required this.myOrder,
  }) : super(key: key);
  final MyOrder myOrder;

  @override
  State<ManifestDeliveryPage> createState() => _ManifestDeliveryPageState();
}

class _ManifestDeliveryPageState extends State<ManifestDeliveryPage> {
  List<StepperData> stepperData = [];

  @override
  void initState() {
    context.read<CekResiBloc>().add(CekResiEvent.cekResi(
          awb: widget.myOrder.attributes.awb,
          courier: widget.myOrder.attributes.shippingCourier,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lacak Pengiriman'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: BlocBuilder<CekResiBloc, CekResiState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.notFoundImg),
                      const Text('Nomor resi tidak ditemukan.'),
                    ],
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (data) {
                  int indexStep = 0;
                  stepperData = data.rajaongkir.result.manifest.map((e) {
                    indexStep++;
                    return StepperData(
                      title: StepperText(
                        e.manifestCode.isEmpty ? '-' : e.manifestCode,
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                      subtitle: StepperText(
                        '${e.manifestDate.toFormattedDateWithDay()} ${e.manifestTime} \n${e.manifestDescription}',
                      ),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Center(
                          child: Text(
                            '$indexStep',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList();
                  return AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.vertical,
                    iconWidth: 40,
                    iconHeight: 40,
                  );
                },
                error: (error) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Images.notFoundImg),
                      const Text('Nomor resi tidak ditemukan.'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
