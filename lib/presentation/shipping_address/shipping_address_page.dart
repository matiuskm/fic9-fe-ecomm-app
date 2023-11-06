// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/add_address_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/get_address/get_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/edit_address_page.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/widgets/address_tile.dart';

class ShippingAddressPage extends StatefulWidget {
  final String title;
  const ShippingAddressPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  int? selectedIndex;
  GetAddress? selectedAddress;

  @override
  void initState() {
    context.read<GetAddressBloc>().add(const GetAddressEvent.getAddress());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(builder: (context) => const AddAddressPage()),
              )
                  .then((value) {
                context
                    .read<GetAddressBloc>()
                    .add(const GetAddressEvent.getAddress());
                setState(() {});
              });
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<GetAddressBloc, GetAddressState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
                child: Text('Belum ada alamat pengiriman.'),
              );
            },
            loaded: (addresses) {
              return ListView.separated(
                padding: const EdgeInsets.all(16.0),
                separatorBuilder: (context, index) => const SpaceHeight(16.0),
                itemCount: addresses.length,
                itemBuilder: (context, index) => AddressTile(
                  isSelected: selectedIndex == addresses[index].id,
                  isDefault: addresses[index].attributes.isDefault,
                  data: addresses[index],
                  onTap: () {
                    setState(() {
                      selectedIndex = addresses[index].id;
                    });
                    selectedAddress = addresses[index];
                  },
                  onEditTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAddressPage(
                          data: addresses[index],
                        ),
                      ),
                    );
                  },
                  onDeleteTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: const Text('Konfirmasi'),
                            content: const Text('Alamat akan dihapus. Yakin?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.read<GetAddressBloc>().add(
                                      GetAddressEvent.deleteAddress(
                                          addresses[index].id));

                                  context
                                      .read<GetAddressBloc>()
                                      .add(const GetAddressEvent.getAddress());
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ya'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Tidak'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Button.filled(
          disabled: selectedAddress == null,
          onPressed: () {
            Navigator.pop(context, selectedAddress);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const OrderDetailPage()),
            // );
          },
          label: 'Pilih',
        ),
      ),
    );
  }
}
