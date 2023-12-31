import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/rajaongkir/province_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'province_event.dart';
part 'province_state.dart';
part 'province_bloc.freezed.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  ProvinceBloc() : super(const _Initial()) {
    on<_GetAll>((event, emit) async {
      emit(const _Loading());
      final response = await RajaOngkirRemoteDatasource().getProvinces();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.rajaongkir.results)),
      );
    });
  }
}
