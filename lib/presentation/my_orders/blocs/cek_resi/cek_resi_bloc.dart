import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fic9_ecommerce_app/data/datasources/rajaongkir_remote_datasource.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/waybill_failed_response_model.dart';
import 'package:flutter_fic9_ecommerce_app/data/models/responses/waybill_success_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cek_resi_event.dart';
part 'cek_resi_state.dart';
part 'cek_resi_bloc.freezed.dart';

class CekResiBloc extends Bloc<CekResiEvent, CekResiState> {
  CekResiBloc() : super(const _Initial()) {
    on<_CekResi>((event, emit) async {
      emit(const _Loading());
      final response =
          await RajaOngkirRemoteDatasource().cekResi(event.awb, event.courier);
      response.fold((l) => emit(_Error(l)), (r) => emit(_Loaded(r)));
    });
  }
}
