import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/core.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/city_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/province_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/subdistrict_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/add_address/add_address_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/city/city_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/province/province_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/presentation/shipping_address/bloc/subdistrict/subdistrict_bloc.dart';

import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isDefault = false;

  Province selectedProvince = Province(
    provinceId: "6",
    province: "DKI Jakarta",
  );

  City selectedCity = City(
    cityId: "152",
    provinceId: "6",
    province: "DKI Jakarta",
    type: "Kota",
    cityName: "Jakarta Pusat",
    postalCode: "10540",
  );

  Subdistrict selectedSubdistrict = Subdistrict(
      subdistrictId: "2095",
      provinceId: "6",
      province: "DKI Jakarta",
      cityId: "152",
      city: "Jakarta Pusat",
      type: "Kota",
      subdistrictName: "Cempaka Putih");

  @override
  void initState() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.getAll());
    super.initState();
  }

  @override
  void dispose() {
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
        title: const Text('Tambah Alamat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: nameController,
            label: 'Nama Lengkap',
            keyboardType: TextInputType.name,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat',
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.phone,
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-',
                    items: const ['-'],
                    label: 'Provinsi',
                    onChanged: (value) {},
                  );
                },
                loaded: (provinces) {
                  selectedProvince = provinces.first;
                  return CustomDropdown<Province>(
                    value: selectedProvince,
                    items: provinces,
                    label: 'Provinsi',
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
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {},
                  );
                },
                loaded: (cities) {
                  selectedCity = cities.first;
                  return CustomDropdown<City>(
                    value: selectedCity,
                    items: cities,
                    label: 'Kota/Kabupaten',
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
                    label: 'Kecamatan',
                    onChanged: (value) {},
                  );
                },
                loaded: (subdistricts) {
                  selectedSubdistrict = subdistricts.first;
                  return CustomDropdown<Subdistrict>(
                    value: selectedSubdistrict,
                    items: subdistricts,
                    label: 'Kecamatan',
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
          CheckboxListTile(
            value: isDefault,
            title: const Text('Jadikan alamat pengiriman utama'),
            onChanged: (value) {
              isDefault = value!;
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            state.maybeWhen(
                orElse: () {},
                success: (response) {
                  Navigator.pop(context, response);
                });
          },
          builder: (context, state) {
            return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () async {
                      final userId = (await AuthLocalDatasource().getUser()).id;
                      context
                          .read<AddAddressBloc>()
                          .add(AddAddressEvent.addAddress(
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
                          ));
                    },
                    label: 'Tambah Alamat',
                  );
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (message) => Button.filled(
                      onPressed: () {},
                      label: 'Error',
                    ));
          },
        ),
      ),
    );
  }
}
