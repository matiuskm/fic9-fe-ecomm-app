part of 'add_address_bloc.dart';

@freezed
class AddAddressState with _$AddAddressState {
  const factory AddAddressState.initial() = _Initial;
  const factory AddAddressState.loading() = _Loading;
  const factory AddAddressState.success(AddAddressResponseModel model) = _Success;
  const factory AddAddressState.update(AddAddressResponseModel model) = _Update;
  const factory AddAddressState.error(String message) = _Error;
}
