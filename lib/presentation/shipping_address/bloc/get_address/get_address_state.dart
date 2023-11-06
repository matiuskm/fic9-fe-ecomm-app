part of 'get_address_bloc.dart';

@freezed
class GetAddressState with _$GetAddressState {
  const factory GetAddressState.initial() = _Initial;
  const factory GetAddressState.loading() = _Loading;
  const factory GetAddressState.loaded(List<GetAddress> data) = _Loaded;
  const factory GetAddressState.deleted(SingleAddressResponseModel data) = _Deleted;
  const factory GetAddressState.error(String message) = _Error;
}
