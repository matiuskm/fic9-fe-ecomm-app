part of 'get_address_bloc.dart';

@freezed
class GetAddressEvent with _$GetAddressEvent {
  const factory GetAddressEvent.started() = _Started;
  const factory GetAddressEvent.getAddress() = _GetAddress;
  const factory GetAddressEvent.deleteAddress(int addressId) = _DeleteAddress;
  const factory GetAddressEvent.setAsDefaultAddress(int addressId, DefaultAddressRequestModel data) = _SetAsDefaultAddress;
}