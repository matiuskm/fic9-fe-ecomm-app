part of 'add_address_bloc.dart';

@freezed
class AddAddressEvent with _$AddAddressEvent {
  const factory AddAddressEvent.started() = _Started;
  const factory AddAddressEvent.addAddress({
    required String name,
    required String street,
    required String phone,
    required String provinceId,
    required String cityId,
    required String subdistrictId,
    required String provinceName,
    required String cityName,
    required String subdistrictName,
    required String zipcode,
    required int userId,
    required bool isDefault,
    required String label,
  }) = _AddAddress;
  const factory AddAddressEvent.updateAddress({
    required String id,
    required String name,
    required String street,
    required String phone,
    required String provinceId,
    required String cityId,
    required String subdistrictId,
    required String provinceName,
    required String cityName,
    required String subdistrictName,
    required String zipcode,
    required int userId,
    required bool isDefault,
    required String label,
  }) = _UpdateAddress;
}
