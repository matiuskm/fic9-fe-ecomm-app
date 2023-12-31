import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/order_remote_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/requests/add_address_request_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/add_address_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';
part 'add_address_bloc.freezed.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  AddAddressBloc() : super(const _Initial()) {
    on<_AddAddress>((event, emit) async {
      emit(const _Loading());
      final response =
          await OrderRemoteDatasource().addAddress(AddAddressRequestModel(
              data: AddAddress(
        name: event.name,
        street: event.street,
        completeAddress:
            '${event.street}, ${event.subdistrictName}, ${event.cityName}, ${event.provinceName}, ${event.zipcode}',
        phone: event.phone,
        provinceId: event.provinceId,
        cityId: event.cityId,
        subdistrictId: event.subdistrictId,
        zipcode: event.zipcode,
        userId: event.userId,
        isDefault: event.isDefault,
        label: event.label,
      )));
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });

    on<_UpdateAddress>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDatasource().updateAddress(
          event.id,
          AddAddressRequestModel(
              data: AddAddress(
            name: event.name,
            street: event.street,
            completeAddress:
                '${event.street}, ${event.subdistrictName}, ${event.cityName}, ${event.provinceName}, ${event.zipcode}',
            phone: event.phone,
            provinceId: event.provinceId,
            cityId: event.cityId,
            subdistrictId: event.subdistrictId,
            zipcode: event.zipcode,
            userId: event.userId,
            isDefault: event.isDefault,
            label: event.label,
          )));
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Update(r)),
      );
    });
  }
}
