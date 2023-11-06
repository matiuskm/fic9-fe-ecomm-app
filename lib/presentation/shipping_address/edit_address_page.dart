import 'package:flutter/material.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';

import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';

class EditAddressPage extends StatefulWidget {
  final GetAddress data;
  const EditAddressPage({super.key, required this.data});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController provinceController;
  late TextEditingController zipCodeController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.data.attributes.name);
    addressController = TextEditingController(text: widget.data.attributes.street);
    cityController = TextEditingController(text: 'Jember');
    provinceController = TextEditingController(text: 'Jawa Timur');
    zipCodeController = TextEditingController(text: widget.data.attributes.zipcode);
    phoneNumberController =
        TextEditingController(text: widget.data.attributes.phone);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    provinceController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Alamat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField2(
            controller: nameController,
            label: 'Nama ',
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat',
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: cityController,
            label: 'Kota',
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: provinceController,
            label: 'Provinsi',
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Button.filled(
          onPressed: () {
            Navigator.pop(context);
          },
          label: 'Update Alamat',
        ),
      ),
    );
  }
}