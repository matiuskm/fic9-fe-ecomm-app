import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/city_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/province_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/subdistrict_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/add_address/add_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/city/city_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/province/province_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/subdistrict/subdistrict_bloc.dart';

import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';

class EditAddressPage extends StatefulWidget {
  final GetAddress data;
  const EditAddressPage({super.key, required this.data});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController labelController;
  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController addressController;
  late TextEditingController zipCodeController;
  late Province selectedProvince;
  late City selectedCity;
  late Subdistrict selectedSubdistrict;

  bool isDefault = false;

  @override
  void initState() {
    labelController = TextEditingController(text: widget.data.attributes.label);
    nameController = TextEditingController(text: widget.data.attributes.name);
    addressController =
        TextEditingController(text: widget.data.attributes.street);
    zipCodeController =
        TextEditingController(text: widget.data.attributes.zipcode);
    phoneNumberController =
        TextEditingController(text: widget.data.attributes.phone);
    context.read<ProvinceBloc>().add(const ProvinceEvent.getAll());
    isDefault = widget.data.attributes.isDefault;
    super.initState();
  }

  @override
  void dispose() {
    labelController.dispose();
    nameController.dispose();
    addressController.dispose();
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
          CustomTextField(
            controller: labelController,
            label: 'Label (Rumah/Kantor)',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: nameController,
            label: 'Nama ',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: addressController,
            label: 'Alamat',
          ),
          const SpaceHeight(24.0),
          CustomTextField(
            controller: phoneNumberController,
            label: 'No Handphone',
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Pilih Provinsi',
                    onChanged: (value) {},
                  );
                },
                loaded: (provinces) {
                  selectedProvince = provinces.firstWhere(
                      (e) => e.provinceId == widget.data.attributes.provinceId,
                      orElse: () => provinces.first);
                  context.read<CityBloc>().add(
                      CityEvent.getAllByProvince(selectedProvince.provinceId));
                  return CustomDropdown(
                    value: selectedProvince,
                    items: provinces,
                    label: 'Pilih Provinsi',
                    onChanged: (newVal) {
                      selectedProvince = newVal!;
                      context.read<CityBloc>().add(CityEvent.getAllByProvince(
                          selectedProvince.provinceId));
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Pilih Kota/Kabupaten',
                    onChanged: (newVal) {},
                  );
                },
                loaded: (cities) {
                  selectedCity = cities.firstWhere(
                      (e) => e.cityId == widget.data.attributes.cityId,
                      orElse: () => cities.first);
                  context.read<SubdistrictBloc>().add(
                      SubdistrictEvent.getAllByCityId(selectedCity.cityId));
                  return CustomDropdown(
                    value: selectedCity,
                    items: cities,
                    label: 'Pilih Kota/Kabupaten',
                    onChanged: (newVal) {
                      selectedCity = newVal!;
                      context.read<SubdistrictBloc>().add(
                          SubdistrictEvent.getAllByCityId(selectedCity.cityId));
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Pilih Kecamatan',
                    onChanged: (newVal) {},
                  );
                },
                loaded: (subdistrics) {
                  selectedSubdistrict = subdistrics.firstWhere(
                      (e) =>
                          e.subdistrictId ==
                          widget.data.attributes.subdistrictId,
                      orElse: () => subdistrics.first);
                  return CustomDropdown(
                    value: selectedSubdistrict,
                    items: subdistrics,
                    label: 'Pilih Kecamatan',
                    onChanged: (newVal) {
                      selectedSubdistrict = newVal!;
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return CheckboxListTile(
              value: isDefault,
              title: const Text('Jadikan alamat pengiriman utama'),
              onChanged: (value) {
                setState(() {
                  isDefault = value!;
                });
              },
            );
          })
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                update: (response) {
                  Navigator.pop(context, response);
                });
          },
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () async {
                      final userId = (await AuthLocalDatasource().getUser()).id;
                      if (context.mounted) {
                        context
                            .read<AddAddressBloc>()
                            .add(AddAddressEvent.updateAddress(
                              id: widget.data.id.toString(),
                              name: nameController.text,
                              street: addressController.text,
                              phone: phoneNumberController.text,
                              provinceId: selectedProvince.provinceId,
                              cityId: selectedCity.cityId,
                              subdistrictId: selectedSubdistrict.subdistrictId,
                              provinceName: selectedProvince.province,
                              cityName:
                                  '${selectedCity.type} ${selectedCity.cityName}',
                              subdistrictName:
                                  selectedSubdistrict.subdistrictName,
                              zipcode: zipCodeController.text,
                              userId: userId!,
                              isDefault: isDefault,
                              label: labelController.text,
                            ));
                      }
                    },
                    label: 'Update Alamat',
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (message) {
                  return Button.filled(
                    onPressed: () async {
                      final userId = (await AuthLocalDatasource().getUser()).id;
                      if (context.mounted) {
                        context
                            .read<AddAddressBloc>()
                            .add(AddAddressEvent.updateAddress(
                              id: widget.data.id.toString(),
                              name: nameController.text,
                              street: addressController.text,
                              phone: phoneNumberController.text,
                              provinceId: selectedProvince.provinceId,
                              cityId: selectedCity.cityId,
                              subdistrictId: selectedSubdistrict.subdistrictId,
                              provinceName: selectedProvince.province,
                              cityName:
                                  '${selectedCity.type} ${selectedCity.cityName}',
                              subdistrictName:
                                  selectedSubdistrict.subdistrictName,
                              zipcode: zipCodeController.text,
                              userId: userId!,
                              isDefault: isDefault,
                              label: labelController.text,
                            ));
                      }
                    },
                    label: 'Update Alamat',
                  );
                });
          },
        ),
      ),
    );
  }
}
