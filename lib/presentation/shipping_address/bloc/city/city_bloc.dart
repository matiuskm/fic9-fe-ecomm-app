import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/city_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_event.dart';
part 'city_state.dart';
part 'city_bloc.freezed.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(const _Initial()) {
    on<_GetAllByProvince>((event, emit) async {
      emit(const _Loading());
      final response = await RajaOngkirRemoteDatasource().getCities(event.provinceId);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir.results)),
      );
    });
  }
}
